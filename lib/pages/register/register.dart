// account register
//! this should come AFTER the onboarding screen
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/pages/register/pages/role_specific_data.dart';
import 'package:sitter_swipe/pages/register/provider/button_state_provider.dart';
import 'package:sitter_swipe/pages/register/provider/next_action_provider.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:provider/provider.dart';
import 'package:sitter_swipe/resources/routes.dart';
import 'package:sitter_swipe/services/responsive.dart';

enum Direction { forward, backward }

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<Widget> registerPages = const [
    PhoneNumber(),
    VerifyPhone(),
    Credentials(),
    Role(),
    RoleSpecificInput(),
    Birthday(),
    About(),
    ProfileImages(),
    Preview()
  ];

  PageController controller = PageController();
  bool isFirstPage = true;
  int pageIndex = 0;
  final RegisterButtonActions registerButtonActions = RegisterButtonActions();
  final _viewModel = GetIt.instance<RegisterViewModel>();

  void next() {
    FocusManager.instance.primaryFocus?.unfocus(); // hides keyboard
    setState(() {
      pageIndex++;
      controller.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    });
  }

  void back() {
    FocusManager.instance.primaryFocus?.unfocus(); // hides keyboard
    setState(() {
      pageIndex--;
      controller.previousPage(
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    });
  }

  Widget _pageControlButton(
      Direction direction, int index, BuildContext context) {
    switch (direction) {
      case Direction.forward:
        return InkWell(
          onTap: () async {
            final NextActionType nextActionType =
                registerButtonActions.returnActionTypeFromPageIndex(index);
            await registerButtonActions.execute(nextActionType);
            next();
          },
          child: const CircleAvatar(
            backgroundColor: TanPallete.tan,
            foregroundColor: Colors.white,
            child: Icon(EvaIcons.arrowForward),
          ),
        );

      case Direction.backward:
        return InkWell(
          onTap: () async => back(),
          child: const CircleAvatar(
            backgroundColor: TanPallete.tan,
            foregroundColor: Colors.white,
            child: Icon(EvaIcons.arrowBack),
          ),
        );
    }
  }

  Widget _blurredButton(Direction direction) {
    switch (direction) {
      case Direction.forward:
        return InkWell(
          onTap: () {},
          child: const CircleAvatar(
            backgroundColor: TanPallete.lightGrey,
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
    SizeConfig.init(context);
    return ChangeNotifierProvider(
        create: (context) => BlurProvider(),
        builder: (context, snapshot) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
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
                  Consumer<BlurProvider>(
                      builder: (context, blurProvider, snapshot) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.globalContentSidePadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            pageIndex == 0
                                ? const SizedBox()
                                : blurProvider.shouldBlur
                                    ? _blurredButton(Direction.backward)
                                    : _pageControlButton(
                                        Direction.backward, pageIndex, context),
                            pageIndex == registerPages.length - 1
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0.0),
                                    onPressed: () {
                                      _viewModel.register();
                                      Navigator.pushNamed(
                                          context, Routes.baseScreen);
                                    },
                                    child: Text("Done", style: Fonts.bold),
                                  )
                                : blurProvider.shouldBlur
                                    ? _blurredButton(Direction.forward)
                                    : _pageControlButton(
                                        Direction.forward, pageIndex, context)
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          );
        });
  }
}
