// To parse this JSON data, do
//
//     final dataHistoryModel = dataHistoryModelFromJson(jsonString);

import 'dart:convert';

DataHistoryModel dataHistoryModelFromJson(String str) =>
    DataHistoryModel.fromJson(json.decode(str));

String dataHistoryModelToJson(DataHistoryModel data) =>
    json.encode(data.toJson());

class DataHistoryModel {
  final bool? result;
  final List<Datum>? data;

  DataHistoryModel({
    this.result,
    this.data,
  });

  factory DataHistoryModel.fromJson(Map<String, dynamic> json) =>
      DataHistoryModel(
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
  final String? networkId;
  final String? networkName;
  final DataType? dataType;
  final String? planId;
  final String? planSize;
  final String? planName;
  final String? vtungPlanId;
  final String? vtungPlanName;
  final String? amount;
  final String? phone;
  final String? reference;
  final String? status;
  final ApiMessage? apiMessage;
  final String? apiStatus;
  final dynamic promoCode;
  final String? isPromoRewarded;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic vtpassPlanId;
  final dynamic vtpassPlanName;
  final dynamic profit;

  Datum({
    this.id,
    this.userId,
    this.networkId,
    this.networkName,
    this.dataType,
    this.planId,
    this.planSize,
    this.planName,
    this.vtungPlanId,
    this.vtungPlanName,
    this.amount,
    this.phone,
    this.reference,
    this.status,
    this.apiMessage,
    this.apiStatus,
    this.promoCode,
    this.isPromoRewarded,
    this.createdAt,
    this.updatedAt,
    this.vtpassPlanId,
    this.vtpassPlanName,
    this.profit,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        networkId: json["network_id"],
        networkName: json["network_name"],
        dataType: dataTypeValues.map[json["data_type"]],
        planId: json["plan_id"],
        planSize: json["plan_size"],
        planName: json["plan_name"],
        vtungPlanId: json["vtung_plan_id"],
        vtungPlanName: json["vtung_plan_name"],
        amount: json["amount"],
        phone: json["phone"],
        reference: json["reference"],
        status: json["status"],
        apiMessage: apiMessageValues.map[json["api_message"]],
        apiStatus: json["api_status"],
        promoCode: json["promo_code"],
        isPromoRewarded: json["is_promo_rewarded"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        vtpassPlanId: json["vtpass_plan_id"],
        vtpassPlanName: json["vtpass_plan_name"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "network_id": networkId,
        "network_name": networkNameValues.reverse[networkName],
        "data_type": dataTypeValues.reverse[dataType],
        "plan_id": planId,
        "plan_size": planSize,
        "plan_name": planName,
        "vtung_plan_id": vtungPlanId,
        "vtung_plan_name": vtungPlanName,
        "amount": amount,
        "phone": phone,
        "reference": reference,
        "status": status,
        "api_message": apiMessageValues.reverse[apiMessage],
        "api_status": apiStatus,
        "promo_code": promoCode,
        "is_promo_rewarded": isPromoRewarded,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "vtpass_plan_id": vtpassPlanId,
        "vtpass_plan_name": vtpassPlanName,
        "profit": profit,
      };
}

enum ApiMessage { EMPTY, TRANSACTION_SUCCESSFUL }

final apiMessageValues = EnumValues({
  "": ApiMessage.EMPTY,
  "TRANSACTION SUCCESSFUL": ApiMessage.TRANSACTION_SUCCESSFUL
});

enum DataType { SME }

final dataTypeValues = EnumValues({"SME": DataType.SME});

enum NetworkName { MTN }

final networkNameValues = EnumValues({"MTN": NetworkName.MTN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
