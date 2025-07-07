// To parse this JSON data, do
//
//     final banksModel = banksModelFromJson(jsonString);

class BanksModel {
  final String? id;
  final String? bankName;
  final String? accountName;
  final String? accountNumber;
  final String? locked;
  final dynamic lockedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BanksModel({
    this.id,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.locked,
    this.lockedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory BanksModel.fromJson(Map<String, dynamic> json) => BanksModel(
        id: json["id"],
        bankName: json["bank_name"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        locked: json["locked"],
        lockedAt: json["locked_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bank_name": bankName,
        "account_name": accountName,
        "account_number": accountNumber,
        "locked": locked,
        "locked_at": lockedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
