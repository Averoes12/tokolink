part of 'carousel_bloc.dart';

abstract class CarouselState extends Equatable {
  const CarouselState();
}

class CarouselInitial extends CarouselState {
  @override
  List<Object> get props => [];
}

class CarouselLoading extends CarouselState {
  @override
  List<Object> get props => [];
}

class CarouselLoaded extends CarouselState {
  final List<Carousel> carousels;

  CarouselLoaded(this.carousels);

  @override
  List<Object> get props => [carousels];
}
