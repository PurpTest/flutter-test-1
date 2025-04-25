import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/cubit/product_list_cubit.dart';
import 'package:product_list/model/product_list_model.dart';
import 'package:product_list/pages/product_details.dart';
import 'package:product_list/service/navigator_service.dart';
import 'package:product_list/service/service_locator.dart';

Future<void> main() async {
  runApp(
    BlocProvider(
      create: (context) => ProductListCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: appRoutes,
        onGenerateRoute: (settings) {
          if (settings.name == '/details') {
            final ProductListModel? product = settings.arguments as ProductListModel?;
            if (product != null) {
              return MaterialPageRoute(
                builder: (context) => ProductDetails(product: product),
              );
            } else {
              return MaterialPageRoute(
                builder: (context) => const Scaffold(
                  body: Center(child: Text('Error: No product data provided')),
                ),
              );
            }
          }
          return null;
        },
      ),
    ),
  );
}
