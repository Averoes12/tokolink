import 'package:chopper/chopper.dart';
import 'package:tokolink/infrastructure/helpers/client_preset.dart';

part 'transaction_api_service.chopper.dart';

@ChopperApi()
abstract class TransactionApiService extends ChopperService {
  @Post(path: 'transaction')
  Future<Response> createTransaction(@Body() Map<String, dynamic> body);

  @Get(path: 'transaction')
  Future<Response> transactions();

  @Get(path: 'transaction/index/{id}')
  Future<Response> transaction(@Path('id') String id);

  @Get(path: 'transaction/tracking/{id}')
  Future<Response> tracking(@Path('id') String id);

  @Get(path: 'transaction/shipping/{lat}/{lng}')
  Future<Response> shipping(@Path('lat') double lat, @Path('lng') double lng);

  @Post(path: 'review')
  Future<Response> review(@Body() Map<String, dynamic> body);

  static TransactionApiService create() {
    var client = ClientPreset.authClient(service: _$TransactionApiService());
    return _$TransactionApiService(client);
  }
}
