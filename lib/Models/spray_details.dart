// To parse this JSON data, do
//
//     final sprayDetailsModel = sprayDetailsModelFromJson(jsonString);

import 'dart:convert';

SprayDetailsModel sprayDetailsModelFromJson(String str) =>
    SprayDetailsModel.fromJson(json.decode(str));

String sprayDetailsModelToJson(SprayDetailsModel data) =>
    json.encode(data.toJson());

class SprayDetailsModel {
  String? status;
  List<Details>? data;
  Check? check;
  Color? color;

  SprayDetailsModel({
    this.status,
    this.data,
    this.check,
    this.color,
  });

  factory SprayDetailsModel.fromJson(Map<String, dynamic> json) =>
      SprayDetailsModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Details>.from(json["data"]!.map((x) => Details.fromJson(x))),
        check: json["check"] == null ? null : Check.fromJson(json["check"]),
        color: json["color"] == null ? null : Color.fromJson(json["color"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "check": check?.toJson(),
        "color": color?.toJson(),
      };
}

class Check {
  String? id;
  String? user;
  String? reference;
  String? rentType;
  String? carType;
  String? image;
  DateTime? date;
  String? time;
  String? careDay;
  String? package;
  String? paintType;
  String? price;
  String? total;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? extraFee;
  dynamic notification;

  Check({
    this.id,
    this.user,
    this.reference,
    this.rentType,
    this.carType,
    this.image,
    this.date,
    this.time,
    this.careDay,
    this.package,
    this.paintType,
    this.price,
    this.total,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.extraFee,
    this.notification,
  });

  factory Check.fromJson(Map<String, dynamic> json) => Check(
        id: json["id"],
        user: json["user"],
        reference: json["reference"],
        rentType: json["rentType"],
        carType: json["carType"],
        image: json["image"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"],
        careDay: json["careDay"],
        package: json["package"],
        paintType: json["paintType"],
        price: json["price"],
        total: json["total"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        extraFee: json["extraFee"],
        notification: json["notification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "reference": reference,
        "rentType": rentType,
        "carType": carType,
        "image": image,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "careDay": careDay,
        "package": package,
        "paintType": paintType,
        "price": price,
        "total": total,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "extraFee": extraFee,
        "notification": notification,
      };
}

class Color {
  String? id;
  String? type;
  String? name;
  String? price;
  String? price15;
  String? price30;
  String? price60;
  DateTime? createdAt;
  DateTime? updatedAt;

  Color({
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

  factory Color.fromJson(Map<String, dynamic> json) => Color(
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

class Details {
  String? id;
  String? careDay;
  String? status;
  dynamic extraFee;
  dynamic description;
  String? name;
  String? price;
  String? price15;
  String? price30;
  String? price60;

  Details({
    this.id,
    this.careDay,
    this.status,
    this.extraFee,
    this.description,
    this.name,
    this.price,
    this.price15,
    this.price30,
    this.price60,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        careDay: json["careDay"],
        status: json["status"],
        extraFee: json["extraFee"],
        description: json["description"],
        name: json["name"],
        price: json["price"],
        price15: json["price_15"],
        price30: json["price_30"],
        price60: json["price_60"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "careDay": careDay,
        "status": status,
        "extraFee": extraFee,
        "description": description,
        "name": name,
        "price": price,
        "price_15": price15,
        "price_30": price30,
        "price_60": price60,
      };
}
