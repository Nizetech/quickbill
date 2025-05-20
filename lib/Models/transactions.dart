// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  bool? result;
  int? prevBalance;
  List<Transaction>? data;

  TransactionModel({
    this.result,
    this.prevBalance,
    this.data,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        result: json["result"],
        prevBalance: json["prev_balance"],
        data: json["data"] == null
            ? []
            : List<Transaction>.from(
                json["data"]!.map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "prev_balance": prevBalance,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Transaction {
  String? type;
  String? inOut;
  DateTime? transDate;
  String? amount;
  String? isPromoRewarded;
  String? details;
  String? reference;
  String? status;

  Transaction({
    this.type,
    this.inOut,
    this.transDate,
    this.amount,
    this.isPromoRewarded,
    this.details,
    this.reference,
    this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        type: json["type"],
        inOut: json["in_out"],
        transDate: json["trans_date"] == null
            ? null
            : DateTime.parse(json["trans_date"]),
        amount: json["amount"],
        isPromoRewarded: json["is_promo_rewarded"],
        details: json["details"],
        reference: json["reference"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "in_out": inOut,
        "trans_date": transDate?.toIso8601String(),
        "amount": amount,
        "is_promo_rewarded": isPromoRewarded,
        "details": details,
        "reference": reference,
        "status": status,
      };
}
