// To parse this JSON data, do
//
//     final cableTransactionModel = cableTransactionModelFromJson(jsonString);

import 'dart:convert';

CableTransactionModel cableTransactionModelFromJson(String str) =>
    CableTransactionModel.fromJson(json.decode(str));

String cableTransactionModelToJson(CableTransactionModel data) =>
    json.encode(data.toJson());

class CableTransactionModel {
  String? fromDate;
  String? toDate;
  List<Transaction>? transactions;

  CableTransactionModel({
    this.fromDate,
    this.toDate,
    this.transactions,
  });

  factory CableTransactionModel.fromJson(Map<String, dynamic> json) =>
      CableTransactionModel(
        fromDate: json["from_date"],
        toDate: json["to_date"],
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "from_date": fromDate,
        "to_date": toDate,
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toJson())),
      };
}

class Transaction {
  String? id;
  String? userId;
  String? networkId;
  String? networkName;
  String? amount;
  String? phone;
  String? reference;
  String? apiStatus;
  String? status;
  String? apiMessage;
  String? promoId;
  String? promoCode;
  String? promoType;
  String? profit;
  String? createdAt;
  String? updatedAt;
  String? smartCard;
  String? purchasedCode;
  String? package;

  Transaction({
    this.id,
    this.userId,
    this.networkId,
    this.networkName,
    this.amount,
    this.phone,
    this.reference,
    this.apiStatus,
    this.status,
    this.apiMessage,
    this.promoId,
    this.promoCode,
    this.promoType,
    this.profit,
    this.createdAt,
    this.updatedAt,
    this.smartCard,
    this.purchasedCode,
    this.package,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        userId: json["user_id"],
        networkId: json["network_id"],
        networkName: json["network_name"],
        amount: json["amount"],
        phone: json["phone"],
        reference: json["reference"],
        apiStatus: json["api_status"],
        status: json["status"],
        apiMessage: json["api_message"],
        promoId: json["promo_id"],
        promoCode: json["promo_code"],
        promoType: json["promo_type"],
        profit: json["profit"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        smartCard: json["smart_card"],
        purchasedCode: json["purchased_code"],
        package: json["package"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "network_id": networkId,
        "network_name": networkName,
        "amount": amount,
        "phone": phone,
        "reference": reference,
        "api_status": apiStatus,
        "status": status,
        "api_message": apiMessage,
        "promo_id": promoId,
        "promo_code": promoCode,
        "promo_type": promoType,
        "profit": profit,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "smart_card": smartCard,
        "purchased_code": purchasedCode,
        "package": package,
      };
}
