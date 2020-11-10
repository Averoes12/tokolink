import 'package:chopper/chopper.dart';
import 'package:tokolink/infrastructure/helpers/client_preset.dart';

part 'user_api_service.chopper.dart';

@ChopperApi()
abstract class UserApiService extends ChopperService {
  @Post(path: 'user/forgot')
  Future<Response> forgotPassword(@Body() Map<String, dynamic> body);

  @Post(path: 'user/update')
  Future<Response> updatePassword(@Body() Map<String, dynamic> body);

  @Post(path: 'user/edit')
  Future<Response> updateProfile(@Body() Map<String, dynamic> body);

  @Get(path: 'user/detail')
  Future<Response> detail();

  static UserApiService create() {
    var client = ClientPreset.authClient(service: _$UserApiService());
    return _$UserApiService(client);
  }
}
