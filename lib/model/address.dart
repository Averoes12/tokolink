
class Address {
  String address;
  String created_at;
  String id_address;
  String latitude;
  String longitude;
  String name;
  String phone;
  String isprimary;
  String user;

  Address({
    this.address,
    this.created_at,
    this.id_address,
    this.latitude,
    this.longitude,
    this.name,
    this.phone,
    this.isprimary,
    this.user,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      created_at: json['created_at'],
      id_address: json['id_address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
      phone: json['phone'],
      isprimary: json['isprimary'],
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
    data['isprimary'] = isprimary;
    return data;
  }
}
