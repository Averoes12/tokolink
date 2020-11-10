class Province {
  String idProvince;
  String province;

  Province({
    this.idProvince,
    this.province,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      idProvince: json['id_province'],
      province: json['province'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['id_province'] = idProvince;
    data['province'] = province;
    return data;
  }
}

class City {
  String cityName;
  String idCities;
  String idProvince;
  String postalCode;
  String province;
  String type;

  City({
    this.cityName,
    this.idCities,
    this.idProvince,
    this.postalCode,
    this.province,
    this.type,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityName: json['city_name'],
      idCities: json['id_cities'],
      idProvince: json['id_province'],
      postalCode: json['postal_code'],
      province: json['province'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['city_name'] = cityName;
    data['id_cities'] = idCities;
    data['id_province'] = idProvince;
    data['postal_code'] = postalCode;
    data['province'] = province;
    data['type'] = type;
    return data;
  }
}

class District {
  String city;
  String idCities;
  String idDistrict;
  String idProvince;
  String name;
  String province;
  String type;

  District({
    this.city,
    this.idCities,
    this.idDistrict,
    this.idProvince,
    this.name,
    this.province,
    this.type,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      city: json['city'],
      idCities: json['id_cities'],
      idDistrict: json['id_district'],
      idProvince: json['id_province'],
      name: json['name'],
      province: json['province'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['city'] = city;
    data['id_cities'] = idCities;
    data['id_district'] = idDistrict;
    data['id_province'] = idProvince;
    data['name'] = name;
    data['province'] = province;
    data['type'] = type;
    return data;
  }
}
