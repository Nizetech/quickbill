// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  DateTime? fromDate;
  DateTime? toDate;
  int? balance;
  List<AllTransaction>? allTransactions;
  String? api;
  String? menu;

  TransactionModel({
    this.fromDate,
    this.toDate,
    this.balance,
    this.allTransactions,
    this.api,
    this.menu,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        balance: json["balance"],
        allTransactions: json["all_transactions"] == null
            ? []
            : List<AllTransaction>.from(json["all_transactions"]!
                .map((x) => AllTransaction.fromJson(x))),
        api: json["api"],
        menu: json["menu"],
      );

  Map<String, dynamic> toJson() => {
        "from_date":
            "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
        "balance": balance,
        "all_transactions": allTransactions == null
            ? []
            : List<dynamic>.from(allTransactions!.map((x) => x.toJson())),
        "api": api,
        "menu": menu,
      };
}

class AllTransaction {
  String? id;
  String? apiStatus;
  String? type;
  String? inOut;
  String? transDate;
  String? amount;
  String? networkName;
  String? reference;
  String? status;

  AllTransaction({
    this.id,
    this.apiStatus,
    this.type,
    this.inOut,
    this.transDate,
    this.amount,
    this.networkName,
    this.reference,
    this.status,
  });

  factory AllTransaction.fromJson(Map<String, dynamic> json) => AllTransaction(
        id: json["id"],
        apiStatus: json["api_status"],
        type: json["type"],
        inOut: json["in_out"],
        transDate: json["trans_date"],
        amount: json["amount"],
        networkName: json["network_name"],
        reference: json["reference"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "api_status": apiStatus,
        "type": type,
        "in_out": inOut,
        "trans_date": transDate,
        "amount": amount,
        "network_name": networkName,
        "reference": reference,
        "status": status,
      };
}
