import 'package:cloud_firestore/cloud_firestore.dart';

enum AppointmentStatus {
  upcoming,
  completed,
  cancelled,
  rescheduled,
}

class AppointmentModel {
  final String id;

  final String doctorId;
  final String doctorImage;
  final String doctorName;

  final String patientId;
  final String patientImage;
  final String patientName;

  final String appointmentType;
  final String paymentMethod;

  final Timestamp appointmentDateTime;

  final AppointmentStatus status;

  AppointmentModel({
    required this.id,
    required this.doctorImage,
    required this.doctorName,
    required this.patientImage,
    required this.patientName,
    required this.appointmentType,
    required this.paymentMethod,
    required this.doctorId,
    required this.patientId,
    required this.appointmentDateTime,
    required this.status,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          doctorId: json['doctorId'],
          doctorImage: json['doctorImage'],
          doctorName: json['doctorName'],
          patientId: json['patientId'],
          patientImage: json['patientImage'],
          patientName: json['patientName'],
          appointmentType: json['appointmentType'],
          paymentMethod: json['paymentMethod'],
          appointmentDateTime: json['appointmentDateTime'],
          status: json['status'] == "upcoming"
              ? AppointmentStatus.upcoming
              : json['status'] == "completed"
                  ? AppointmentStatus.completed
                  : json['status'] == "cancelled"
                      ? AppointmentStatus.cancelled
                      : AppointmentStatus.rescheduled,
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'doctorId': doctorId,
        'doctorImage': doctorImage,
        'doctorName': doctorName,
        'patientId': patientId,
        'patientImage': patientImage,
        'patientName': patientName,
        'appointmentType': appointmentType,
        'paymentMethod': paymentMethod,
        'appointmentDateTime': appointmentDateTime,
        'status': status == AppointmentStatus.upcoming
            ? "pending"
            : status == AppointmentStatus.completed
                ? "done"
                : status == AppointmentStatus.cancelled
                    ? "cancelled"
                    : "rescheduled",
      };
}
