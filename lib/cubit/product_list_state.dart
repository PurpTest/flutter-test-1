part of 'product_list_cubit.dart';

@immutable
abstract class ProductListState {
  final List<ProductListModel> products;
  final List<ProductListModel> filteredProducts;
  const ProductListState(this.products, this.filteredProducts);
}

class ProductListInitial extends ProductListState {
  const ProductListInitial(
    super.products,
    super.filteredProducts,
  );
  List<Object?> get props => [products, filteredProducts];
}

class ProductListUpdating extends ProductListState {
  const ProductListUpdating(
    super.products,
    super.filteredProducts,
  );
  List<Object?> get props => [products, filteredProducts];
}

class ProductListUpdated extends ProductListState {
  const ProductListUpdated(
    super.products,
    super.filteredProducts,
  );
  List<Object?> get props => [products, filteredProducts];
}

class ProductListUpdateError extends ProductListState {
  final String error;
  const ProductListUpdateError(
    super.products,
    super.filteredProducts,
    this.error,
  );
  List<Object?> get props => [products, filteredProducts, error];
}
