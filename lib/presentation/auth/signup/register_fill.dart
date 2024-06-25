import 'package:doctor_plus/core/widgets/toast.dart';
import 'package:doctor_plus/presentation/auth/signup/doctor_info.dart';
import 'package:doctor_plus/presentation/auth/signup/patient_info.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/presentation/auth/signup/register_general.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  RegisterGeneral(
                    onNext: (type) {
                      FailureToast.showToast(msg: type);
                      _goToPage(type == "doctor" ? 2 : 1);
                    },
                  ),
                  PatientAdditionalInfo(
                    onPrevious: () => _goToPage(0),
                    onSubmit: () {},
                  ),
                  DoctorAdditionalInfo(
                    onPrevious: () => _goToPage(0),
                    onSubmit: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
