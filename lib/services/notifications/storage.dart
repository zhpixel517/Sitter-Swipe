import 'package:sitter_swipe/resources/strings.dart';

enum NotificationType {
  swipe,
  message,
}

class Notification {
  NotificationType? notificationType; // either a swipe or a message
  String? message;
  String? fromUser;
  String? fromUserImage;
  Notification({
    this.notificationType,
    this.message,
    this.fromUser,
    this.fromUserImage,
  });
}

// need to retrieve and hold list of notifications