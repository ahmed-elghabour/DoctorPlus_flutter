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
              body: "...",
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _FAQRow(
              title: "What if I need to cancel or reschedule my appointment?",
              body: "...",
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _FAQRow(
              title: "How do I make an appointment with a doctor?",
              body: "...",
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _FAQRow(
              title: "How early should I arrive for my doctor's appointment?",
              body: "...",
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _FAQRow(
              title: "How long will my doctor's appointment take?",
              body: "...",
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _FAQRow(
              title: "How much will my doctor's appointment cost?",
              body: "...",
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _FAQRow(
              title: "What should I look for in a good doctor?",
              body: "...",
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
            // const Icon(
            //   size: 40,
            //   Icons.keyboard_arrow_right,
            // )
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
