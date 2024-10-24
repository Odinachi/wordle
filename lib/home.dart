import 'package:flutter/material.dart';
import 'package:wordle/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final keyboardKeys = [
    ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
    ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
    ["ENTER", "Z", "X", "C", "V", "B", "N", "M", "DEL"]
  ];

  String inputtedString = '';
  final holdingText = <String>[];
  int typingIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Expanded(
                  flex: 3,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(),
                    itemBuilder: (_, columnIndex) {
                      return Row(
                        children: List<Widget>.generate(5, (rowIndex) {
                          String text = '';
                          if (columnIndex == typingIndex) {
                            if (inputtedString.isNotEmpty &&
                                inputtedString.length > rowIndex) {
                              text = inputtedString[rowIndex];
                            }
                          } else if (columnIndex < typingIndex) {
                            final rowTextList =
                                holdingText[columnIndex].split("").toList();
                            text = rowTextList[rowIndex];
                          }
                          return Expanded(
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.whiteColor
                                          .withOpacity(.5))),
                              child: Center(
                                child: Text(
                                  text,
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                  )),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (_, i) {
                    final rowKeys = keyboardKeys[i];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.from(
                        rowKeys.map(
                          (e) => GestureDetector(
                            onTap: () {
                              if (e.length > 1) {
                                if (e == "ENTER" &&
                                    inputtedString.length == 5) {
                                  ///check that word is valid
                                  holdingText.add(inputtedString);
                                  typingIndex += 1;
                                  inputtedString = "";
                                } else if (e == "DEL" &&
                                    inputtedString.isNotEmpty) {
                                  inputtedString = inputtedString.substring(
                                      0, inputtedString.length - 1);
                                }
                              } else {
                                if (inputtedString.length < 5) {
                                  inputtedString = "$inputtedString$e";
                                }
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 40,
                              width: e.length > 1 ? 40 : 30,
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 2.6),
                              decoration: BoxDecoration(
                                  color: AppColors.failedColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors.whiteColor
                                          .withOpacity(.5))),
                              child: Center(
                                child: e == "ENTER"
                                    ? const Icon(
                                        Icons.start,
                                        size: 20,
                                        color: AppColors.whiteColor,
                                      )
                                    : e == "DEL"
                                        ? const Icon(
                                            Icons.backspace_outlined,
                                            size: 20,
                                            color: AppColors.whiteColor,
                                          )
                                        : Text(
                                            e,
                                            style: const TextStyle(
                                              color: AppColors.whiteColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: keyboardKeys.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
