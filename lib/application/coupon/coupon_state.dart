part of 'coupon_bloc.dart';

abstract class CouponState extends Equatable {
  const CouponState();
}

class CouponInitial extends CouponState {
  @override
  List<Object> get props => [];
}

class CouponLoading extends CouponState {
  @override
  List<Object> get props => [];
}

class CouponLoaded extends CouponState {
  final List<Coupon> coupons;

  CouponLoaded(this.coupons);

  @override
  List<Object> get props => [coupons];
}
