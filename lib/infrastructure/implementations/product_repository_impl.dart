import 'package:tokolink/infrastructure/data/remote/product_api_service.dart';
import 'package:tokolink/infrastructure/repositories/product_repository.dart';
import 'package:tokolink/model/carousel.dart';
import 'package:tokolink/model/product.dart';

class ProductRepositoryImpl extends ProductRepository {
  final _service = ProductApiService.create();

  @override
  Future<List<Product>> getBestSellerProducts() async {
    final resp = await _service.bestSeller();
    if (resp.statusCode != 200 || resp.body['status'] != '200') throw Exception('error');
    final data = resp.body['data'];
    return data.map<Product>((json) => Product.fromJson(json)).toList();
  }

  @override
  Future<List<Carousel>> getCarousels() async {
    final resp = await _service.carousel();
    if (resp.statusCode != 200 || resp.body['status'] != '200') throw Exception('error');
    final data = resp.body['data'];
    return data.map<Carousel>((json) => Carousel.fromJson(json)).toList();
  }

  @override
  Future<List<Product>> getProducts() async {
    final resp = await _service.products();
    if (resp.statusCode != 200 || resp.body['status'] != '200') throw Exception('error');
    final data = resp.body['data'];
    return data.map<Product>((json) => Product.fromJson(json)).toList();
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    final resp = await _service.productByCategory(categoryId);
    if (resp.statusCode != 200 || resp.body['status'] != '200') throw Exception('error');
    final data = resp.body['data'];
    return data.map<Product>((json) => Product.fromJson(json)).toList();
  }

  @override
  Future<List<Product>> searchProducts(String keyword) async {
    final resp = await _service.search(keyword);
    if (resp.statusCode != 200 || resp.body['status'] != '200') throw Exception('error');
    final data = resp.body['data'];
    return data.map<Product>((json) => Product.fromJson(json)).toList();
  }
}
