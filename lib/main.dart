import 'package:flutter/material.dart';
import 'package:product_list/service/navigator_service.dart';
import 'package:product_list/service/product_list_service.dart';
import 'package:product_list/service/service_locator.dart';

Future<void> main() async {
  await _registerDependencies();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: appRoutes,
  ));
}

Future<void> _registerDependencies() async {
  sl.registerLazySingleton<ProductListApi>(() => ProductListApi());
}
