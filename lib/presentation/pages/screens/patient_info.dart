import 'package:doctor_plus/data/demo.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/presentation/widgets/additional_info.dart';

class PatientAdditionalInfo extends StatefulWidget {
  const PatientAdditionalInfo({super.key});

  @override
  State<PatientAdditionalInfo> createState() => _PatientAdditionalInfoState();
}

class _PatientAdditionalInfoState extends State<PatientAdditionalInfo> {
  String diet = 'Select Choice';
  String smoke = 'Select Choice';
  String sleep = 'Select Choice';
  String stress = 'Select Choice';
  String disease = 'Select Choice';
  String exercise = 'Select Choice';
  String hydration = 'Select Choice';
  String allergies = 'Select Choice';
  String medication = 'Select Choice';
  String mentalHealth = 'Select Choice';
  List<String> diseaseList = [];
  List<String> medicationList = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          additionalInfo(
              value: smoke,
              title: "Smoking",
              list: patientInfo['smoke']!['options'] as List<String>,
              onChanged: (newVal) => setState(() => smoke = newVal!)),
          additionalInfo(
              value: allergies,
              title: "Allergy",
              list: patientInfo['allergies']!['options'] as List<String>,
              onChanged: (newVal) => setState(() => allergies = newVal!)),
          customAdditionaInfo(
              value: disease,
              title: "Disease",
              selectedlist: diseaseList,
              list: patientInfo['disease']!['options'] as List<String>,
              onRemove: (val) => setState(() => diseaseList.remove(val)),
              onChanged: (newVal) => setState(
                    () {
                      disease = newVal!;
                      diseaseList.add(disease);
                    },
                  )),

          customAdditionaInfo(
              value: medication,
              title: "Medication",
              selectedlist: medicationList,
              list: patientInfo['medication']!['options'] as List<String>,
              onRemove: (val) => setState(() => medicationList.remove(val)),
              onChanged: (newVal) => setState(
                    () {
                      medication = newVal!;
                      medicationList.add(medication);
                    },
                  )),
          //==========================
          additionalInfo(
              value: exercise,
              title: "Exercise",
              list: patientInfo['exercise']!['options'] as List<String>,
              onChanged: (newVal) => setState(() => exercise = newVal!)),
          additionalInfo(
              value: diet,
              title: "Diet",
              list: patientInfo['diet']!['options'] as List<String>,
              onChanged: (newVal) => setState(() => diet = newVal!)),
          additionalInfo(
              value: sleep,
              title: "Sleep",
              list: patientInfo['sleep']!['options'] as List<String>,
              onChanged: (newVal) => setState(() => sleep = newVal!)),
          additionalInfo(
              value: hydration,
              title: "Hydration",
              list: patientInfo['hydration']!['options'] as List<String>,
              onChanged: (newVal) => setState(() => hydration = newVal!)),
          additionalInfo(
              value: stress,
              title: "Stress",
              list: patientInfo['stress']!['options'] as List<String>,
              onChanged: (newVal) => setState(() => stress = newVal!)),

          additionalInfo(
              value: mentalHealth,
              title: "mentalHealth",
              list: patientInfo['mentalHealth']!['options'] as List<String>,
              onChanged: (newVal) => setState(() => mentalHealth = newVal!)),
        ],
      ),
    );
  }
}