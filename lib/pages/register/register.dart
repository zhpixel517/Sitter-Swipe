// account register
//! this should come AFTER the onboarding screen
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';

enum Direction { forward, backward }

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<Widget> registerPages = const [
    PhoneNumber(),
    VerifyPhone(),
    Credentials(),
    Role(),
    Birthday(),
    About(),
    ProfileImages(),
    Preview()
  ];
  PageController controller = PageController();
  bool isFirstPage = true;
  int pageIndex = 0;

  void next() {
    setState(() {
      pageIndex++;
      controller.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    });
  }

  void back() {
    setState(() {
      pageIndex--;
      controller.previousPage(
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    });
  }

  Widget _pageControlButton(Direction direction) {
    switch (direction) {
      case Direction.forward:
        return InkWell(
          onTap: () => next(),
          child: const CircleAvatar(
            backgroundColor: TanPallete.tan,
            foregroundColor: Colors.white,
            child: Icon(EvaIcons.arrowForward),
          ),
        );

      case Direction.backward:
        return InkWell(
          onTap: () => back(),
          child: const CircleAvatar(
            backgroundColor: TanPallete.tan,
            foregroundColor: Colors.white,
            child: Icon(EvaIcons.arrowBack),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: registerPages.map((i) {
                    return Builder(
                      builder: (context) {
                        return i;
                      },
                    );
                  }).toList()),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.globalContentSidePadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pageIndex == 0
                        ? const SizedBox()
                        : _pageControlButton(Direction.backward),
                    pageIndex == registerPages.length - 1
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 0.0),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Done", style: Fonts.bold),
                          )
                        : _pageControlButton(Direction.forward)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
