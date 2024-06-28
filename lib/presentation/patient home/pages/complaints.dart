import 'package:doctor_plus/core/widgets/buttons.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/core/widgets/drop_down.dart';
import 'package:doctor_plus/core/widgets/inputs.dart';
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
      appBar: const MyCustomAppBar(
        title: 'Complaints',
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField(controller: nameController, validator: (Validator.fullNameValidator), label: "Your Name", icon: Icons.person,),
                const SizedBox(
                  height: 10,
                ),
                buildEmailField(controller: emailController, validator: (Validator.emailValidator)),
                const SizedBox(
                  height: 10,
                ),
                CustomDropDownMenu(
                  value: typeDropdownValue,
                  list: const['Patient', 'Doctor'],
                  onChanged: (String? value) {  
                    setState(() {
                      typeDropdownValue = value!;
                    });
                  },
                  
                ),
                const SizedBox(
                  height: 10,
                ),
                buildMultiLineTextField(hint: "Write here your story", label: "What has happened?", controller: complaintController, validator: (Validator.complaintBodyValidator)),
                const SizedBox(
                  height: 10,
                ),
                buildMultiLineTextField(hint: "Write here your solutions", label: "How can we make things right?", controller: solutionController, validator: (Validator.complaintBodyValidator)),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: buildSubmitButton(
                    label: "Submit", 
                    onPressed: () {
                      if(formKey.currentState!.validate()) {
                        createComplaint();
                      }
                    },
                    widthFactor: 0.4
                  ),
                )
                
              ],
            ),
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
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
    } on FirebaseException catch (e) { 
        Fluttertoast.showToast(
          msg: e.code,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}