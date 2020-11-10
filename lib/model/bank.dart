class Bank {
  String code;
  String name;

  Bank({this.code, this.name});

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
