import 'dart:io';

import 'package:base_ui/base_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:base_project/app/themes/app_colors.dart';
import 'package:base_project/presentation/widgets/app_image_preview.dart';

class AppImagePreviewPage extends StatefulWidget {
  const AppImagePreviewPage({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  final List<AppPreviewSource> images;
  final int initialIndex;

  @override
  State<AppImagePreviewPage> createState() {
    return _AppImagePreviewPageState();
  }
}

class _AppImagePreviewPageState extends State<AppImagePreviewPage> {
  late final PageController _controller;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _controller = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral900,
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  _index = index;
                });
              },
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  key: ValueKey(index),
                  minScale: 1,
                  maxScale: 4,
                  child: Center(child: _buildImage(widget.images[index])),
                );
              },
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.neutral900.withValues(
                      alpha: 0.8,
                    ),
                    minimumSize: const Size(48, 48),
                  ),
                  tooltip: 'Đóng ảnh',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    BaseIconsLinear.close_circle,
                    color: context.colors.backgroundWhite,
                  ),
                ),
                const Spacer(),
                if (widget.images.length > 1)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.neutral900.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${_index + 1}/${widget.images.length}',
                        style: context.textStyles.body2SemiBold.copyWith(
                          color: context.colors.backgroundWhite,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(AppPreviewSource source) {
    if (source.isLocal) {
      return Image.file(
        File(source.url.trim()),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) {
          return _buildError(source);
        },
      );
    }
    final url = source.url.trim();
    return CachedNetworkImage(
      imageUrl: StringUtils.transformImageLink(img: url, relative: url),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.contain,
      placeholder: (_, _) {
        return const Center(child: CircularProgressIndicator());
      },
      errorWidget: (_, _, _) {
        return _buildError(source);
      },
    );
  }

  Widget _buildError(AppPreviewSource source) {
    if (source.errorImageAsset != null) {
      return Image.asset(
        source.errorImageAsset!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.contain,
      );
    }
    return Center(
      child: Text(
        'Không thể tải ảnh',
        style: context.textStyles.body2Regular.copyWith(
          color: context.colors.backgroundWhite,
        ),
      ),
    );
  }
}
