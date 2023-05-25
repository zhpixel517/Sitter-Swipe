import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/broadcast/broadcast_viewmodel.dart';
import 'package:sitter_swipe/pages/broadcast/widgets/animated_avatar.dart';
import 'package:sitter_swipe/pages/broadcast/widgets/radio_art.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/services/di.dart';

class BroadcastPage extends StatefulWidget {
  const BroadcastPage({super.key});

  @override
  State<BroadcastPage> createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage>
    with SingleTickerProviderStateMixin {
  bool _hideBackgroundArt = false;
  //final _viewModel = instance<BroadcastViewModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(EvaIcons.arrowBack),
            onPressed: () {
              setState(() {
                _hideBackgroundArt = true;
              });
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
              child: IconButton(
                  onPressed: () {},
                  iconSize: AppSizes.largeIconSize,
                  icon: const Icon(EvaIcons.questionMarkCircle)),
            )
          ],
          title: Text(
            PageTitles.broadcast,
            style: Fonts.bold,
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            _hideBackgroundArt ? const SizedBox() : const RadioBackground(),
            const SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedAvatarWidget(
                    imagePath: "assets/images/parents1.png",
                  ),
                  /*
                const CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(boy1),
                )
                */
                ],
              ),
            ),
          ],
        ));
  }
}
