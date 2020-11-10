import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:tokolink/infrastructure/repositories/coupon_repository.dart';
import 'package:tokolink/model/coupon.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(CouponInitial());
  final _couponRepo = GetIt.I<CouponRepository>();

  @override
  Stream<CouponState> mapEventToState(
    CouponEvent event,
  ) async* {
    if (event is GetCoupon) {
      yield CouponLoading();

      try {
        final coupons = await _couponRepo.getCoupons();
        yield CouponLoaded(coupons);
      } catch (e) {
        yield CouponLoaded([]);
      }
    }
  }
}
