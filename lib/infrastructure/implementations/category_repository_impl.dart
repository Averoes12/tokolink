import 'package:tokolink/infrastructure/data/remote/category_api_service.dart';
import 'package:tokolink/infrastructure/repositories/category_repository.dart';
import 'package:tokolink/model/category.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final _service = CategoryApiService.create();

  @override
  Future<List<Category>> getCategories() async {
    final resp = await _service.categories();
    if (resp.statusCode != 200 || resp.body['status'] != '200') throw Exception('error');
    final data = resp.body['data'];
    return data.map<Category>((json) => Category.fromJson(json)).toList();
  }

  @override
  Future<List<Category>> getSubCategories(String categoryId) async {
    final resp = await _service.subCategories(categoryId);
    if (resp.statusCode != 200 || resp.body['status'] != '200') throw Exception('error');
    final data = resp.body['data']['child'];
    return data.map<Category>((json) => Category.fromJson(json)).toList();
  }
}
