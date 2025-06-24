// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  final bool? result;
  final String? prevBalance;
  final List<Datum>? data;

  TransactionModel({
    this.result,
    this.prevBalance,
    this.data,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        result: json["result"],
        prevBalance: json["prev_balance"].toString(),
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "prev_balance": prevBalance,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final Type? type;
  final InOut? inOut;
  final DateTime? transDate;
  final String? amount;
  final String? apiStatus;
  final String? isPromoRewarded;
  final String? details;
  final String? reference;
  final String? status;

  Datum({
    this.type,
    this.inOut,
    this.apiStatus,
    this.transDate,
    this.amount,
    this.isPromoRewarded,
    this.details,
    this.reference,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: typeValues.map[json["type"]],
        inOut: inOutValues.map[json["in_out"]],
        transDate: json["trans_date"] == null
            ? null
            : DateTime.parse(json["trans_date"]),
        amount: json["amount"].toString(),
        apiStatus: json["api_status"].toString(),
        isPromoRewarded: json["is_promo_rewarded"].toString(),
        details: json["details"],
        reference: json["reference"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "in_out": inOutValues.reverse[inOut],
        "trans_date": transDate?.toIso8601String(),
        "amount": amount,
        "api_status": apiStatus,
        "is_promo_rewarded": isPromoRewarded,
        "details": details,
        "reference": reference,
        "status": status,
      };
}

enum InOut { IN, OUT }

final inOutValues = EnumValues({"in": InOut.IN, "out": InOut.OUT});

enum Type {
  AIRTIME,
  DATA,
  DEPOSIT,
  GIFTCARD,
  PAY4_ME,
  SCRIPT,
  SOCIALBOOST,
  SPRAY,
  MOTORS,
}

final typeValues = EnumValues({
  "airtime": Type.AIRTIME,
  "data": Type.DATA,
  "deposit": Type.DEPOSIT,
  "giftcard": Type.GIFTCARD,
  "pay4me": Type.PAY4_ME,
  "script": Type.SCRIPT,
  "socialboost": Type.SOCIALBOOST,
  "spray": Type.SPRAY,
  "motors": Type.MOTORS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
