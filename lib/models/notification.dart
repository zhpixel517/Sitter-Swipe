import 'package:sitter_swipe/models/enums/notification_type.dart';

class CustomNotification {
  NotificationType? notificationType;
  String? message;
  String? fromUser;
  String? fromUserImage;
  String? customText; // this is for other news and info
  DateTime timeStamp;
  CustomNotification(
      {this.notificationType,
      this.message,
      this.fromUser,
      this.fromUserImage,
      this.customText,
      required this.timeStamp});
}

// need to retrieve and hold list of notifications