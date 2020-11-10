import 'package:chopper/chopper.dart';
import 'package:tokolink/infrastructure/helpers/client_preset.dart';

part 'favorite_api_service.chopper.dart';

@ChopperApi()
abstract class FavoriteApiService extends ChopperService {
  @Get(path: 'favorite')
  Future<Response> favorites();

  @Post(path: 'favorite')
  Future<Response> addFavorite(@Body() Map<String, dynamic> body);

  static FavoriteApiService create() {
    var client = ClientPreset.authClient(service: _$FavoriteApiService());
    return _$FavoriteApiService(client);
  }
}
