import 'package:tokolink/model/region.dart';

abstract class RegionRepository {
  Future<List<Province>> getProvinces();

  Future<List<City>> getCities(String provinceId);

  Future<List<District>> getDistrict(String cityId);
}
