// To parse this JSON data, do
//
//     final paymentFeeModel = paymentFeeModelFromJson(jsonString);

import 'dart:convert';

PaymentFeeModel paymentFeeModelFromJson(String str) =>
    PaymentFeeModel.fromJson(json.decode(str));

String paymentFeeModelToJson(PaymentFeeModel data) =>
    json.encode(data.toJson());

class PaymentFeeModel {
  String? ngnPrice;
  double? paypalPercent;
  double? cardPercent;

  PaymentFeeModel({
    this.ngnPrice,
    this.paypalPercent,
    this.cardPercent,
  });

  factory PaymentFeeModel.fromJson(Map<String, dynamic> json) =>
      PaymentFeeModel(
        ngnPrice: json["ngn_price"],
        paypalPercent: json["paypal_percent"]?.toDouble(),
        cardPercent: json["card_percent"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ngn_price": ngnPrice,
        "paypal_percent": paypalPercent,
        "card_percent": cardPercent,
      };
}
