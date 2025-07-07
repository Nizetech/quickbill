// To parse this JSON data, do
//
//     final depositHistoryModel = depositHistoryModelFromJson(jsonString);

import 'dart:convert';

DepositHistoryModel depositHistoryModelFromJson(String str) =>
    DepositHistoryModel.fromJson(json.decode(str));

String depositHistoryModelToJson(DepositHistoryModel data) =>
    json.encode(data.toJson());

class DepositHistoryModel {
  final bool? result;
  final List<Datum>? data;

  DepositHistoryModel({
    this.result,
    this.data,
  });

  factory DepositHistoryModel.fromJson(Map<String, dynamic> json) =>
      DepositHistoryModel(
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
  final String? userId;
  final String? type;
  final String? amount;
  final String? reference;
  final String? bankId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? bankName;

  Datum({
    this.id,
    this.userId,
    this.type,
    this.amount,
    this.reference,
    this.bankId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.bankName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        amount: json["amount"],
        reference: json["reference"],
        bankId: json["bank_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        bankName: json["bank_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "amount": amount,
        "reference": reference,
        "bank_id": bankId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "bank_name": bankName,
      };
}
