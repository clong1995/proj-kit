import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage {
  static Widget image({required String imageUrl, BoxFit? fit}) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
    );
  }
}
