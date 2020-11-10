import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:tokolink/infrastructure/repositories/product_repository.dart';
import 'package:tokolink/model/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial());
  final _repoProduct = GetIt.I<ProductRepository>();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is GetProduct) {
      yield ProductLoading();

      try {
        final products = await _repoProduct.getProducts();
        yield ProductLoaded(products);
      } catch (e) {
        yield ProductLoaded([]);
      }
    }

    if (event is GetProductByCategory) {
      yield ProductLoading();

      try {
        final products = await _repoProduct.getProductsByCategory(event.categoryId);
        yield ProductLoaded(products);
      } catch (e) {
        yield ProductLoaded([]);
      }
    }

    if (event is SearchProduct) {
      yield ProductLoading();

      try {
        final products = await _repoProduct.searchProducts(event.keyword);
        yield ProductLoaded(products);
      } catch (e) {
        yield ProductLoaded([]);
      }
    }

    if (event is GetBestSellerProduct) {
      yield ProductLoading();

      try {
        final products = await _repoProduct.getBestSellerProducts();
        yield ProductLoaded(products);
      } catch (e) {
        yield ProductLoaded([]);
      }
    }
  }
}
