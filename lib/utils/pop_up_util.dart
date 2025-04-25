import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:product_list/component/zoom_image.dart';

void imagePreviewDialog({
  required BuildContext context,
  required String imageUrl,
}) {
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return ImageZoom(imageUrl: imageUrl);
      });
}
