import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageZoom extends StatefulWidget {
  final String imageUrl;
  const ImageZoom({super.key, required this.imageUrl});

  @override
  State<ImageZoom> createState() => _ImageZoomState();
}

class _ImageZoomState extends State<ImageZoom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
          ),
        ),
      ),
    );
  }
}
