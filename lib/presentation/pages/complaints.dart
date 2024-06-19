import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({super.key});

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  final formKey = GlobalKey<FormState>();
  String typeDropdownValue = 'Patient';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController complaintController = TextEditingController();
  TextEditingController solutionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    complaintController.dispose();
    solutionController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaints"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text("Your Name")),
                controller: nameController,
                validator:(Validator.fullNameValidator),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("Your Email")),
                controller: emailController,
                validator: (Validator.emailValidator)
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                value: typeDropdownValue,
                isExpanded: true,
                items: const[
                  DropdownMenuItem(value: "Patient",child: Text("Patient"),),
                  DropdownMenuItem(value: "Doctor",child: Text("Doctor"),),
                ], 
                decoration: const InputDecoration(label: Text("Complaint about")),
                onChanged: (String? value) {  
                  setState(() {
                    typeDropdownValue = value!;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("What has happened?")),
                controller: complaintController,
                validator: (Validator.complaintBodyValidator),
                maxLines: null,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("How can we make things right?")),
                controller: solutionController,
                maxLines: null,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()) {
                      createComplaint();
                    }
                  },
                  child: const Text("Submit"),
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }

  void createComplaint() async {
    try {
      await CustomFirebase.instance.addNewCollection(collection: 'Complaints', data: {
        "personName": nameController.text,
        "personEmail": emailController.text,
        "complaintAbout": typeDropdownValue,
        "body": complaintController.text,
        "solution": solutionController.text,
      });
      Fluttertoast.showToast(
        msg: "Submitted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
    } on FirebaseException catch (e) { 
        Fluttertoast.showToast(
          msg: e.code,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
