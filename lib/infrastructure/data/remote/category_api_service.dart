import 'package:chopper/chopper.dart';
import 'package:tokolink/infrastructure/helpers/client_preset.dart';

part 'category_api_service.chopper.dart';

@ChopperApi()
abstract class CategoryApiService extends ChopperService {
  @Get(path: 'category')
  Future<Response> categories();

  @Get(path: 'category/index/{categoryId}')
  Future<Response> subCategories(@Path('categoryId') String categoryId);

  static CategoryApiService create() {
    var client = ClientPreset.client(service: _$CategoryApiService());
    return _$CategoryApiService(client);
  }
}
