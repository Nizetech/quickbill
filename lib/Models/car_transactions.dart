// To parse this JSON data, do
//
//     final carTransactions = carTransactionsFromJson(jsonString);

import 'dart:convert';

CarTransactions carTransactionsFromJson(String str) =>
    CarTransactions.fromJson(json.decode(str));

String carTransactionsToJson(CarTransactions data) =>
    json.encode(data.toJson());

class CarTransactions {
  final DateTime? fromDate;
  final DateTime? toDate;
  final List<Transaction>? transactions;

  CarTransactions({
    this.fromDate,
    this.toDate,
    this.transactions,
  });

  factory CarTransactions.fromJson(Map<String, dynamic> json) =>
      CarTransactions(
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "from_date": fromDate?.toIso8601String(),
        "to_date": toDate?.toIso8601String(),
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toJson())),
      };
}

class Transaction {
  final String? id;
  final DateTime? createdAt;
  final String? amount;
  final String? title;
  final dynamic reference;

  Transaction({
    this.id,
    this.createdAt,
    this.amount,
    this.title,
    this.reference,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        amount: json["amount"],
        title: json["title"],
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "amount": amount,
        "title": title,
        "reference": reference,
      };
}
