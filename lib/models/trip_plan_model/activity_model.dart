// To parse this JSON data, do
//
//     final activityModel = activityModelFromJson(jsonString);

import 'dart:convert';

List<ActivityModel> activityModelFromJson(String str) =>
    List<ActivityModel>.from(
        json.decode(str).map((x) => ActivityModel.fromJson(x)));

String activityModelToJson(List<ActivityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityModel {
  String? id;
  DateTime? createdAt;
  String? activityType;
  String? eventName;
  String? venue;
  String? address;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? timezone;
  bool? confirmationStatus;
  String? tripId;

  ActivityModel(
      {this.id,
      this.createdAt,
      this.activityType,
      this.eventName,
      this.venue,
      this.address,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.timezone,
      this.confirmationStatus,
      this.tripId});

  ActivityModel copyWith({
    String? id,
    DateTime? createdAt,
    String? activityType,
    String? eventName,
    String? venue,
    String? address,
    String? startDate,
    String? endDate,
    String? startTime,
    String? endTime,
    String? timezone,
    bool? confirmationStatus,
    String? tripId,
  }) =>
      ActivityModel(
          id: id ?? this.id,
          createdAt: createdAt ?? this.createdAt,
          activityType: activityType ?? this.activityType,
          eventName: eventName ?? this.eventName,
          venue: venue ?? this.venue,
          address: address ?? this.address,
          startDate: startDate ?? this.startDate,
          endDate: endDate ?? this.endDate,
          startTime: startTime ?? this.startTime,
          endTime: endTime ?? this.endTime,
          timezone: timezone ?? this.timezone,
          confirmationStatus: confirmationStatus ?? this.confirmationStatus,
          tripId: tripId ?? this.tripId);

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        activityType: json["activity_type"],
        eventName: json["event_name"],
        venue: json["venue"],
        address: json["address"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        timezone: json["timezone"],
        confirmationStatus: json["confirmation_status"],
        tripId: json['trip_id']
      );

  Map<String, dynamic> toJson() => {
    "activity_type": activityType,
    "event_name": eventName,
    "venue": venue,
    "address":address,
    "start_date": startDate,
    "end_date": endDate,
    "start_time": startTime,
    "end_time": endTime,
    "timezone": timezone,
    "trip_id": tripId 
  };
}
