// To parse this JSON data, do
//
//     final cableServiceModel = cableServiceModelFromJson(jsonString);

import 'dart:convert';

CableServiceModel cableServiceModelFromJson(String str) =>
    CableServiceModel.fromJson(json.decode(str));

String cableServiceModelToJson(CableServiceModel data) =>
    json.encode(data.toJson());

class CableServiceModel {
  List<Detail>? details;


  CableServiceModel({
    this.details,

  });

  factory CableServiceModel.fromJson(Map<String, dynamic> json) =>
      CableServiceModel(
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  String? phone;
  String? networkName;
  String? smartCard;
  String? package;


  Detail({
    this.networkName,
    this.phone,
    this.smartCard,
    this.package,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        networkName: json["network_name"],
        phone: json["phone"],
        smartCard: json["smart_card"],
        package: json["package"],
      );

  Map<String, dynamic> toJson() => {
        "network_name": networkName,
        "phone": phone,
        "smart_card": smartCard,
        "package": package,
      };
}
