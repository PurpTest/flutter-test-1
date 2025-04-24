import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:product_list/model/product_list_model.dart';

late List<ProductListModel> products;

class ProductListApi {
  Future<List<ProductListModel>> fetchProductList() async {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );

    try {
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        // print('Response Body:\n${response.body}');

        products = data.map((e) => ProductListModel.fromJson(e as Map<String, dynamic>)).toList();
        for (var prod in products) {
          print('Title: ${prod.rating['rate']}');
        }
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print('Error: $e');
    }
    return products;
  }
}
