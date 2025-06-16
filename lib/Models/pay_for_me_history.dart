// To parse this JSON data, do
//
//     final payForMeHistoryModel = payForMeHistoryModelFromJson(jsonString);

import 'dart:convert';

PayForMeHistoryModel payForMeHistoryModelFromJson(String str) =>
    PayForMeHistoryModel.fromJson(json.decode(str));

String payForMeHistoryModelToJson(PayForMeHistoryModel data) =>
    json.encode(data.toJson());

class PayForMeHistoryModel {
  String? id;
  String? userId;
  String? paymentOption;
  String? amount;
  String? invoiceLink;
  String? accountUsername;
  String? accountPassword;
  String? reference;
  String? promoCode;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? profit;

  PayForMeHistoryModel({
    this.id,
    this.userId,
    this.paymentOption,
    this.amount,
    this.invoiceLink,
    this.accountUsername,
    this.accountPassword,
    this.reference,
    this.promoCode,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.profit,
  });

  factory PayForMeHistoryModel.fromJson(Map<String, dynamic> json) =>
      PayForMeHistoryModel(
        id: json["id"],
        userId: json["user_id"],
        paymentOption: json["payment_option"],
        amount: json["amount"],
        invoiceLink: json["invoice_link"],
        accountUsername: json["account_username"],
        accountPassword: json["account_password"],
        reference: json["reference"],
        promoCode: json["promo_code"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "payment_option": paymentOption,
        "amount": amount,
        "invoice_link": invoiceLink,
        "account_username": accountUsername,
        "account_password": accountPassword,
        "reference": reference,
        "promo_code": promoCode,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "profit": profit,
      };
}
