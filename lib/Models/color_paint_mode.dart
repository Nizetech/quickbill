// To parse this JSON data, do
//
//     final colorPaintModel = colorPaintModelFromJson(jsonString);

import 'dart:convert';

ColorPaintModel colorPaintModelFromJson(String str) =>
    ColorPaintModel.fromJson(json.decode(str));

String colorPaintModelToJson(ColorPaintModel data) =>
    json.encode(data.toJson());

class ColorPaintModel {
  List<PaintColor>? paints;
  PaintColor? color;
  List<PaintColor>? touches;
  String? title;
  String? metaDescription;

  ColorPaintModel({
    this.paints,
    this.color,
    this.touches,
    this.title,
    this.metaDescription,
  });

  factory ColorPaintModel.fromJson(Map<String, dynamic> json) =>
      ColorPaintModel(
        paints: json["paints"] == null
            ? []
            : List<PaintColor>.from(
                json["paints"]!.map((x) => PaintColor.fromJson(x))),
        color:
            json["color"] == null ? null : PaintColor.fromJson(json["color"]),
        touches: json["touches"] == null
            ? []
            : List<PaintColor>.from(
                json["touches"]!.map((x) => PaintColor.fromJson(x))),
        title: json["title"],
        metaDescription: json["meta_description"],
      );

  Map<String, dynamic> toJson() => {
        "paints": paints == null
            ? []
            : List<dynamic>.from(paints!.map((x) => x.toJson())),
        "color": color?.toJson(),
        "touches": touches == null
            ? []
            : List<dynamic>.from(touches!.map((x) => x.toJson())),
        "title": title,
        "meta_description": metaDescription,
      };
}

class PaintColor {
  String? id;
  Type? type;
  String? name;
  String? price;
  String? price15;
  String? price30;
  String? price60;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaintColor({
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

  factory PaintColor.fromJson(Map<String, dynamic> json) => PaintColor(
        id: json["id"],
        type: typeValues.map[json["type"]]!,
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
        "type": typeValues.reverse[type],
        "name": name,
        "price": price,
        "price_15": price15,
        "price_30": price30,
        "price_60": price60,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum Type { COLOR, PAINT, TOUCH }

final typeValues =
    EnumValues({"color": Type.COLOR, "paint": Type.PAINT, "touch": Type.TOUCH});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
