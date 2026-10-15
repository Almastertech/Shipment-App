import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/utils/image_url_optimizer.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.error,
    this.memCacheWidth,
    this.memCacheHeight,
    this.fadeInDuration = const Duration(milliseconds: 220),
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final WidgetBuilder? placeholder;
  final WidgetBuilder? error;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final Duration fadeInDuration;

  @override
  Widget build(BuildContext context) {
    final optimizedUrl = ImageUrlOptimizer.optimize(
      imageUrl,
      width: memCacheWidth,
      height: memCacheHeight,
    );

    final image = CachedNetworkImage(
      imageUrl: optimizedUrl,
      width: width,
      height: height,
      fit: fit,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      fadeInDuration: fadeInDuration,
      placeholder: (context, _) {
        if (placeholder != null) {
          return placeholder!(context);
        }
        return Container(
          width: width,
          height: height,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        );
      },
      errorWidget: (context, _, __) {
        if (error != null) {
          return error!(context);
        }
        return Container(
          width: width,
          height: height,
          color: Theme.of(context).colorScheme.errorContainer,
          child: Icon(
            Icons.broken_image_outlined,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        );
      },
    );

    final radius = borderRadius;
    if (radius == null) {
      return image;
    }

    return ClipRRect(
      borderRadius: radius,
      child: image,
    );
  }
}
