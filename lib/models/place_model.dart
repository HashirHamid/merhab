import 'dart:convert';

class PlaceModel {
  String? id;
  String? name;
  String? description;
  double? latitude;
  double? longitude;
  List<String>? images;
  String? startTime;
  String? endTime;
  int? priceStart;
  int? priceEnd;
  String? userId;
  DateTime? createdAt;

  PlaceModel({
    this.id,
    this.name,
    this.description,
    this.latitude,
    this.longitude,
    this.images,
    this.startTime,
    this.endTime,
    this.priceStart,
    this.priceEnd,
    this.userId,
    this.createdAt,
  });

  PlaceModel copyWith({
    String? id,
    String? name,
    String? description,
    double? latitude,
    double? longitude,
    List<String>? images,
    String? startTime,
    String? endTime,
    int? priceStart,
    int? priceEnd,
    String? userId,
    DateTime? createdAt,
  }) =>
      PlaceModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        images: images ?? this.images,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        priceStart: priceStart ?? this.priceStart,
        priceEnd: priceEnd ?? this.priceEnd,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
      );

  factory PlaceModel.fromJson(String str) =>
      PlaceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromMap(Map<String, dynamic> json) => PlaceModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        startTime: json["start_time"],
        endTime: json["end_time"],
        priceStart: json["price_start"],
        priceEnd: json["price_end"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "start_time": startTime,
        "end_time": endTime,
        "price_start": priceStart,
        "price_end": priceEnd,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
      };
}
