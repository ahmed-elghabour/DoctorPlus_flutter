import 'package:doctor_plus/presentation/widgets/complaint_department.dart';
import 'package:flutter/material.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({super.key});

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  final formKey = GlobalKey<FormState>();
  String typeDropdownValue = 'Patient';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaints"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Complaint about", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: typeDropdownValue,
                isExpanded: true,
                items: const[
                  DropdownMenuItem(value: "Patient",child: Text("Patient"),),
                  DropdownMenuItem(value: "Doctor",child: Text("Doctor"),),
                ], 
                underline: Container(
                  height: 2,
                  color: Colors.indigo,
                ),
                onChanged: (String? value) {  
                  setState(() {
                    typeDropdownValue = value!;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              
              if(typeDropdownValue == "Doctor")
                const ComplaintDepartment(),
              
            ],
          ),
        ),
      ),
    );
  }
}