part of 'region_bloc.dart';

abstract class RegionEvent extends Equatable {
  const RegionEvent();
}

class GetProvince extends RegionEvent {
  @override
  List<Object> get props => [];
}

class GetCity extends RegionEvent {
  final String provinceId;

  GetCity(this.provinceId);

  @override
  List<Object> get props => [provinceId];
}

class GetDistrict extends RegionEvent {
  final String cityId;

  GetDistrict(this.cityId);

  @override
  List<Object> get props => [cityId];
}
