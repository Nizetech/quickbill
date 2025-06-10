// To parse this JSON data, do
//
//     final socialSectionsModel = socialSectionsModelFromJson(jsonString);

import 'dart:convert';

SocialSectionsModel socialSectionsModelFromJson(String str) =>
    SocialSectionsModel.fromJson(json.decode(str));

String socialSectionsModelToJson(SocialSectionsModel data) =>
    json.encode(data.toJson());

class SocialSectionsModel {
  bool? result;
  List<Section>? sections;

  SocialSectionsModel({
    this.result,
    this.sections,
  });

  factory SocialSectionsModel.fromJson(Map<String, dynamic> json) =>
      SocialSectionsModel(
        result: json["result"],
        sections: json["sections"] == null
            ? []
            : List<Section>.from(
                json["sections"]!.map((x) => Section.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "sections": sections == null
            ? []
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
      };
}

class Section {
  String? id;
  String? sectionName;
  String? sectionImage;
  String? locked;
  dynamic lockedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Section({
    this.id,
    this.sectionName,
    this.sectionImage,
    this.locked,
    this.lockedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        sectionName: json["section_name"],
        sectionImage: json["section_image"],
        locked: json["locked"],
        lockedAt: json["locked_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "section_name": sectionName,
        "section_image": sectionImage,
        "locked": locked,
        "locked_at": lockedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
