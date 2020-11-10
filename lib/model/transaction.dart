class Transaction {
  String address;
  String coupon;
  String courier;
  String createdAt;
  String discount;
  String idTransaction;
  String payment;
  String shipping;
  String status;
  String subtotal;
  String total;
  String user;

  Transaction({
    this.address,
    this.coupon,
    this.courier,
    this.createdAt,
    this.discount,
    this.idTransaction,
    this.payment,
    this.shipping,
    this.status,
    this.subtotal,
    this.total,
    this.user,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      address: json['address'],
      coupon: json['coupon'],
      courier: json['courier'],
      createdAt: json['created_at'],
      discount: json['discount'],
      idTransaction: json['id_transaction'],
      payment: json['payment'],
      shipping: json['shipping'],
      status: json['status'],
      subtotal: json['subtotal'],
      total: json['total'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['address'] = address;
    data['coupon'] = coupon;
    data['courier'] = courier;
    data['created_at'] = createdAt;
    data['discount'] = discount;
    data['id_transaction'] = idTransaction;
    data['payment'] = payment;
    data['shipping'] = shipping;
    data['status'] = status;
    data['subtotal'] = subtotal;
    data['total'] = total;
    data['user'] = user;
    return data;
  }
}
