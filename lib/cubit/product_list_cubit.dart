import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_list/model/product_list_model.dart';
// import 'package:product_list/service/product_list_service.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(const ProductListInitial([]));

  Future<void> loadProductList() async {
    try {
      emit(const ProductListUpdating([]));

      final response = await http.get(
        Uri.parse("https://fakestoreapi.com/products"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Response Body:\n${response.body}');

        final products = data.map((e) => ProductListModel.fromJson(e as Map<String, dynamic>)).toList();
        // for (var prod in products) {
        //   print('Title: ${prod.rating['rate']}');
        // }

        // print(response.reasonPhrase);
        emit(ProductListUpdated(products));
      } else {
        emit(ProductListUpdateError(const [], "Error Loading Product: ${response.reasonPhrase.toString()}"));
      }
    } catch (e) {
      emit(ProductListUpdateError(const [], "Error Loading Product: ${e.toString()}"));
    }
  }
}
