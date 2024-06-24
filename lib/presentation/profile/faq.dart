import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  void navigate({required String route}) => Navigator.pushNamed(context, route);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(
        title: "FAQ",
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            _FAQRow(
              title: "What should I expect during a doctor's appointment?",
              body:
                  """During a doctor's appointment, you can expect to discuss your 
medical history, current symptoms or concerns, and any medications 
or treatments you are taking. The doctor will likely perform a physical 
exam and may order additional tests or procedures if necessary.""",
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _FAQRow(
              title: "What should I bring to my doctor's appointment?",
              body:
                  """You should bring your insurance card, a list of current medications, 
any relevant medical records, a form of identification, and a list of questions 
or concerns you want to discuss with the doctor.""",
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _FAQRow(
              title: "What if I need to cancel or reschedule my appointment?",
              body:
                  """If you need to cancel or reschedule your appointment, contact the 
doctor's office as soon as possible. Many offices have a policy that requires 
24-hour notice for cancellations.""",
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _FAQRow(
              title: "How do I make an appointment with a doctor?",
              body:
                  """You can make an appointment by calling the doctor's office directly, 
using an online booking system if available, or through a healthcare app that 
offers appointment scheduling.""",
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _FAQRow(
              title: "How early should I arrive for my doctor's appointment?",
              body:
                  """It is recommended to arrive at least 15 minutes before your scheduled 
appointment time. This allows time for check-in procedures and any necessary 
paperwork.""",
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _FAQRow(
              title: "How long will my doctor's appointment take?",
              body:
                  """The length of a doctor's appointment can vary, but a standard appointment 
usually lasts between 15 to 30 minutes. More complex issues may require longer 
appointments.""",
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _FAQRow(
              title: "How much will my doctor's appointment cost?",
              body:
                  """The cost of a doctor's appointment can vary depending on your insurance 
coverage, the type of appointment, and any additional tests or procedures. Contact 
your insurance provider and the doctor's office for specific cost information.""",
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _FAQRow(
              title: "What should I look for in a good doctor?",
              body:
                  """When looking for a good doctor, consider their credentials, experience, 
communication style, patient reviews, and whether they make you feel comfortable 
and respected. Personal recommendations from friends and family can also be helpful.""",
            ),
          ],
        ),
      ),
    );
  }
}

Widget _FAQRow({
  required String title,
  required String body,
}) {
  return GestureDetector(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            body,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
  );
}
