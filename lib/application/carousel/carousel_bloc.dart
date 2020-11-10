import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:tokolink/infrastructure/repositories/product_repository.dart';
import 'package:tokolink/model/carousel.dart';

part 'carousel_event.dart';
part 'carousel_state.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  CarouselBloc() : super(CarouselInitial());
  final _productRepo = GetIt.I<ProductRepository>();

  @override
  Stream<CarouselState> mapEventToState(
    CarouselEvent event,
  ) async* {
    if (event is GetCarousel) {
      yield CarouselLoading();

      try {
        final carousels = await _productRepo.getCarousels();
        yield CarouselLoaded(carousels);
      } catch (e) {
        yield CarouselLoaded([]);
      }
    }
  }
}
