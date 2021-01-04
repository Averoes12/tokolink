import 'package:tokolink/model/address.dart';

class Transaction {
  Address address;
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
  String invoice;
  String user;
  String store;
  List<DetailTransaction> detail;

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
    this.invoice,
    this.user,
    this.detail,
    this.store,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      address: Address.fromJson(json['address']),
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
      store: json['store'],
      invoice: json['invoice'],
      detail: List<DetailTransaction>.from(
        json['detail'].map((x) => DetailTransaction.fromJson(x)))
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['address'] = address.toJson();
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
    data['store'] = store;
    data['detail'] = detail.map((v) => v.toJson()).toList();
    return data;
  }
}
class DetailTransaction {
  final String product;
  final String qty;
  final String price;

  DetailTransaction(
      {this.product,
      this.qty,
      this.price,
      });

  factory DetailTransaction.fromJson(Map<String, dynamic> json) {
    return DetailTransaction(
      product: json['product'],
      qty: json['qty'],
      price: json['price'],
    );
  }
  Map<String, dynamic> toJson() => {
    'product': product,
    'qty': qty,
    'price': price,
  };
}
