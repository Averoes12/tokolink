import 'package:chopper/chopper.dart';
import 'package:tokolink/infrastructure/helpers/client_preset.dart';

part 'address_api_service.chopper.dart';

@ChopperApi()
abstract class AddressApiService extends ChopperService {
  @Get(path: 'province')
  Future<Response> provinces();

  @Get(path: 'cities/index/{id}')
  Future<Response> cities(@Path('id') String id);

  @Get(path: 'district/index/{id}')
  Future<Response> districts(@Path('id') String id);

  @Post(path: 'address')
  Future<Response> createAddress(@Body() Map<String, dynamic> body);

  @Get(path: 'address')
  Future<Response> addresses();

  @Get(path: 'address/index/{id}')
  Future<Response> address(@Path('id') String id);

  static AddressApiService create() {
    var client = ClientPreset.authClient(service: _$AddressApiService());
    return _$AddressApiService(client);
  }
}
