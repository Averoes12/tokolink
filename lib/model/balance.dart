class Balance {
  String createdAt;
  String idBalance;
  String invoice;
  String nominal;
  String status;
  String type;
  String user;

  Balance({this.createdAt, this.idBalance, this.invoice, this.nominal, this.status, this.type, this.user});

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      createdAt: json['created_at'],
      idBalance: json['id_balance'],
      invoice: json['invoice'],
      nominal: json['nominal'],
      status: json['status'],
      type: json['type'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id_balance'] = idBalance;
    data['invoice'] = invoice;
    data['nominal'] = nominal;
    data['status'] = status;
    data['type'] = type;
    data['user'] = user;
    return data;
  }
}
