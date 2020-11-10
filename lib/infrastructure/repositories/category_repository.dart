import 'package:tokolink/model/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();

  Future<List<Category>> getSubCategories(String categoryId);
}
