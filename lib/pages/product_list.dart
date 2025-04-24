import 'package:flutter/material.dart';
import 'package:product_list/model/product_list_model.dart';
import 'package:product_list/service/service_locator.dart';

import '../service/product_list_service.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ProductListApi _productListService;
  List<ProductListModel> _product_list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productListService = sl.get<ProductListApi>();
    loadProductList();
  }

  Future<void> loadProductList() async {
    try {
      _product_list = await _productListService.fetchProductList();
      setState(() {});
      print(_product_list.length);
    } catch (e) {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final crossAxisCount = (screenWidth / 250).floor().clamp(1, 4);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${_product_list.length.toString()} Items",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: _product_list.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: screenWidth * 0.02,
                        mainAxisSpacing: screenWidth * 0.02,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: _product_list.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          color: Colors.grey[350],
                          child: Center(
                            child: Column(
                              children: [
                                // Image placeholder
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.15,
                                  width: double.infinity,
                                  // color: Colors.red, // Replace with Image.network if available
                                  // Example: Image.network(_product_list[index].image, fit: BoxFit.cover),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.03),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name: ${_product_list[index].title}",
                                        style: const TextStyle(
                                          // fontSize: screenWidth * 0.0335,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Price: ${_product_list[index].price}",
                                        style: const TextStyle(
                                          // fontSize: screenWidth * 0.0335,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Rate: ${_product_list[index].rating["rate"]} (${_product_list[index].rating["count"]} Reviews)",
                                        style: const TextStyle(
                                          // fontSize: screenWidth * 0.035,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
