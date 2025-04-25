import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_list/model/product_list_model.dart';
import 'package:product_list/utils/pop_up_util.dart';

class ProductDetails extends StatelessWidget {
  final ProductListModel product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded),
            color: Colors.black,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.4,
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.white
                          // gradient: LinearGradient(
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          //   colors: [
                          //     Color(0xFF3D7A99), // Green shade matching the image
                          //     Color(0xFF66CCFF),
                          //   ],
                          // ),
                          ),
                      child: Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              height: screenHeight * 0.3,
                              // width: screenWidth * 0.8,
                              // color: Colors.grey,
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      imagePreviewDialog(
                                        context: context,
                                        imageUrl: product.image,
                                      );
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: product.image,
                                      placeholder: (context, url) =>
                                          const SizedBox(
                                        width: 100,
                                        height: 50,
                                      ),
                                      errorWidget: (context, url, error) {
                                        return Container(
                                          width: screenWidth * 0.25,
                                          height: 50,
                                          color: Colors.grey,
                                          child: Icon(
                                            Icons.error,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // Positioned(child: child)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.7,
                                child: Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 14,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text("${product.rating["rate"]}"),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Text('\$${product.price}'),
                          Text(
                            "(${product.rating["count"]} reviews)",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            product.description,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey[200],
              thickness: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
