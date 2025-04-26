import 'dart:convert';

class StoreModel {
  String? name;
  String? website;
  String? description;
  String? imageUrl;
  String? userId;

  StoreModel({
    this.name,
    this.website,
    this.description,
    this.imageUrl,
    this.userId,
  });

  StoreModel copyWith({
    String? name,
    String? website,
    String? description,
    String? imageUrl,
    String? userId,
  }) =>
      StoreModel(
        name: name ?? this.name,
        website: website ?? this.website,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        userId: userId ?? this.userId,
      );

  factory StoreModel.fromJson(String str) =>
      StoreModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoreModel.fromMap(Map<String, dynamic> json) => StoreModel(
        name: json["name"],
        website: json["website"],
        description: json["description"],
        imageUrl: json["image_url"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "website": website,
        "description": description,
        "image_url": imageUrl,
        "user_id": userId,
      };
}
