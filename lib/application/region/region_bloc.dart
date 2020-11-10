import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:tokolink/infrastructure/repositories/region_repository.dart';

part 'region_event.dart';
part 'region_state.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  RegionBloc() : super(RegionInitial());
  final _regionRepo = GetIt.I<RegionRepository>();

  @override
  Stream<RegionState> mapEventToState(
    RegionEvent event,
  ) async* {
    if (event is GetProvince) {
      yield RegionLoading();

      try {
        final payload = await _regionRepo.getProvinces();
        yield RegionLoaded(payload);
      } catch (e) {
        yield RegionLoaded([]);
      }
    }

    if (event is GetCity) {
      yield RegionLoading();

      try {
        final payload = await _regionRepo.getCities(event.provinceId);
        yield RegionLoaded(payload);
      } catch (e) {
        yield RegionLoaded([]);
      }
    }

    if (event is GetDistrict) {
      yield RegionLoading();

      try {
        final payload = await _regionRepo.getDistrict(event.cityId);
        yield RegionLoaded(payload);
      } catch (e) {
        yield RegionLoaded([]);
      }
    }
  }
}
