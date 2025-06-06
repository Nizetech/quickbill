// To parse this JSON data, do
//
//     final airtimeHistory = airtimeHistoryFromJson(jsonString);

import 'dart:convert';

AirtimeHistory airtimeHistoryFromJson(String str) =>
    AirtimeHistory.fromJson(json.decode(str));

String airtimeHistoryToJson(AirtimeHistory data) => json.encode(data.toJson());

class AirtimeHistory {
  bool? result;
  List<Datum>? data;

  AirtimeHistory({
    this.result,
    this.data,
  });

  factory AirtimeHistory.fromJson(Map<String, dynamic> json) => AirtimeHistory(
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
  String? id;
  String? userId;
  String? networkId;
  String? networkName;
  AirtimeType? airtimeType;
  String? amount;
  String? phone;
  String? reference;
  String? status;
  String? apiMessage;
  String? apiStatus;
  dynamic promoCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic profit;

  Datum({
    this.id,
    this.userId,
    this.networkId,
    this.networkName,
    this.airtimeType,
    this.amount,
    this.phone,
    this.reference,
    this.status,
    this.apiMessage,
    this.apiStatus,
    this.promoCode,
    this.createdAt,
    this.updatedAt,
    this.profit,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        networkId: json["network_id"],
        networkName: json["network_name"]!,
        airtimeType: airtimeTypeValues.map[json["airtime_type"]]!,
        amount: json["amount"],
        phone: json["phone"],
        reference: json["reference"],
        status: json["status"],
        apiMessage: json["api_message"],
        apiStatus: json["api_status"],
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
        "network_id": networkId,
        "network_name": networkName,
        "airtime_type": airtimeTypeValues.reverse[airtimeType],
        "amount": amount,
        "phone": phone,
        "reference": reference,
        "status": status,
        "api_message": apiMessage,
        "api_status": apiStatus,
        "promo_code": promoCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profit": profit,
      };
}

enum AirtimeType { VTU }

final airtimeTypeValues = EnumValues({"VTU": AirtimeType.VTU});

enum NetworkName { AIRTEL, MTN }

final networkNameValues =
    EnumValues({"AIRTEL": NetworkName.AIRTEL, "MTN": NetworkName.MTN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
