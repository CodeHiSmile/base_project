import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:base_ui/base_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:base_project/app/themes/app_colors.dart';
import 'package:base_project/presentation/widgets/core/layout_page.dart';

/// Enum to distinguish between local asset and network PDF sources.
enum PdfSource { asset, url }

/// Arguments passed when navigating to [PdfViewerPage].
///
/// - [title]: the AppBar title.
/// - [pdfSource]: whether the PDF comes from a local asset or a URL.
/// - [assetPath]: the asset path (e.g. 'assets/pdf/privacy-policy.pdf').
/// - [url]: the network URL of the PDF.
class PdfViewerArguments {
  final String title;
  final PdfSource pdfSource;
  final String? assetPath;
  final String? url;

  const PdfViewerArguments({
    required this.title,
    required this.pdfSource,
    this.assetPath,
    this.url,
  });
}

class PdfViewerPage extends StatefulWidget {
  final PdfViewerArguments? arguments;

  const PdfViewerPage({super.key, this.arguments});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String? _localFilePath;
  bool _isLoading = true;
  String? _errorMessage;
  int _totalPages = 0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final args = widget.arguments;
      if (args == null) {
        setState(() {
          _errorMessage = 'Không có thông tin PDF';
          _isLoading = false;
        });
        return;
      }

      String filePath;

      if (args.pdfSource == PdfSource.asset) {
        filePath = await _loadFromAsset(args.assetPath!);
      } else {
        filePath = await _loadFromUrl(args.url!);
      }

      setState(() {
        _localFilePath = filePath;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Không thể tải PDF: $e';
        _isLoading = false;
      });
    }
  }

  /// Copy an asset PDF into a temporary file and return the path.
  Future<String> _loadFromAsset(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();
    final dir = await getTemporaryDirectory();
    final fileName = assetPath.split('/').last;
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }

  /// Download a PDF from a URL into a temporary file and return the path.
  Future<String> _loadFromUrl(String url) async {
    final dio = Dio();
    final dir = await getTemporaryDirectory();
    final fileName = 'pdf_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final filePath = '${dir.path}/$fileName';

    await dio.download(url, filePath);
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      title: widget.arguments?.title ?? 'PDF',
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: context.colors.primary),
            SizedBox(height: 16),
            Text(
              'Đang tải PDF...',
              style: context.textStyles.body2Regular.copyWith(
                color: AppColors.neutral600,
              ),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 48, color: AppColors.neutral400),
              SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: context.textStyles.body2Regular.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _errorMessage = null;
                  });
                  _loadPdf();
                },
                child: Text(
                  'Thử lại',
                  style: context.textStyles.body2SemiBold.copyWith(
                    color: context.colors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        SizedBox.expand(
          child: PDFView(
            filePath: _localFilePath!,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            fitPolicy: FitPolicy.BOTH,
            onRender: (pages) {
              setState(() {
                _totalPages = pages ?? 0;
              });
            },
            onViewCreated: (controller) {},
            onPageChanged: (page, total) {
              setState(() {
                _currentPage = page ?? 0;
                _totalPages = total ?? 0;
              });
            },
            onError: (error) {
              setState(() {
                _errorMessage = 'Lỗi hiển thị PDF: $error';
              });
            },
          ),
        ),
        if (_totalPages > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_currentPage + 1} / $_totalPages',
                    style: context.textStyles.body2Medium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
