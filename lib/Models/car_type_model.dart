// To parse this JSON data, do
//
//     final carTypeModel = carTypeModelFromJson(jsonString);

import 'dart:convert';

CarTypeModel carTypeModelFromJson(String str) =>
    CarTypeModel.fromJson(json.decode(str));

String carTypeModelToJson(CarTypeModel data) => json.encode(data.toJson());

class CarTypeModel {
  String? booth;
  String? compressor;
  List<Car>? cars;
  String? title;

  CarTypeModel({
    this.booth,
    this.compressor,
    this.cars,
    this.title,
  });

  factory CarTypeModel.fromJson(Map<String, dynamic> json) => CarTypeModel(
        booth: json["booth"],
        compressor: json["compressor"],
        cars: json["cars"] == null
            ? []
            : List<Car>.from(json["cars"]!.map((x) => Car.fromJson(x))),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "booth": booth,
        "compressor": compressor,
        "cars": cars == null
            ? []
            : List<dynamic>.from(cars!.map((x) => x.toJson())),
        "title": title,
      };
}

class Car {
  String? id;
  String? type;
  String? name;
  String? price;
  String? price15;
  String? price30;
  String? price60;
  DateTime? createdAt;
  DateTime? updatedAt;

  Car({
    this.id,
    this.type,
    this.name,
    this.price,
    this.price15,
    this.price30,
    this.price60,
    this.createdAt,
    this.updatedAt,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        price: json["price"],
        price15: json["price_15"],
        price30: json["price_30"],
        price60: json["price_60"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "price": price,
        "price_15": price15,
        "price_30": price30,
        "price_60": price60,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
