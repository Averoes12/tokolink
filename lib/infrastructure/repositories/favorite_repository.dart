import 'package:tokolink/model/product.dart';

abstract class FavoriteRepository {
  Future<List<Product>> getFavorites();

  Future<void> addFavorite(Product product);
}
