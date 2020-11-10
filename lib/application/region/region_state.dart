part of 'region_bloc.dart';

abstract class RegionState extends Equatable {
  const RegionState();
}

class RegionInitial extends RegionState {
  @override
  List<Object> get props => [];
}

class RegionLoading extends RegionState {
  @override
  List<Object> get props => [];
}

class RegionLoaded extends RegionState {
  final Object payload;

  RegionLoaded(this.payload);

  @override
  List<Object> get props => [payload];
}
