// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.multicastId,
    this.success,
    this.failure,
    this.canonicalIds,
    this.results,
  });

  double? multicastId;
  int? success;
  int? failure;
  int? canonicalIds;
  List<Result>? results;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    multicastId: json["multicast_id"].toDouble(),
    success: json["success"],
    failure: json["failure"],
    canonicalIds: json["canonical_ids"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "multicast_id": multicastId,
    "success": success,
    "failure": failure,
    "canonical_ids": canonicalIds,
    "results": List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.messageId,
  });

  String? messageId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    messageId: json["message_id"],
  );

  Map<String, dynamic> toJson() => {
    "message_id": messageId,
  };
}
