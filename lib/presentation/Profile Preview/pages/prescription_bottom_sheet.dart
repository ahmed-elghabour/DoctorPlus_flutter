import 'package:doctor_plus/core/widgets/app_text_button.dart';
import 'package:doctor_plus/core/widgets/inputs.dart';
import 'package:doctor_plus/core/widgets/toast.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/data/model/prescription.dart';
import 'package:doctor_plus/domain/cubits/prescriptions/prescription_cubit.dart';
import 'package:doctor_plus/domain/cubits/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PrescriptionBottomSheet extends StatefulWidget {
  final Patient patient;
  const PrescriptionBottomSheet({super.key, required this.patient});

  @override
  State<PrescriptionBottomSheet> createState() =>
      _PrescriptionBottomSheetState();
}

class _PrescriptionBottomSheetState extends State<PrescriptionBottomSheet> {
  late TextEditingController controller;
  late FocusNode focusNode;
  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            buildMultiLineTextField(
              maxLines: 10,
              focusNode: focusNode,
              controller: controller,
              label: "Prescription Body",
              hint: "Enter your prescription",
              validator: (validator) {
                return null;
              },
            ),
            const SizedBox(height: 30),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppTextButton(
                      buttonText: "Cancel",
                      buttonHeight: 50,
                      backgroundColor: Colors.red,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      onPressed: _cancelPrescription),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: AppTextButton(
                      buttonText: "Submit",
                      buttonHeight: 50,
                      backgroundColor: Colors.blue,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      onPressed: _submitPrescription),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _cancelPrescription() {
    Navigator.of(context).pop();
  }

  void _submitPrescription() {
    try {
      Doctor doctor = context.read<UserCubit>().getUser();
      context.read<PrescriptionCubit>().addNewPrescription(
            presc: Prescription(
              date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
              doctorId: doctor.id!,
              doctorName: '${doctor.fName} ${doctor.lName}',
              patientId: widget.patient.id!,
              body: controller.text,
            ),
          );
      SuccessToast.showToast(msg: "Prescription added successfully");
      Navigator.of(context).pop();
    } catch (e) {
      FailureToast.showToast(msg: e.toString());
    }
  }
}
