// To parse this JSON data, do
//
//     final banksModel = banksModelFromJson(jsonString);

import 'dart:convert';

BanksModel banksModelFromJson(String str) =>
    BanksModel.fromJson(json.decode(str));

String banksModelToJson(BanksModel data) => json.encode(data.toJson());

class BanksModel {
  final bool? result;
  final List<Datum>? data;

  BanksModel({
    this.result,
    this.data,
  });

  factory BanksModel.fromJson(Map<String, dynamic> json) => BanksModel(
        result: json["result"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String? id;
  final String? bankName;
  final String? accountName;
  final String? accountNumber;
  final String? locked;
  final dynamic lockedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Datum({
    this.id,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.locked,
    this.lockedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
