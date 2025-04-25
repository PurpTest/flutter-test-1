import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:product_list/component/category.dart';
import 'package:product_list/component/zoom_image.dart';
import 'package:product_list/cubit/product_list_cubit.dart';

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

void categoryDialog({
  required BuildContext context,
  required List<String> category,
  required ProductListCubit productListCubit,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return Category(
          category: category,
          cubit: productListCubit,
        );
      });
}
