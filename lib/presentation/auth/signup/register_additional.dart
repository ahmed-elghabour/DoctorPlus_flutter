import 'package:doctor_plus/presentation/auth/signup/doctor_info.dart';
import 'package:doctor_plus/presentation/auth/signup/patient_info.dart';
import 'package:doctor_plus/core/widgets/buttons.dart';
import 'package:flutter/material.dart';

class RegisterAdditional extends StatefulWidget {
  final void Function()? onPrevious;
  final void Function()? onSubmit;
  const RegisterAdditional({super.key, this.onPrevious, this.onSubmit});

  @override
  State<RegisterAdditional> createState() => _RegisterAdditionalState();
}

class _RegisterAdditionalState extends State<RegisterAdditional> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(35)),
          ),
          automaticallyImplyLeading: false,
          title: const TabBar(
            tabs: [
              Tab(text: 'Patient'),
              Tab(text: 'Doctor'),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: PatientAdditionalInfo(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: DoctorAdditionalInfo(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: buildSubmitButton(
                        widthFactor: .7,
                        label: "Previous",
                        onPressed: widget.onPrevious,
                      ),
                    ),
                    const SizedBox(width: 10), // Spacer between buttons
                    Expanded(
                      child: buildSubmitButton(
                        widthFactor: .7,
                        label: "Submit",
                        onPressed: widget.onSubmit,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
