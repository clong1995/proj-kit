import 'package:flutter/material.dart';
import 'package:ui_cache_image/ui_cache_image.dart';

class CachedImage {
  static Widget image({required String imageUrl, BoxFit? fit}) {
    return UiCacheImage(
      imageUrl,
      fit: fit,
    );
  }
}
