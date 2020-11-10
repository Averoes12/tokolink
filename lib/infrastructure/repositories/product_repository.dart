import 'package:tokolink/model/carousel.dart';
import 'package:tokolink/model/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();

  Future<List<Product>> getProductsByCategory(String categoryId);

  Future<List<Product>> searchProducts(String keyword);

  Future<List<Product>> getBestSellerProducts();

  Future<List<Carousel>> getCarousels();
}
