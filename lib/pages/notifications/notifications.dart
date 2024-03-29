// notifications screen
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/notifications/notifications_viewmodel.dart';
import 'package:sitter_swipe/pages/notifications/widgets/notification_item.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/services/di.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationPageViewModel _viewModel =
      instance<NotificationPageViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.start();
  }

  final List<NotificationCard> notifications = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(PageTitles.notifications),
          leading: IconButton(
            icon: const Icon(EvaIcons.arrowBack),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.globalContentSidePadding),
            child: notifications.isNotEmpty
                ? ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return notifications[index];
                    })
                : _noNotifications()));
  }

  _noNotifications() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            EvaIcons.smilingFace,
            color: TanPallete.lightGrey,
            size: 30.0,
          ),
          Text(
            "All caught up!",
            style: Fonts.smallText.copyWith(fontSize: 18.0),
          )
        ],
      ),
    );
  }
}

/*
    NotificationCard(
        read: true,
        profilePictureLocator: '',
        notificationData: CustomNotification(
            timeStamp: DateTime.now(),
            fromUser: "Zachary",
            notificationType: NotificationType.message,
            fromUserImage: "",
            message: "")),
    NotificationCard(
      read: false,
      profilePictureLocator: '',
      notificationData: CustomNotification(
        timeStamp: DateTime.now(),
        fromUser: "Joseph",
        notificationType: NotificationType.newSwipe,
        fromUserImage: "",
      ),
    ),
    NotificationCard(
        read: true,
        profilePictureLocator: "",
        notificationData: CustomNotification(
            timeStamp: DateTime.now(),
            fromUser: "Sitter Swipe",
            notificationType: NotificationType.other,
            fromUserImage: "",
            customText: "New changes to privacy policy"))
            */