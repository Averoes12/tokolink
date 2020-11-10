class Tracking {
  Courier courier;
  Destination destination;
  Origin origin;

  Tracking({
    this.courier,
    this.destination,
    this.origin,
  });

  factory Tracking.fromJson(Map<String, dynamic> json) {
    return Tracking(
      courier: json['courier'] != null ? Courier.fromJson(json['courier']) : null,
      destination: json['destination'] != null ? Destination.fromJson(json['destination']) : null,
      origin: json['origin'] != null ? Origin.fromJson(json['origin']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    if (courier != null) {
      data['courier'] = courier.toJson();
    }
    if (destination != null) {
      data['destination'] = destination.toJson();
    }
    if (origin != null) {
      data['origin'] = origin.toJson();
    }
    return data;
  }
}

class Destination {
  String latitude;
  String longitude;

  Destination({this.latitude, this.longitude});

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Origin {
  String latitude;
  String longitude;

  Origin({this.latitude, this.longitude});

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Courier {
  String created_at;
  String idCourier;
  String image;
  String latitude;
  String longitude;
  String name;
  String phone;
  String status;

  Courier({
    this.created_at,
    this.idCourier,
    this.image,
    this.latitude,
    this.longitude,
    this.name,
    this.phone,
    this.status,
  });

  factory Courier.fromJson(Map<String, dynamic> json) {
    return Courier(
      created_at: json['created_at'],
      idCourier: json['id_courier'],
      image: json['image'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
      phone: json['phone'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['created_at'] = created_at;
    data['id_courier'] = idCourier;
    data['image'] = image;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['name'] = name;
    data['phone'] = phone;
    data['status'] = status;
    return data;
  }
}
