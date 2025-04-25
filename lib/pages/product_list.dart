import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/cubit/product_list_cubit.dart';
import 'package:product_list/utils/pop_up_util.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ProductListCubit _productListCubit;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productListCubit = BlocProvider.of<ProductListCubit>(context);
    _productListCubit.loadProductList();
    _searchController.addListener(() {
      _productListCubit.filterProducts(_searchController.text);
    });
  }

  // Extract unique categories from the product list
  List<String> _getCategories(ProductListState state) {
    if (state is ProductListUpdated) {
      return state.products
          .map((product) => product.category)
          .where((category) => category.isNotEmpty)
          .toSet()
          .toList();
    }
    return [];
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final crossAxisCount = (screenWidth / 180).floor().clamp(2, 4);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(102, 204, 255, 1),
        title: const Text(
          "Shopi",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Product',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                          });
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<ProductListCubit, ProductListState>(
          builder: (context, productListState) {
            if (productListState is ProductListUpdating) {
              return const Center(child: CircularProgressIndicator());
            } else if (productListState is ProductListUpdateError) {
              return Center(child: Text(productListState.error));
            } else if (productListState is ProductListUpdated) {
              if (productListState.filteredProducts.isEmpty &&
                  productListState.products.isEmpty) {
                return const Center(child: Text('No products available'));
              } else if (productListState.filteredProducts.isEmpty) {
                return const Center(child: Text('No products found'));
              }
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        categoryDialog(
                          context: context,
                          category: _getCategories(productListState),
                          productListCubit: _productListCubit,
                        );
                      },
                      icon: const Icon(
                        Icons.filter_alt_sharp,
                      ),
                    ),
                    Text(
                      "${productListState.filteredProducts.length.toString()} Items",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: productListState.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = productListState.filteredProducts[index];
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/details',
                              arguments: product,
                            );
                          },
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            child: Column(
                              children: [
                                // Image placeholder
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.10,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(8),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(product.image),
                                  ),
                                  // color: Colors.red, // Replace with Image.network if available
                                  // Example: Image.network(_product_list[index].image, fit: BoxFit.cover),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                          // fontSize: screenWidth * 0.0335,
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "\$${product.price}",
                                        style: const TextStyle(
                                          // fontSize: screenWidth * 0.0335,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            " ${product.rating["rate"]} ",
                                            style: const TextStyle(
                                              // fontSize: screenWidth * 0.035,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                            size: 14,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "(${product.rating["count"]})",
                                            style: TextStyle(
                                              color: Colors.grey[300],
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                5,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: const Text(
                                            'Add to Cart',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
