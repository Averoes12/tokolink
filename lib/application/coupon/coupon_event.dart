part of 'coupon_bloc.dart';

abstract class CouponEvent extends Equatable {
  const CouponEvent();
}

class GetCoupon extends CouponEvent {
  @override
  List<Object> get props => [];
}
