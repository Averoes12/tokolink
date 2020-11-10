import 'package:chopper/chopper.dart';
import 'package:tokolink/infrastructure/helpers/client_preset.dart';

part 'credential_api_service.chopper.dart';

@ChopperApi()
abstract class CredentialApiService extends ChopperService {
  @Post(path: 'user')
  Future<Response> register(@Body() Map<String, dynamic> body);

  @Post(path: 'user/resend')
  Future<Response> resendOTP(@Body() Map<String, dynamic> body);

  @Post(path: 'user/verify')
  Future<Response> verifyOTP(@Body() Map<String, dynamic> body);

  @Post(path: 'user/login')
  Future<Response> login(@Body() Map<String, dynamic> body);

  static CredentialApiService create() {
    var client = ClientPreset.client(service: _$CredentialApiService());
    return _$CredentialApiService(client);
  }
}
