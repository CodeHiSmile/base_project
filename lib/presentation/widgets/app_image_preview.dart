import 'dart:io';

import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:base_project/app/themes/app_colors.dart';
import 'package:base_project/presentation/widgets/app_image_preview_page.dart';

@immutable
class AppPreviewSource {
  const AppPreviewSource(
    this.url, {
    this.isLocal = false,
    this.errorImageAsset,
  });

  final String url;
  final bool isLocal;
  final String? errorImageAsset;
}

/// Giữ nguyên thumbnail; chỉ thêm thao tác đọc ảnh, không thay đổi dữ liệu.
class AppImagePreview extends StatefulWidget {
  const AppImagePreview({
    super.key,
    required this.source,
    required this.child,
    this.images,
    this.index,
    this.enabled = true,
  });

  final AppPreviewSource source;
  final List<AppPreviewSource>? images;
  final int? index;
  final bool enabled;
  final Widget child;

  @override
  State<AppImagePreview> createState() => _AppImagePreviewState();
}

class _AppImagePreviewState extends State<AppImagePreview> {
  bool _opening = false;

  Future<void> _open() async {
    if (_opening) return;
    final candidates = widget.images ?? [widget.source];
    final selected = widget.index ?? 0;
    final images = <AppPreviewSource>[];
    var initialIndex = 0;
    for (var i = 0; i < candidates.length; i++) {
      if (candidates[i].url.trim().isEmpty) continue;
      if (i == selected) initialIndex = images.length;
      images.add(candidates[i]);
    }
    if (images.isEmpty) return;
    _opening = true;
    try {
      await Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (_) => images.any((image) => image.isLocal)
              ? AppImagePreviewPage(images: images, initialIndex: initialIndex)
              : images.length > 1
              ? ImagesPreviewWidget(
                  images: images
                      .map((image) => ImageEntity(url: image.url))
                      .toList(),
                  index: initialIndex,
                  errorImageAsset: widget.source.errorImageAsset,
                )
              : ImagePreview(
                  url: images.first.url,
                  errorImageAsset: widget.source.errorImageAsset,
                ),
        ),
      );
    } finally {
      _opening = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled || widget.source.url.trim().isEmpty) {
      return widget.child;
    }
    return Semantics(
      button: true,
      label: 'Xem ảnh toàn màn hình',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _open,
        child: widget.child,
      ),
    );
  }
}

/// Thumbnail dùng chung cho ảnh từ server và ảnh nháp trên máy.
class AppPreviewImage extends StatelessWidget {
  const AppPreviewImage(
    this.url, {
    super.key,
    this.size,
    this.fit,
    this.borderRadius,
    this.errorImageAsset,
    this.isLocal = false,
    this.enabled = true,
    this.images,
    this.index,
  });

  final String url;
  final Size? size;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  final String? errorImageAsset;
  final bool isLocal;
  final bool enabled;
  final List<AppPreviewSource>? images;
  final int? index;

  @override
  Widget build(BuildContext context) {
    if (!isLocal && !(images?.any((image) => image.isLocal) ?? false)) {
      return ImageWidget(
        url,
        size: size,
        fit: fit,
        borderRadius: borderRadius,
        errorImageAsset: errorImageAsset,
        enableShowPreview: enabled,
        listImage: images?.map((image) => ImageEntity(url: image.url)).toList(),
        currentIndex: index,
      );
    }
    final source = AppPreviewSource(
      url,
      isLocal: isLocal,
      errorImageAsset: errorImageAsset,
    );
    return AppImagePreview(
      source: source,
      images: images,
      index: index,
      enabled: enabled,
      child: isLocal
          ? ClipRRect(
              borderRadius: borderRadius ?? BorderRadius.zero,
              child: Image.file(
                File(url),
                width: size?.width,
                height: size?.height,
                fit: fit ?? BoxFit.cover,
                errorBuilder: (_, _, _) => _buildError(),
              ),
            )
          : ImageWidget(
              url,
              size: size,
              fit: fit,
              borderRadius: borderRadius,
              errorImageAsset: errorImageAsset,
            ),
    );
  }

  Widget _buildError() {
    if (errorImageAsset != null) {
      return Image.asset(
        errorImageAsset!,
        width: size?.width,
        height: size?.height,
        fit: fit ?? BoxFit.cover,
      );
    }
    return SizedBox(
      width: size?.width,
      height: size?.height,
      child: const ColoredBox(
        color: AppColors.neutral100,
        child: Center(
          child: Icon(BaseIconsLinear.gallery, color: AppColors.neutral400),
        ),
      ),
    );
  }
}
