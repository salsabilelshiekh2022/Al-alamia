import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../generated/app_assets.dart';

class CustomCachedImageWidget extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget Function(BuildContext, String)? placeholder;
  const CustomCachedImageWidget({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: path,
      width: width,
      height: height,
      fit: fit ?? BoxFit.fill,
      placeholder: placeholder,
      errorWidget: (context, url, error) =>
          Image.asset(AppAssets.imagesLogo, fit: BoxFit.contain),
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      placeholderFadeInDuration: Duration.zero,
    );
  }
}
