import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/models/enums/notification_type.dart';
import 'package:sitter_swipe/models/notification.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/routes.dart';

class NotificationCard extends StatefulWidget {
  bool read;
  String? profilePictureLocator;
  CustomNotification? notificationData;
  NotificationCard(
      {required this.profilePictureLocator,
      required this.notificationData,
      required this.read,
      Key? key})
      : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

Icon _returnCorrectNotificationIcon(NotificationType notificationType) {
  switch (notificationType) {
    case NotificationType.newSwipe:
      return const Icon(
        EvaIcons.messageCircle,
        color: TanPallete.tan,
      );

    case NotificationType.message:
      return const Icon(
        EvaIcons.heart,
        color: TanPallete.tan,
      );
    case NotificationType.other:
      return const Icon(
        EvaIcons.bell,
        color: TanPallete.tan,
      );
  }
}

_getCorrectNotificationText(NotificationType notificationType,
    {String fromUser = '', String customNotificationText = ''}) {
  switch (notificationType) {
    case NotificationType.newSwipe:
      return "Someone swiped right on you! ";
    case NotificationType.message:
      return "You have a new message from $fromUser ";
    case NotificationType.other:
      return customNotificationText;
    default:
      return "";
  }
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key(''),
      onDismissed: (direction) {},
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: InkWell(
            onTap: () {
              // hop to a certain page index at baseScreen?
            },
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: _returnCorrectNotificationIcon(
                        widget.notificationData!.notificationType!)),
                Expanded(
                    flex: 5,
                    child: Text(
                      _getCorrectNotificationText(
                          widget.notificationData!.notificationType!,
                          fromUser: widget.notificationData!.fromUser!),
                      style: widget.read
                          ? Fonts.bold.copyWith(fontSize: 15)
                          : Fonts.mediumStyle.copyWith(fontSize: 15),
                    )),
                Expanded(
                  child: Container(
                    child: Center(
                        child: Text(
                      "4:55",
                      style: Fonts.smallText,
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
