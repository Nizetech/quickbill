// To parse this JSON data, do
//
//     final carDetailsModel = carDetailsModelFromJson(jsonString);

import 'dart:convert';

CarDetailsModel carDetailsModelFromJson(String str) =>
    CarDetailsModel.fromJson(json.decode(str));

String carDetailsModelToJson(CarDetailsModel data) =>
    json.encode(data.toJson());

class CarDetailsModel {
  final int? id;
  final Car? car;
  final List<String>? galleries;
  final double? balance;
  final String? title;
  final String? metaDescription;

  CarDetailsModel({
    this.id,
    this.car,
    this.galleries,
    this.balance,
    this.title,
    this.metaDescription,
  });

  factory CarDetailsModel.fromJson(Map<String, dynamic> json) =>
      CarDetailsModel(
        id: json["id"],
        car: json["car"] == null ? null : Car.fromJson(json["car"]),
        galleries: json["galleries"] == null
            ? []
            : List<String>.from(json["galleries"]!.map((x) => x)),
        balance: json["balance"]?.toDouble(),
        title: json["title"],
        metaDescription: json["meta_description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "car": car?.toJson(),
        "galleries": galleries == null
            ? []
            : List<dynamic>.from(galleries!.map((x) => x)),
        "balance": balance,
        "title": title,
        "meta_description": metaDescription,
      };
}

class Car {
  final String? id;
  final String? title;
  final String? carImage;
  final String? galleries;
  final String? price;
  final String? maker;
  final String? model;
  final String? year;
  final String? color;
  final String? driverTrain;
  final String? transmission;
  final String? engine;
  final String? fuel;
  final String? vin;
  final String? mileage;
  final String? views;
  final String? published;
  final DateTime? publishedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Car({
    this.id,
    this.title,
    this.carImage,
    this.galleries,
    this.price,
    this.maker,
    this.model,
    this.year,
    this.color,
    this.driverTrain,
    this.transmission,
    this.engine,
    this.fuel,
    this.vin,
    this.mileage,
    this.views,
    this.published,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        title: json["title"],
        carImage: json["car_image"],
        galleries: json["galleries"],
        price: json["price"],
        maker: json["maker"],
        model: json["model"],
        year: json["year"],
        color: json["color"],
        driverTrain: json["driver_train"],
        transmission: json["transmission"],
        engine: json["engine"],
        fuel: json["fuel"],
        vin: json["vin"],
        mileage: json["mileage"],
        views: json["views"],
        published: json["published"],
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "car_image": carImage,
        "galleries": galleries,
        "price": price,
        "maker": maker,
        "model": model,
        "year": year,
        "color": color,
        "driver_train": driverTrain,
        "transmission": transmission,
        "engine": engine,
        "fuel": fuel,
        "vin": vin,
        "mileage": mileage,
        "views": views,
        "published": published,
        "published_at": publishedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
