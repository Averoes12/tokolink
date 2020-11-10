class Coupon {
  String code;
  String createdAt;
  String description;
  String discount;
  String expired;
  String idCoupon;
  String image;
  String name;

  Coupon({
    this.code,
    this.createdAt,
    this.description,
    this.discount,
    this.expired,
    this.idCoupon,
    this.image,
    this.name,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      code: json['code'],
      createdAt: json['created_at'],
      description: json['description'],
      discount: json['discount'],
      expired: json['expired'],
      idCoupon: json['id_coupon'],
      image: json['image'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['code'] = code;
    data['created_at'] = createdAt;
    data['description'] = description;
    data['discount'] = discount;
    data['expired'] = expired;
    data['id_coupon'] = idCoupon;
    data['image'] = image;
    data['name'] = name;
    return data;
  }
}
