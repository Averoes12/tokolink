part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProduct extends ProductEvent {
  @override
  List<Object> get props => [];
}

class GetProductByCategory extends ProductEvent {
  final String categoryId;

  GetProductByCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class SearchProduct extends ProductEvent {
  final String keyword;

  SearchProduct(this.keyword);

  @override
  List<Object> get props => [keyword];
}

class GetBestSellerProduct extends ProductEvent {
  @override
  List<Object> get props => [];
}
