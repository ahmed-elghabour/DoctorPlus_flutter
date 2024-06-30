// enum AppointmentStatus {
//   upcoming,
//   completed,
//   cancelled,
//   rescheduled,
// }

class AppointmentModel {
  String? id;
  late bool isUrgant;
  late List<String>? patients;
  late String doctorId, patientId, date, type, payment, status;

  // final AppointmentStatus status;

  AppointmentModel({
    this.id = '',
    required this.type,
    required this.date,
    required this.isUrgant,
    required this.payment,
    required this.doctorId,
    required this.patientId,
    this.status = 'upcoming',
  });
  AppointmentModel.fetch({
    this.id = '',
    required this.type,
    required this.date,
    this.isUrgant = false,
    required this.payment,
    required this.doctorId,
    this.status = 'upcoming',
  });

  AppointmentModel.patient({
    required this.id,
    required this.date,
    required this.type,
    required this.status,
    required this.payment,
    required this.doctorId,
    required this.isUrgant,
  });

  factory AppointmentModel.fromJsonPatient(Map<String, dynamic> json) {
    return AppointmentModel.fetch(
      id: json['id'],
      type: json['type'],
      date: json['date'],
      status: json['status'],
      payment: json['payment'],
      isUrgant: json['isUrgant'],
      doctorId: json['doctorId'],
      // patients: List<String>.from(json['patients']),
    );
  }
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel.fetch(
      id: json['id'],
      type: json['type'],
      date: json['date'],
      status: json['status'],
      payment: json['payment'],
      isUrgant: json['isUrgant'],
      doctorId: json['doctorId'],
      // patients: List<String>.from(json['patients']),
    );
  }

  Map<String, dynamic> toDoctorJson() => {
        'id': id,
        'date': date,
        'type': type,
        'status': status,
        'payment': payment,
        'isUrgant': isUrgant,
        'patientId': patientId,
        // 'doctorId': doctorId,
      };

  Map<String, dynamic> toPatientJson() => {
        'id': id,
        'date': date,
        'type': type,
        'status': status,
        'payment': payment,
        'isUrgant': isUrgant,
        'doctorId': doctorId,
      };
}
