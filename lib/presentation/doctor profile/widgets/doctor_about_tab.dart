import 'package:doctor_plus/core/theming/styles.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:flutter/material.dart';

class DoctorAboutTab extends StatelessWidget {
  final Doctor doctor;
  const DoctorAboutTab({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text("About Me", style: TextStyles.font18DarkBlueSemiBold),
            ),
            Text(
              doctor.description,
              style: TextStyles.font14GrayRegular.copyWith(
                height: 1.5,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("Working Days",
                      style: TextStyles.font18DarkBlueSemiBold),
                ),
                Text(
                  "${doctor.workingDays.startTimes} ${checkMorning(doctor.workingDays.startTimes, doctor.workingDays.endTimes)}  -  ${doctor.workingDays.endTimes} PM",
                  style: TextStyles.font14GrayRegular.copyWith(
                    height: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Wrap(
              alignment: WrapAlignment.center,
              children: doctor.workingDays.days
                  .map(
                    (day) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        day,
                        style: TextStyles.font14GrayRegular.copyWith(
                          height: 1.2,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text("Licences", style: TextStyles.font18DarkBlueSemiBold),
            ),
            _licencesWidget(title: "Specialty: ${doctor.specialty}"),
            _licencesWidget(title: "University: ${doctor.university}"),
            Row(
              children: [
                _licencesWidget(title: "Degrees:"),
                Wrap(
                  children: doctor.degrees
                      .map(
                        (degree) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: _licencesWidget(title: degree)),
                      )
                      .toList(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _licencesWidget({required String title}) {
  return Text(
    title,
    style: TextStyles.font14GrayRegular.copyWith(
      height: 1.5,
    ),
  );
}

checkMorning(String a, String b) {
  int start = int.parse(a);
  int end = int.parse(b);

  return start > end ? "AM" : "PM";
}
