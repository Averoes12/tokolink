// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CouponApiService extends CouponApiService {
  _$CouponApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CouponApiService;

  @override
  Future<Response<dynamic>> coupons() {
    final $url = 'coupon';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> coupon(String id) {
    final $url = 'coupon/index/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> checkCoupon(String code) {
    final $url = 'coupon/check/$code';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
