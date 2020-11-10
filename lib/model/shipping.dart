class Shipping {
  double distance;
  String fee;
  String radius;

  Shipping({
    this.distance,
    this.fee,
    this.radius,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      distance: json['distance'],
      fee: json['fee'],
      radius: json['radius'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['distance'] = distance;
    data['fee'] = fee;
    data['radius'] = radius;
    return data;
  }
}
