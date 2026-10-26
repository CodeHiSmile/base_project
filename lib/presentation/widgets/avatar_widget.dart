import 'package:base_ui/base_ui.dart';
import 'package:base_project/generated/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:base_project/app/themes/app_colors.dart';

class AvatarWidget extends StatelessWidget {
  final String? url;
  final double size;
  final VoidCallback? onTap;

  const AvatarWidget({super.key, this.url, this.size = 40, this.onTap});

  @override
  Widget build(BuildContext context) {
    final physicalSize = (size * MediaQuery.devicePixelRatioOf(context)).ceil();
    final cacheSize = physicalSize > 0 ? physicalSize : 1;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: AppColors.neutral200),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: (url != null && url!.isNotEmpty)
              ? CachedNetworkImage(
                  imageUrl: url!,
                  // Cache ảnh đã giải mã theo kích thước avatar, không giữ ảnh gốc lớn.
                  memCacheWidth: cacheSize,
                  memCacheHeight: cacheSize,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return LoadingCacheImageWidget(
                      loadingSize: 25,
                      progress: downloadProgress.progress,
                    );
                  },
                  errorWidget: (context, url, error) {
                    return _buildDefaultAvatar();
                  },
                )
              : _buildDefaultAvatar(),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: AppColors.neutral100,
      alignment: Alignment.bottomCenter,
      child: MyAssets.icons.iconUserBold.svg(
        width: size * 0.8,
        height: size * 0.8,
        colorFilter: const ColorFilter.mode(
          AppColors.neutral400,
          BlendMode.srcIn,
        ),
      ),
      // Icon(Icons.person, size: size * 0.8, color: AppColors.neutral400),
    );
  }
}
