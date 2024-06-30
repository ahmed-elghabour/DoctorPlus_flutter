// enum AppointmentStatus {
//   upcoming,
//   completed,
//   cancelled,
//   rescheduled,
// }

class AppointmentModel {
  String? id;
  late bool isErgunt;
  late List<String> patients;
  late String doctorId, date, type, payment, status;

  // final AppointmentStatus status;

  AppointmentModel({
    this.id = '',
    required this.type,
    required this.date,
    this.isErgunt = false,
    required this.payment,
    required this.doctorId,
    required this.patients,
    this.status = 'upcoming',
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      type: json['type'],
      date: json['date'],
      status: json['status'],
      payment: json['payment'],
      isErgunt: json['isErgunt'],
      doctorId: json['doctorId'],
      patients: List<String>.from(json['patients']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'type': type,
        'status': status,
        'payment': payment,
        'isErgunt': isErgunt,
        'patients': patients,
        'doctorId': doctorId,
      };
}
