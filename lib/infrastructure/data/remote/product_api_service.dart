import 'package:chopper/chopper.dart';
import 'package:tokolink/infrastructure/helpers/client_preset.dart';

part 'product_api_service.chopper.dart';

@ChopperApi()
abstract class ProductApiService extends ChopperService {
  @Get(path: 'product')
  Future<Response> products();

  @Get(path: 'product/cat/{categoryId}')
  Future<Response> productByCategory(@Path('categoryId') String categoryId);

  @Get(path: 'product/index/{productId}')
  Future<Response> detail(@Path('productId') String productId);

  @Get(path: 'product/search/{keyword}')
  Future<Response> search(@Path('keyword') String keyword);

  @Get(path: 'product/best')
  Future<Response> bestSeller();

  @Get(path: 'carousel')
  Future<Response> carousel();

  static ProductApiService create() {
    var client = ClientPreset.client(service: _$ProductApiService());
    return _$ProductApiService(client);
  }
}
