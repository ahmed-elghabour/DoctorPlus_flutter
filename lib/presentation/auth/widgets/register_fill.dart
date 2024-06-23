import 'package:flutter/material.dart';
import 'package:doctor_plus/presentation/auth/signup/register_general.dart';
import 'package:doctor_plus/presentation/auth/signup/register_additional.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                RegisterGeneral(
                  onNext: () => _goToPage(1),
                ),
                RegisterAdditional(
                  onPrevious: () => _goToPage(0),
                  onSubmit: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
