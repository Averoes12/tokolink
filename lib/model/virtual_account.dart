class VirtualAccount {
  String accountNumber;
  String bankCode;
  String expirationDate;
  String externalId;
  String id;
  bool isClosed;
  bool isSingleUse;
  String merchantCode;
  String name;
  String owner_id;
  String status;

  VirtualAccount({this.accountNumber, this.bankCode, this.expirationDate, this.externalId, this.id, this.isClosed, this.isSingleUse, this.merchantCode, this.name, this.owner_id, this.status});

  factory VirtualAccount.fromJson(Map<String, dynamic> json) {
    return VirtualAccount(
      accountNumber: json['account_number'],
      bankCode: json['bank_code'],
      expirationDate: json['expiration_date'],
      externalId: json['external_id'],
      id: json['id'],
      isClosed: json['is_closed'],
      isSingleUse: json['is_single_use'],
      merchantCode: json['merchant_code'],
      name: json['name'],
      owner_id: json['owner_id'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['account_number'] = accountNumber;
    data['bank_code'] = bankCode;
    data['expiration_date'] = expirationDate;
    data['external_id'] = expirationDate;
    data['id'] = id;
    data['is_closed'] = isClosed;
    data['is_single_use'] = isSingleUse;
    data['merchant_code'] = merchantCode;
    data['name'] = name;
    data['owner_id'] = owner_id;
    data['status'] = status;
    return data;
  }
}

class VirtualAccountDetail {
  List<Instruction> instruction;
  VirtualAccount va;

  VirtualAccountDetail({this.instruction, this.va});

  factory VirtualAccountDetail.fromJson(Map<String, dynamic> json) {
    return VirtualAccountDetail(
      instruction: json['instruction'] != null ? (json['instruction'] as List).map((i) => Instruction.fromJson(i)).toList() : null,
      va: json['va'] != null ? VirtualAccount.fromJson(json['va']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    if (instruction != null) {
      data['instruction'] = instruction.map((v) => v.toJson()).toList();
    }
    if (va != null) {
      data['va'] = va.toJson();
    }
    return data;
  }
}

class Instruction {
  String code;
  String idInstruction;
  String name;
  String text;

  Instruction({this.code, this.idInstruction, this.name, this.text});

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      code: json['code'],
      idInstruction: json['id_instruction'],
      name: json['name'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['code'] = code;
    data['id_instruction'] = idInstruction;
    data['name'] = name;
    data['text'] = text;
    return data;
  }
}
