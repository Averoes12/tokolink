import 'package:tokolink/model/region.dart';

class Address {
  String address;
  City city;
  String created_at;
  District district;
  String id_address;
  String latitude;
  String longitude;
  String name;
  String phone;
  Province province;
  String user;

  Address({
    this.address,
    this.city,
    this.created_at,
    this.district,
    this.id_address,
    this.latitude,
    this.longitude,
    this.name,
    this.phone,
    this.province,
    this.user,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      created_at: json['created_at'],
      district: json['district'] != null ? District.fromJson(json['district']) : null,
      id_address: json['id_address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
      phone: json['phone'],
      province: json['province'] != null ? Province.fromJson(json['province']) : null,
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['address'] = address;
    data['created_at'] = created_at;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['name'] = name;
    data['phone'] = phone;
    if (city != null) {
      data['city'] = city.idCities;
    }
    if (district != null) {
      data['district'] = district.idDistrict;
    }
    if (province != null) {
      data['province'] = province.idProvince;
    }
    return data;
  }
}
