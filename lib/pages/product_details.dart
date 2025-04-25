import 'package:flutter/material.dart';
import 'package:product_list/model/product_list_model.dart';

class ProductDetails extends StatelessWidget {
  final ProductListModel product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight * 0.3,
            width: double.infinity,
            color: Colors.red,
            child: const Text("Picture"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title),
                Text('\$${product.price}'),
                Row(
                  children: [
                    Text("${product.rating["rate"]}"),
                    const Icon(
                      Icons.star,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
