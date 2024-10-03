import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetImageWidget extends StatelessWidget {
  final String assets;
  final double height;
  final double width;
  final BoxFit fit;
  final Color? color;
  final BlendMode? blendMode;

  const AssetImageWidget({
    Key? key,
    required this.assets,
    required this.height,
    required this.width,
    this.fit = BoxFit.contain,
    this.color,
    this.blendMode,
  }) : super(key: key);

  bool isLottieAssets(String assets) => assets.split('.').last.contains('json');

  bool isSvgAssets(String assets) => assets.split('.').last.contains('svg');

  @override
  Widget build(BuildContext context) {
  if (isSvgAssets(assets)) {
      return SvgPicture.asset(
        assets,
        width: width,
        height: height,
        fit: fit,
        colorFilter: color != null
            ? ColorFilter.mode(color!, blendMode ?? BlendMode.dst)
            : null,
      );
    }
    return Image.asset(
      assets,
      height: height,
      width: width,
      fit: fit,
      color: color,
    );
  }
}
