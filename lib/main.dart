import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/cubit/product_list_cubit.dart';
import 'package:product_list/service/navigator_service.dart';
import 'package:product_list/service/service_locator.dart';

Future<void> main() async {
  runApp(BlocProvider(
    create: (context) => ProductListCubit(),
    child: MaterialApp(
      initialRoute: '/',
      routes: appRoutes,
    ),
  ));
}
