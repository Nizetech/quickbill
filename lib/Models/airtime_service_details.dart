// To parse this JSON data, do
//
//     final airtimeServiceModel = airtimeServiceModelFromJson(jsonString);

import 'dart:convert';

AirtimeServiceModel airtimeServiceModelFromJson(String str) =>
    AirtimeServiceModel.fromJson(json.decode(str));

String airtimeServiceModelToJson(AirtimeServiceModel data) =>
    json.encode(data.toJson());

class AirtimeServiceModel {
  List<Detail>? details;


  AirtimeServiceModel({
    this.details,
  });

  factory AirtimeServiceModel.fromJson(Map<String, dynamic> json) =>
      AirtimeServiceModel(
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

  String? networkName;
  String? phone;


  Detail({
    this.networkName,
    this.phone,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        networkName: json["network_name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "network_name": networkName,
        "phone": phone,
      };
}
