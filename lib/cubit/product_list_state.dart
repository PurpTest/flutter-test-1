part of 'product_list_cubit.dart';

@immutable
sealed class ProductListState {
  final List<ProductListModel> products;
  const ProductListState(this.products);

  // this=>proc();
}

final class ProductListInitial extends ProductListState {
  const ProductListInitial(super.products);
}

final class ProductListUpdating extends ProductListState {
  const ProductListUpdating(super.products);
}

final class ProductListUpdated extends ProductListState {
  const ProductListUpdated(super.products);
}
