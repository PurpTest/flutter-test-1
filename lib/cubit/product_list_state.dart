part of 'product_list_cubit.dart';

@immutable
abstract class ProductListState {
  final List<ProductListModel> products;
  const ProductListState(this.products);

  List<Object?> get props => [products];
}

class ProductListInitial extends ProductListState {
  const ProductListInitial(super.products);
}

class ProductListUpdating extends ProductListState {
  const ProductListUpdating(super.products);
}

class ProductListUpdated extends ProductListState {
  const ProductListUpdated(super.products);
}

class ProductListUpdateError extends ProductListState {
  final String error;
  const ProductListUpdateError(super.products, this.error);
}
