// To parse this JSON data, do
//
//     final giftCardHistoryModel = giftCardHistoryModelFromJson(jsonString);

import 'dart:convert';

GiftCardHistoryModel giftCardHistoryModelFromJson(String str) =>
    GiftCardHistoryModel.fromJson(json.decode(str));

String giftCardHistoryModelToJson(GiftCardHistoryModel data) =>
    json.encode(data.toJson());

class GiftCardHistoryModel {
  final bool? result;
  final List<Datum>? data;

  GiftCardHistoryModel({
    this.result,
    this.data,
  });

  factory GiftCardHistoryModel.fromJson(Map<String, dynamic> json) =>
      GiftCardHistoryModel(
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
  final String? countryCode;
  final String? phoneNumber;
  final String? giftId;
  final String? giftName;
  final String? giftLogo;
  final String? giftCountryName;
  final String? giftCountryFlag;
  final String? giftPrice;
  final String? giftQty;
  final String? giftFee;
  final String? giftAmount;
  final String? reference;
  final dynamic promoCode;
  final String? status;
  final String? reloadlyStatus;
  final String? copySendStatus;
  final dynamic giftDetails;
  final dynamic adminDetails;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic profit;

  Datum({
    this.id,
    this.userId,
    this.countryCode,
    this.phoneNumber,
    this.giftId,
    this.giftName,
    this.giftLogo,
    this.giftCountryName,
    this.giftCountryFlag,
    this.giftPrice,
    this.giftQty,
    this.giftFee,
    this.giftAmount,
    this.reference,
    this.promoCode,
    this.status,
    this.reloadlyStatus,
    this.copySendStatus,
    this.giftDetails,
    this.adminDetails,
    this.createdAt,
    this.updatedAt,
    this.profit,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        countryCode: json["country_code"],
        phoneNumber: json["phone_number"],
        giftId: json["gift_id"],
        giftName: json["gift_name"],
        giftLogo: json["gift_logo"],
        giftCountryName: json["gift_country_name"],
        giftCountryFlag: json["gift_country_flag"],
        giftPrice: json["gift_price"],
        giftQty: json["gift_qty"],
        giftFee: json["gift_fee"],
        giftAmount: json["gift_amount"],
        reference: json["reference"],
        promoCode: json["promo_code"],
        status: json["status"],
        reloadlyStatus: json["reloadly_status"],
        copySendStatus: json["copy_send_status"],
        giftDetails: json["gift_details"],
        adminDetails: json["admin_details"],
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
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "gift_id": giftId,
        "gift_name": giftName,
        "gift_logo": giftLogo,
        "gift_country_name": giftCountryName,
        "gift_country_flag": giftCountryFlag,
        "gift_price": giftPrice,
        "gift_qty": giftQty,
        "gift_fee": giftFee,
        "gift_amount": giftAmount,
        "reference": reference,
        "promo_code": promoCode,
        "status": status,
        "reloadly_status": reloadlyStatus,
        "copy_send_status": copySendStatus,
        "gift_details": giftDetails,
        "admin_details": adminDetails,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profit": profit,
      };
}
