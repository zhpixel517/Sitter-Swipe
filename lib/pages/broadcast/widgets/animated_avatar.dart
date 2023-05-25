import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/broadcast/broadcast_viewmodel.dart';
import 'package:sitter_swipe/pages/broadcast/widgets/circle_animation.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/services/di.dart';

class AnimatedAvatarWidget extends StatefulWidget {
  final String? imagePath;
  const AnimatedAvatarWidget({super.key, required this.imagePath});

  @override
  State<AnimatedAvatarWidget> createState() => _AnimatedAvatarWidgetState();
}

class _AnimatedAvatarWidgetState extends State<AnimatedAvatarWidget>
    with TickerProviderStateMixin {
  final BroadcastViewModel _viewModel = instance<BroadcastViewModel>();

  double radius = 75.0;
  double rippleRadius = 60.0;
  AnimationController? avatarSizeController;
  AnimationController? rippleController;
  Animation<double>? _animation;
  Animation<double>? _ripple;
  bool? _isPressing;

  @override
  void initState() {
    super.initState();
    avatarSizeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    rippleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _animation = Tween<double>(begin: 75.0, end: 100.0).animate(CurvedAnimation(
        parent: avatarSizeController!, curve: Curves.easeInExpo))
      ..addListener(() {
        setState(() {
          radius = _animation!.value;
        });
      });
    _animation!.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        setState(() {
          _viewModel.hasAlreadyBroadcasted = true;
        });
        rippleController!.repeat(period: const Duration(milliseconds: 2000));
      }
    });

    _ripple = Tween<double>(begin: 60.0, end: 800).animate(CurvedAnimation(
        parent: rippleController!, curve: Curves.linearToEaseOut))
      ..addListener(() {
        setState(() {
          rippleRadius = _ripple!.value;
        });
      });

    if (_viewModel.hasAlreadyBroadcasted!) {
      rippleController!.repeat(period: const Duration(milliseconds: 2000));
    }
  }

  void _onPress() {
    if (!_viewModel.hasAlreadyBroadcasted!) {
      setState(() {
        _isPressing = true;
        avatarSizeController!.forward();
      });
    }
  }

  void _onRelease() {
    setState(() {
      _isPressing = false;
      avatarSizeController!.reverse();
    });
  }

  @override
  void dispose() {
    avatarSizeController!.dispose();
    rippleController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (TapDownDetails details) => _onPress(),
        onTapUp: (TapUpDetails details) => _onRelease(),
        onTapCancel: () => _onRelease(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.globalContentSidePadding + 20,
                  vertical: AppPadding.p10),
              child: Text(
                  _viewModel.hasAlreadyBroadcasted!
                      ? AppStrings.alreadyBroadcastedToSitters
                      : AppStrings.broadcastToSitters,
                  textAlign: TextAlign.center,
                  style: Fonts.smallText),
            ),
            Stack(
              children: [
                CustomPaint(
                  painter: CircleRipplePainter(radius: rippleRadius),
                ),
                CircleAvatar(
                  radius: radius,
                  backgroundImage: AssetImage(widget.imagePath!),
                )
                /*
                CustomPaint(
                  painter: CircleRipplePainter(radius: radius),
                )
                */
              ],
            ),
          ],
        ));
  }
}
