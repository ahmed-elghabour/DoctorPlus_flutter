import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class PatientList extends StatefulWidget {
  const PatientList({super.key});

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  String datePicked = DateFormat('yyyy-MM-dd').format(DateTime.now());
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Patient List",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              ),
              TextButton(
                child: Row(
                  children: [
                    Text(
                      datePicked,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    )
                  ],
                ),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      helpText: "Select date to pick",
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year, DateTime.now().month - 3),
                      lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1),
                  );
                  if (picked != null) {
                    setState(() {
                      datePicked = DateFormat('yyyy-MM-dd').format(picked);
                    });
                  }
                },
              )
          ],
        )
      ],
    );
  }
}