enum AppointmentStatus {
  pending,
  done,
  cancelled,
  rescheduled,
}

class Appointment {
  final String doctorImage;
  final String doctorName;
  final String patientImage;
  final String patientName;
  final String appointmentType;
  final String appointmentDate;
  final String appointmentTime;
  //
  final AppointmentStatus status;

  Appointment({
    required this.doctorImage,
    required this.doctorName,
    required this.patientImage,
    required this.patientName,
    required this.appointmentType,
    required this.appointmentDate,
    required this.appointmentTime,
    //
    required this.status,
  });
}
