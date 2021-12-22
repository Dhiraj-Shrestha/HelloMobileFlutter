import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';

class ProductDetailImage extends StatelessWidget {
  final String tag;
  final String image;

  const ProductDetailImage({Key key, this.tag, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 1,
        child: Hero(
          tag: tag,
          child: ClipRect(
            child: PhotoView(
              maxScale: MediaQuery.of(context).size.height / 2,
              filterQuality: FilterQuality.high,
              customSize: MediaQuery.of(context).size,
              // basePosition: Alignment.bottomLeft,
              imageProvider: NetworkImage(
                image,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
