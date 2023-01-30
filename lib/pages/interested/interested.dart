// families or other babysitters interested
// part of baseScreen
import 'package:flutter/material.dart';
import 'package:sitter_swipe/app/constants.dart';
import 'package:sitter_swipe/pages/interested/widgets/interested_person.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';

class InterestedPage extends StatefulWidget {
  const InterestedPage({Key? key}) : super(key: key);

  @override
  InterestedPageState createState() => InterestedPageState();
}

class InterestedPageState extends State<InterestedPage> {
  static List<InterestedPerson> interestedPeople = [
    InterestedPerson("Bianca", "@joe", girl1, "16"),
    InterestedPerson("Michael", "@joeeeeeeeeeeeeeeeeeee", boy1, "15"),
    InterestedPerson("Emily", "@adf", girl2, "14"),
    InterestedPerson("Ammon", "@sdfg", boy2, "18"),
    InterestedPerson("Avery", "@asd", girl3, "15"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(PageTitles.interested),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p10),
                child: Container(
                  color: TanPallete.tan,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      AppStrings.interestedHeading,
                      style: Fonts.interestedTitle
                          .copyWith(fontSize: 15, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.globalContentSidePadding),
                  child: interestedPeople.isNotEmpty
                      ? GridView.builder(
                          itemCount: interestedPeople.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 5),
                          itemBuilder: (context, index) {
                            return interestedPeople[index];
                          })
                      : const Center(
                          child: Icon(Icons.question_answer),
                        )),
            ),
          ],
        ));
  }
}
