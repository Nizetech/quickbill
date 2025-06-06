// To parse this JSON data, do
//
//     final networkProviderModel = networkProviderModelFromJson(jsonString);

import 'dart:convert';

NetworkProviderModel networkProviderModelFromJson(String str) =>
    NetworkProviderModel.fromJson(json.decode(str));

String networkProviderModelToJson(NetworkProviderModel data) =>
    json.encode(data.toJson());

class NetworkProviderModel {
  List<Network>? networks;

  NetworkProviderModel({
    this.networks,
  });

  factory NetworkProviderModel.fromJson(Map<String, dynamic> json) =>
      NetworkProviderModel(
        networks: json["networks"] == null
            ? []
            : List<Network>.from(
                json["networks"]!.map((x) => Network.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "networks": networks == null
            ? []
            : List<dynamic>.from(networks!.map((x) => x.toJson())),
      };
}

class Network {
  String? network;
  int? networkId;
  String? logo;

  Network({
    this.network,
    this.networkId,
    this.logo,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        network: json["network"],
        networkId: json["networkId"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "network": network,
        "networkId": networkId,
        "logo": logo,
      };
}
