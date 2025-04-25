import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_list/model/category_model.dart';
import 'package:product_list/model/product_list_model.dart';
// import 'package:product_list/service/product_list_service.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(const ProductListInitial([], []));

  // Store the current filter criteria and search query
  FilterCriteria _filterCriteria = FilterCriteria();
  String _searchQuery = '';

  // Public getter for _searchQuery
  String get searchQuery => _searchQuery;

  Future<void> loadProductList() async {
    try {
      emit(const ProductListUpdating([], []));

      final response = await http.get(
        Uri.parse("https://fakestoreapi.com/products"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Response Body:\n${response.body}');

        final products = data
            .map((e) => ProductListModel.fromJson(e as Map<String, dynamic>))
            .toList();
        // for (var prod in products) {
        //   print('Title: ${prod.rating['rate']}');
        // }

        // print(response.reasonPhrase);
        emit(ProductListUpdated(products, products));
      } else {
        emit(ProductListUpdateError(const [], const [],
            "Error Loading Product: ${response.reasonPhrase.toString()}"));
      }
    } catch (e) {
      emit(ProductListUpdateError(
          const [], const [], "Error Loading Product: ${e.toString()}"));
    }
  }

  void filterProducts(String query, {FilterCriteria? criteria}) {
    final state = this.state;
    if (state is ProductListUpdated) {
      _searchQuery = query;
      if (criteria != null) {
        _filterCriteria = criteria;
      }
      // Start with the full product list
      List<ProductListModel> filtered = state.products;
      if (_searchQuery.isNotEmpty) {
        // Filter products by title (case-insensitive)
        filtered = filtered
            .where((product) => product.title
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
            .toList();
      }

      if (!_filterCriteria.isEmpty()) {
        filtered = filtered.where((product) {
          bool matches = true;

          if (_filterCriteria.category != null &&
              _filterCriteria.category!.isNotEmpty) {
            matches = matches && product.category == _filterCriteria.category;
          }
          return matches;
        }).toList();
      }
      emit(ProductListUpdated(state.products, filtered));
    }
  }

  // Method to reset filters
  void resetFilters() {
    _filterCriteria = FilterCriteria();
    filterProducts(_searchQuery);
  }
}
