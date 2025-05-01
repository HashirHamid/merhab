// To parse this JSON data, do
//
//     final tripModel = tripModelFromJson(jsonString);

import 'dart:convert';

import 'package:merhab/models/trip_plan_model/activity_model.dart';

List<TripModel> tripModelFromJson(String str) =>
    List<TripModel>.from(json.decode(str).map((x) => TripModel.fromJson(x)));

String tripModelToJson(List<TripModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TripModel {
  String? id;
  String? createdAt;
  String? tripName;
  String? startDate;
  String? endDate;
  String? tripDescription;
  String? tripDestination;
  List<ActivityModel>? activities;
  String? travelerName;
  String? travelerContact;
  String? userId;

  TripModel(
      {this.id,
      this.createdAt,
      this.tripName,
      this.startDate,
      this.endDate,
      this.tripDescription,
      this.tripDestination,
      this.activities,
      this.travelerName,
      this.travelerContact,
      this.userId});

  TripModel copyWith(
          {String? id,
          String? createdAt,
          String? tripName,
          String? startDate,
          String? endDate,
          String? tripDescription,
          List<ActivityModel>? activities,
          String? userId,
          String? tripDestination}) =>
      TripModel(
          id: id ?? this.id,
          createdAt: createdAt ?? this.createdAt,
          tripName: tripName ?? this.tripName,
          startDate: startDate ?? this.startDate,
          endDate: endDate ?? this.endDate,
          tripDescription: tripDescription ?? this.tripDescription,
          tripDestination: tripDestination ?? this.tripDestination,
          userId: userId ?? this.userId,
          activities: activities ?? this.activities);

  factory TripModel.fromJson(Map<String, dynamic> json,
          {List<Map<String, dynamic>>? activities}) =>
      TripModel(
          id: json["id"],
          createdAt: json["created_at"],
          tripName: json["trip_name"],
          startDate: json["start_date"],
          endDate: json["end_date"],
          tripDescription: json["trip_description"],
          tripDestination: json["trip_destination"],
          travelerName: json['traveler_name'],
          travelerContact: json['traveler_contact'],
          userId: json['user_id'],
          activities: activities != null
              ? activities.map((e) => ActivityModel.fromJson(e)).toList()
              : []);

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "trip_name": tripName,
        "start_date": startDate,
        //"${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": endDate,
        //"${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "trip_description": tripDescription,
        "trip_destination": tripDestination,
        "traveler_name": travelerName,
        "traveler_contact": travelerContact,
        "user_id": userId
      };
}
