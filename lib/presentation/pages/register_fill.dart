import 'package:flutter/material.dart';
import 'package:doctor_plus/presentation/widgets/buttons.dart';
import 'package:doctor_plus/presentation/pages/screens/register_general.dart';
import 'package:doctor_plus/presentation/pages/screens/register_additional.dart';

class RegisterFillData extends StatefulWidget {
  const RegisterFillData({super.key});

  @override
  State<RegisterFillData> createState() => _RegisterFillDataState();
}

class _RegisterFillDataState extends State<RegisterFillData> {
  int index = 0;
  final PageController _pageController = PageController();
  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Spacer(flex: 1),
                Expanded(
                  flex: index == 0 ? 2 : 100,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (newIndex) =>
                        setState(() => index = newIndex),
                    children: const [
                      RegisterGeneral(),
                      RegisterAdditional(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    index > 0
                        ? Expanded(
                            child: buildSubmitButton(
                              widthFactor: .7,
                              label: "Previous",
                              onPressed: () {
                                if (index < 2) {
                                  setState(() => _goToPage(--index));
                                }
                              },
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.zero, // No padding
                            margin: EdgeInsets.zero, // No margin
                            // You can add child widgets or other properties here
                          ),
                    Expanded(
                      child: buildSubmitButton(
                        widthFactor: index < 1 ? .4 : .7,
                        label: "Next",
                        onPressed: () {
                          if (index < 2) {
                            setState(() {
                              index++;
                              _goToPage(index);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
