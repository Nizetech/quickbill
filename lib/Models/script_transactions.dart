// To parse this JSON data, do
//
//     final scripTransactions = scripTransactionsFromJson(jsonString);

import 'dart:convert';

ScripTransactions scripTransactionsFromJson(String str) =>
    ScripTransactions.fromJson(json.decode(str));

String scripTransactionsToJson(ScripTransactions data) =>
    json.encode(data.toJson());

class ScripTransactions {
  final DateTime? fromDate;
  final DateTime? toDate;
  final List<Transaction>? transactions;

  ScripTransactions({
    this.fromDate,
    this.toDate,
    this.transactions,
  });

  factory ScripTransactions.fromJson(Map<String, dynamic> json) =>
      ScripTransactions(
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
  final String? userId;
  final String? scriptId;
  final String? amount;
  final String? activeCode;
  final String? promoCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic profit;

  Transaction({
    this.id,
    this.userId,
    this.scriptId,
    this.amount,
    this.activeCode,
    this.promoCode,
    this.createdAt,
    this.updatedAt,
    this.profit,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        userId: json["user_id"],
        scriptId: json["script_id"],
        amount: json["amount"],
        activeCode: json["active_code"],
        promoCode: json["promo_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "script_id": scriptId,
        "amount": amount,
        "active_code": activeCode,
        "promo_code": promoCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profit": profit,
      };
}
