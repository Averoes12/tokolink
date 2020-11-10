import 'package:chopper/chopper.dart';
import 'package:tokolink/infrastructure/helpers/client_preset.dart';

part 'balance_api_service.chopper.dart';

@ChopperApi()
abstract class BalanceApiService extends ChopperService {
  @Get(path: 'balance')
  Future<Response> balances();

  @Get(path: 'balance/banks')
  Future<Response> banks();

  @Get(path: 'balance/va')
  Future<Response> virtualAccounts();

  @Get(path: 'balance/va/{name}')
  Future<Response> virtualAccount(@Path('name') String name);

  static BalanceApiService create() {
    var client = ClientPreset.authClient(service: _$BalanceApiService());
    return _$BalanceApiService(client);
  }
}
