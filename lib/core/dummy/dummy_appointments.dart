import 'package:doctor_plus/data/model/appointment.dart';

final List<Appointment> appointments = [
  Appointment(
    doctorImage:
        'https://www.shutterstock.com/image-vector/young-smiling-doctor-stethoscope-medical-600nw-2116246328.jpg',
    doctorName: 'Dr. John Doe',
    patientImage:
        'https://static.vecteezy.com/system/resources/previews/019/637/994/original/man-sneezes-and-uses-paper-napkin-how-to-sneeze-right-virus-prevention-spread-flat-illustration-seasonal-allergies-healthcare-concept-vector.jpg',
    patientName: 'Alice Johnson',
    appointmentType: 'General Checkup',
    appointmentDate: '12 June 2024',
    appointmentTime: '10:00 AM',
  ),
  Appointment(
    doctorImage:
        'https://www.shutterstock.com/image-vector/young-smiling-doctor-stethoscope-medical-600nw-2116246328.jpg',
    doctorName: 'Dr. Jane Smith',
    patientImage:
        'https://static.vecteezy.com/system/resources/previews/019/637/994/original/man-sneezes-and-uses-paper-napkin-how-to-sneeze-right-virus-prevention-spread-flat-illustration-seasonal-allergies-healthcare-concept-vector.jpg',
    patientName: 'Bob Brown',
    appointmentType: 'Dental Cleaning',
    appointmentDate: '13 June 2024',
    appointmentTime: '11:00 AM',
  ),
  // Add more Appointment objects here
];
