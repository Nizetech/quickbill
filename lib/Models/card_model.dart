// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  Product? product;
  List<num>? amounts;
  String? ngnPrice;
  num? giftFeePercent;
  num? balance;
  UserPurchaseInfo? userPurchaseInfo;

  CardModel({
    this.product,
    this.amounts,
    this.ngnPrice,
    this.giftFeePercent,
    this.balance,
    this.userPurchaseInfo,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        amounts: json["amounts"] == null
            ? []
            : List<num>.from(json["amounts"]!.map((x) => x)),
        ngnPrice: json["ngn_price"],
        giftFeePercent: num.parse(json["gift_fee_percent"].toString()),
        balance: num.parse(json["balance"].toString()),
        userPurchaseInfo: json["user_purchase_info"] == null
            ? null
            : UserPurchaseInfo.fromJson(json["user_purchase_info"]),
      );

  Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "amounts":
            amounts == null ? [] : List<dynamic>.from(amounts!.map((x) => x)),
        "ngn_price": ngnPrice,
        "gift_fee_percent": giftFeePercent,
        "balance": balance,
        "user_purchase_info": userPurchaseInfo?.toJson(),
      };
}

class Product {
  int? productId;
  String? productName;
  bool? global;
  String? status;
  bool? supportsPreOrder;
  num? senderFee;
  num? senderFeePercentage;
  num? discountPercentage;
  String? denominationType;
  String? recipientCurrencyCode;
  dynamic minRecipientDenomination;
  dynamic maxRecipientDenomination;
  String? senderCurrencyCode;
  dynamic minSenderDenomination;
  dynamic maxSenderDenomination;
  List<num>? fixedRecipientDenominations;
  List<num>? fixedSenderDenominations;
  FixedRecipientToSenderDenominationsMap?
      fixedRecipientToSenderDenominationsMap;
  List<dynamic>? metadata;
  List<String>? logoUrls;
  Brand? brand;
  Category? category;
  Country? country;
  RedeemInstruction? redeemInstruction;
  AdditionalRequirements? additionalRequirements;

  Product({
    this.productId,
    this.productName,
    this.global,
    this.status,
    this.supportsPreOrder,
    this.senderFee,
    this.senderFeePercentage,
    this.discountPercentage,
    this.denominationType,
    this.recipientCurrencyCode,
    this.minRecipientDenomination,
    this.maxRecipientDenomination,
    this.senderCurrencyCode,
    this.minSenderDenomination,
    this.maxSenderDenomination,
    this.fixedRecipientDenominations,
    this.fixedSenderDenominations,
    this.fixedRecipientToSenderDenominationsMap,
    this.metadata,
    this.logoUrls,
    this.brand,
    this.category,
    this.country,
    this.redeemInstruction,
    this.additionalRequirements,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        productName: json["productName"],
        global: json["global"],
        status: json["status"],
        supportsPreOrder: json["supportsPreOrder"],
        senderFee: num.parse(json["senderFee"].toString()),
        senderFeePercentage: num.parse(json["senderFeePercentage"].toString()),
        discountPercentage: num.parse(json["discountPercentage"].toString()),
        denominationType: json["denominationType"],
        recipientCurrencyCode: json["recipientCurrencyCode"],
        minRecipientDenomination: json["minRecipientDenomination"],
        maxRecipientDenomination: json["maxRecipientDenomination"],
        senderCurrencyCode: json["senderCurrencyCode"],
        minSenderDenomination: json["minSenderDenomination"],
        maxSenderDenomination: json["maxSenderDenomination"],
        fixedRecipientDenominations: json["fixedRecipientDenominations"] == null
            ? []
            : List<num>.from(
                json["fixedRecipientDenominations"]!.map((x) => x)),
        fixedSenderDenominations: json["fixedSenderDenominations"] == null
            ? []
            : List<num>.from(json["fixedSenderDenominations"]!.map((x) => x)),
        fixedRecipientToSenderDenominationsMap:
            json["fixedRecipientToSenderDenominationsMap"] == null
                ? null
                : FixedRecipientToSenderDenominationsMap.fromJson(
                    json["fixedRecipientToSenderDenominationsMap"]),
        metadata: json["metadata"] == null
            ? []
            : List<dynamic>.from(json["metadata"]!.map((x) => x)),
        logoUrls: json["logoUrls"] == null
            ? []
            : List<String>.from(json["logoUrls"]!.map((x) => x)),
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        redeemInstruction: json["redeemInstruction"] == null
            ? null
            : RedeemInstruction.fromJson(json["redeemInstruction"]),
        additionalRequirements: json["additionalRequirements"] == null
            ? null
            : AdditionalRequirements.fromJson(json["additionalRequirements"]),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "global": global,
        "status": status,
        "supportsPreOrder": supportsPreOrder,
        "senderFee": senderFee,
        "senderFeePercentage": senderFeePercentage,
        "discountPercentage": discountPercentage,
        "denominationType": denominationType,
        "recipientCurrencyCode": recipientCurrencyCode,
        "minRecipientDenomination": minRecipientDenomination,
        "maxRecipientDenomination": maxRecipientDenomination,
        "senderCurrencyCode": senderCurrencyCode,
        "minSenderDenomination": minSenderDenomination,
        "maxSenderDenomination": maxSenderDenomination,
        "fixedRecipientDenominations": fixedRecipientDenominations == null
            ? []
            : List<dynamic>.from(fixedRecipientDenominations!.map((x) => x)),
        "fixedSenderDenominations": fixedSenderDenominations == null
            ? []
            : List<dynamic>.from(fixedSenderDenominations!.map((x) => x)),
        "fixedRecipientToSenderDenominationsMap":
            fixedRecipientToSenderDenominationsMap?.toJson(),
        "metadata":
            metadata == null ? [] : List<dynamic>.from(metadata!.map((x) => x)),
        "logoUrls":
            logoUrls == null ? [] : List<dynamic>.from(logoUrls!.map((x) => x)),
        "brand": brand?.toJson(),
        "category": category?.toJson(),
        "country": country?.toJson(),
        "redeemInstruction": redeemInstruction?.toJson(),
        "additionalRequirements": additionalRequirements?.toJson(),
      };
}

class AdditionalRequirements {
  bool? userIdRequired;

  AdditionalRequirements({
    this.userIdRequired,
  });

  factory AdditionalRequirements.fromJson(Map<String, dynamic> json) =>
      AdditionalRequirements(
        userIdRequired: json["userIdRequired"],
      );

  Map<String, dynamic> toJson() => {
        "userIdRequired": userIdRequired,
      };
}

class Brand {
  int? brandId;
  String? brandName;

  Brand({
    this.brandId,
    this.brandName,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        brandId: json["brandId"],
        brandName: json["brandName"],
      );

  Map<String, dynamic> toJson() => {
        "brandId": brandId,
        "brandName": brandName,
      };
}

class Category {
  int? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Country {
  String? isoName;
  String? name;
  String? flagUrl;

  Country({
    this.isoName,
    this.name,
    this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        isoName: json["isoName"],
        name: json["name"],
        flagUrl: json["flagUrl"],
      );

  Map<String, dynamic> toJson() => {
        "isoName": isoName,
        "name": name,
        "flagUrl": flagUrl,
      };
}

class FixedRecipientToSenderDenominationsMap {
  int? the2000;

  FixedRecipientToSenderDenominationsMap({
    this.the2000,
  });

  factory FixedRecipientToSenderDenominationsMap.fromJson(
          Map<String, dynamic> json) =>
      FixedRecipientToSenderDenominationsMap(
        the2000: json["20.00"],
      );

  Map<String, dynamic> toJson() => {
        "20.00": the2000,
      };
}

class RedeemInstruction {
  String? concise;
  String? verbose;

  RedeemInstruction({
    this.concise,
    this.verbose,
  });

  factory RedeemInstruction.fromJson(Map<String, dynamic> json) =>
      RedeemInstruction(
        concise: json["concise"],
        verbose: json["verbose"],
      );

  Map<String, dynamic> toJson() => {
        "concise": concise,
        "verbose": verbose,
      };
}

class UserPurchaseInfo {
  String? purchaseLimited;
  String? purchasedAmount;
  String? purchaseLimitAmount;

  UserPurchaseInfo({
    this.purchaseLimited,
    this.purchasedAmount,
    this.purchaseLimitAmount,
  });

  factory UserPurchaseInfo.fromJson(Map<String, dynamic> json) =>
      UserPurchaseInfo(
        purchaseLimited: json["purchase_limited"].toString(),
        purchasedAmount: json["purchased_amount"].toString(),
        purchaseLimitAmount: json["purchase_limit_amount"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "purchase_limited": purchaseLimited,
        "purchased_amount": purchasedAmount,
        "purchase_limit_amount": purchaseLimitAmount,
      };
}
