import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import './size.dart';

class SImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final Color color;
  final Color bgColor;
  final Color errorColor;
  final BlendMode colorBlendMode;
  final bool loading;
  final BorderRadius? borderRadius;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;

  const SImage(
    this.url, {
    Key? key,
    this.width,
    this.height,
    this.fit: BoxFit.cover,
    this.alignment: Alignment.center,
    this.color: const Color(0xff2f2e3c),
    this.bgColor: const Color(0xfff5f5f5),
    this.errorColor: const Color(0xffb3b3b3),
    this.colorBlendMode: BlendMode.dstATop,
    this.loading: true,
    this.borderRadius,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _err = Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        color: bgColor,
      ),
      child: Icon(Icons.filter, color: errorColor, size: 55.s),
    );

    if (url == null || !Uri.parse(url!).isAbsolute) {
      return _err;
    }

    Widget img = OptimizedCacheImage(
      imageUrl: url!,
      fadeOutDuration: Duration(milliseconds: 50),
      fadeInDuration: Duration(milliseconds: 50),
      maxWidthDiskCache: maxWidthDiskCache ?? 1200.w.toInt(),
      maxHeightDiskCache: maxHeightDiskCache ?? 1200.w.toInt(),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
            alignment: alignment,
            colorFilter: ColorFilter.mode(color, colorBlendMode),
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          color: bgColor,
        ),
        child: CupertinoActivityIndicator(),
      ),
      errorWidget: (context, url, error) {
        return _err;
      },
    );

    return Container(child: img, width: width, height: height);
  }
}
