// To parse this JSON data, do
//
//     final dataServiceModel = dataServiceModelFromJson(jsonString);

import 'dart:convert';

DataServiceModel dataServiceModelFromJson(String str) =>
    DataServiceModel.fromJson(json.decode(str));

String dataServiceModelToJson(DataServiceModel data) =>
    json.encode(data.toJson());

class DataServiceModel {
  List<Detail>? details;

  DataServiceModel({
    this.details,
  });

  factory DataServiceModel.fromJson(Map<String, dynamic> json) =>
      DataServiceModel(
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
