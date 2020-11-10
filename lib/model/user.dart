class User {
  int balance;
  String createdAt;
  String email;
  String idUser;
  String name;
  String phone;
  String status;
  String password;
  String passwordConfirmation;
  String otp;
  String fcm;
  String device;

  User({
    this.balance,
    this.createdAt,
    this.email,
    this.idUser,
    this.name,
    this.phone,
    this.status,
    this.password,
    this.passwordConfirmation,
    this.otp,
    this.fcm,
    this.device,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      balance: json['balance'],
      createdAt: json['created_at'],
      email: json['email'],
      idUser: json['id_user'],
      name: json['name'],
      phone: json['phone'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['repassword'] = passwordConfirmation;
    return data;
  }
}
