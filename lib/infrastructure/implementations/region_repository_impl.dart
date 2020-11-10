import 'package:tokolink/infrastructure/data/remote/address_api_service.dart';
import 'package:tokolink/infrastructure/repositories/region_repository.dart';
import 'package:tokolink/model/region.dart';

class RegionRepositoryImpl extends RegionRepository {
  final _service = AddressApiService.create();

  @override
  Future<List<City>> getCities(String provinceId) async {
    final resp = await _service.cities(provinceId);
    if (resp.statusCode != 200 || resp.body['status'] != '200') throw Exception('error');
    final data = resp.body['data'];
    return data.map<City>((json) => City.fromJson(json)).toList();
  }

  @override
  Future<List<District>> getDistrict(String cityId) async {
    final resp = await _service.districts(cityId);
    if (resp.statusCode != 200 || resp.body['status'] != '200') throw Exception('error');
    final data = resp.body['data'];
    return data.map<District>((json) => District.fromJson(json)).toList();
  }

  @override
  Future<List<Province>> getProvinces() async {
    final resp = await _service.provinces();
    if (resp.statusCode != 200 || resp.body['status'] != '200') throw Exception('error');
    final data = resp.body['data'];
    return data.map<Province>((json) => Province.fromJson(json)).toList();
  }
}
