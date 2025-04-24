import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:product_list/model/product_list_model.dart';
import 'package:product_list/service/product_list_service.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(const ProductListInitial([]));

  Future<void> loadProductList(ProductListApi productListService) async {
    try {
      await productListService.fetchProductList();
    } catch (e) {
      throw Exception('Failed to load posts');
    }
  }
}
