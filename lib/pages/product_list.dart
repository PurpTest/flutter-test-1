import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/cubit/product_list_cubit.dart';
import 'package:product_list/model/product_list_model.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ProductListCubit _productListCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productListCubit = BlocProvider.of<ProductListCubit>(context);
    _productListCubit.loadProductList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final crossAxisCount = (screenWidth / 250).floor().clamp(1, 4);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: BlocBuilder<ProductListCubit, ProductListState>(
          builder: (context, productListState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${productListState.products.length.toString()} Items",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: productListState.products.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: screenWidth * 0.02,
                            mainAxisSpacing: screenWidth * 0.02,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: productListState.products.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 2,
                              color: Colors.grey[350],
                              child: Center(
                                child: Column(
                                  children: [
                                    // Image placeholder
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.10,
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
                                            "Name: ${productListState.products[index].title}",
                                            style: const TextStyle(
                                              // fontSize: screenWidth * 0.0335,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Price: ${productListState.products[index].price}",
                                            style: const TextStyle(
                                              // fontSize: screenWidth * 0.0335,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Rate: ${productListState.products[index].rating["rate"]} (${productListState.products[index].rating["count"]} Reviews)",
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
            );
          },
        ),
      ),
    );
  }
}
