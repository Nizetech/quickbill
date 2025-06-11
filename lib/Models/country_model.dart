// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  bool? result;
  List<Country>? countries;

  CountryModel({
    this.result,
    this.countries,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        result: json["result"],
        countries: json["countries"] == null
            ? []
            : List<Country>.from(
                json["countries"]!.map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "countries": countries == null
            ? []
            : List<dynamic>.from(countries!.map((x) => x.toJson())),
      };
}

class Country {
  String? countryCode;
  String? countryName;
  String? countryFlag;

  Country({
    this.countryCode,
    this.countryName,
    this.countryFlag,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryCode: json["country_code"],
        countryName: json["country_name"],
        countryFlag: json["country_flag"],
      );

  Map<String, dynamic> toJson() => {
        "country_code": countryCode,
        "country_name": countryName,
        "country_flag": countryFlag,
      };
}
