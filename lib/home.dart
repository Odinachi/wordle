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
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                    itemBuilder: (_, i) {
                      return Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.whiteColor.withOpacity(.5))),
                        child: const Center(
                          child: Text(
                            "T",
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 30,
                  )),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (_, i) {
                    final rowKeys = keyboardKeys[i];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.from(
                        rowKeys.map(
                          (e) => Container(
                            height: 40,
                            width: e.length > 1 ? 40 : 30,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2.6),
                            decoration: BoxDecoration(
                                color: AppColors.failedColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color:
                                        AppColors.whiteColor.withOpacity(.5))),
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
