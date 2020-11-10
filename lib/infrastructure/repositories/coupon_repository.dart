import 'package:tokolink/model/coupon.dart';

abstract class CouponRepository {
  Future<List<Coupon>> getCoupons();

  Future<Coupon> checkCoupon();
}
