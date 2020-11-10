import 'package:tokolink/infrastructure/data/remote/coupon_api_service.dart';
import 'package:tokolink/infrastructure/repositories/coupon_repository.dart';
import 'package:tokolink/model/coupon.dart';

class CouponRepositoryImpl extends CouponRepository {
  final _service = CouponApiService.create();

  @override
  Future<Coupon> checkCoupon() async {
    final resp = await _service.coupons();
    if (resp.statusCode != 200 || resp.body['status'] != '200') throw Exception('error');
    final data = resp.body['data'];
    return Coupon.fromJson(data);
  }

  @override
  Future<List<Coupon>> getCoupons() async {
    final resp = await _service.coupons();
    if (resp.statusCode != 200 || resp.body['status'] != '200') throw Exception('error');
    final data = resp.body['data'];
    return data.map<Coupon>((json) => Coupon.fromJson(json)).toList();
  }
}
