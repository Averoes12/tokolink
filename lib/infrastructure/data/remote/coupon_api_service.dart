import 'package:chopper/chopper.dart';
import 'package:tokolink/infrastructure/helpers/client_preset.dart';

part 'coupon_api_service.chopper.dart';

@ChopperApi()
abstract class CouponApiService extends ChopperService {
  @Get(path: 'coupon')
  Future<Response> coupons();

  @Get(path: 'coupon/index/{id}')
  Future<Response> coupon(@Path('id') String id);

  @Get(path: 'coupon/check/{code}')
  Future<Response> checkCoupon(@Path('code') String code);

  static CouponApiService create() {
    var client = ClientPreset.authClient(service: _$CouponApiService());
    return _$CouponApiService(client);
  }
}
