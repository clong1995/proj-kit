import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';

class Avatar extends StatelessWidget {
  final String? imageUrl;
  final double? size;
  final String? package;

  const Avatar({
    super.key,
    this.imageUrl,
    this.size,
    this.package,
  });

  @override
  Widget build(BuildContext context) {
    double size = this.size ?? 50.r;
    return SizedBox(
      height: size,
      width: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: imageUrl == null
              ? Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: size / 1.3,
                )
              : ClipOval(
                  child: imageUrl!.startsWith("http")
                      ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          imageUrl!,
                          fit: BoxFit.fill,
                          package: package,
                        ),
                ),
        ),
      ),
    );
  }
}
