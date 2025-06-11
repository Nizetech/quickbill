// To parse this JSON data, do
//
//     final giftCardsModel = giftCardsModelFromJson(jsonString);

import 'dart:convert';

GiftCardsModel giftCardsModelFromJson(String str) =>
    GiftCardsModel.fromJson(json.decode(str));

String giftCardsModelToJson(GiftCardsModel data) => json.encode(data.toJson());

class GiftCardsModel {
  bool? result;
  List<GiftCard>? giftCards;

  GiftCardsModel({
    this.result,
    this.giftCards,
  });

  factory GiftCardsModel.fromJson(Map<String, dynamic> json) => GiftCardsModel(
        result: json["result"],
        giftCards: json["gift_cards"] == null
            ? []
            : List<GiftCard>.from(
                json["gift_cards"]!.map((x) => GiftCard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "gift_cards": giftCards == null
            ? []
            : List<dynamic>.from(giftCards!.map((x) => x.toJson())),
      };
}

class GiftCard {
  int? id;
  String? name;
  List<String>? image;

  GiftCard({
    this.id,
    this.name,
    this.image,
  });

  factory GiftCard.fromJson(Map<String, dynamic> json) => GiftCard(
        id: json["id"],
        name: json["name"],
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
      };
}
