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
  final String? title;
  final String? image;
  final String? demoUrl;
  final String? attachName;
  final String? attachPath;
  final String? categories;
  final String? price;
  final String? description;
  final String? views;
  final String? published;
  final DateTime? publishedAt;

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
    this.title,
    this.image,
    this.demoUrl,
    this.attachName,
    this.attachPath,
    this.categories,
    this.price,
    this.description,
    this.views,
    this.published,
    this.publishedAt,
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
        title: json["title"],
        image: json["image"],
        demoUrl: json["demo_url"],
        attachName: json["attach_name"],
        attachPath: json["attach_path"],
        categories: json["categories"],
        price: json["price"],
        description: json["description"],
        views: json["views"],
        published: json["published"],
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
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
        "title": title,
        "image": image,
        "demo_url": demoUrl,
        "attach_name": attachName,
        "attach_path": attachPath,
        "categories": categories,
        "price": price,
        "description": description,
        "views": views,
        "published": published,
        "published_at": publishedAt?.toIso8601String(),
      };
}
