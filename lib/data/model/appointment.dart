import 'package:cloud_firestore/cloud_firestore.dart';

enum AppointmentStatus {
  pending,
  done,
  cancelled,
  rescheduled,
}

class AppointmentModel {
  final String doctorId;
  final String doctorImage;
  final String doctorName;

  final String patientId;
  final String patientImage;
  final String patientName;

  final String appointmentType;

  final Timestamp appointmentDateTime;

  final AppointmentStatus status;

  AppointmentModel({
    required this.doctorImage,
    required this.doctorName,
    required this.patientImage,
    required this.patientName,
    required this.appointmentType,
    required this.doctorId,
    required this.patientId,
    required this.appointmentDateTime,
    required this.status,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json)
      : this(
          doctorId: json['doctorId'],
          doctorImage: json['doctorImage'],
          doctorName: json['doctorName'],
          patientId: json['patientId'],
          patientImage: json['patientImage'],
          patientName: json['patientName'],
          appointmentType: json['appointmentType'],
          appointmentDateTime: json['appointmentDateTime'],
          status: json['status'] == "pending"
              ? AppointmentStatus.pending
              : json['status'] == "done"
                  ? AppointmentStatus.done
                  : json['status'] == "cancelled"
                      ? AppointmentStatus.cancelled
                      : AppointmentStatus.rescheduled,
        );

  Map<String, dynamic> toJson() => {
        'doctorId': doctorId,
        'doctorImage': doctorImage,
        'doctorName': doctorName,
        'patientId': patientId,
        'patientImage': patientImage,
        'patientName': patientName,
        'appointmentType': appointmentType,
        'appointmentDateTime': appointmentDateTime,
        'status': status == AppointmentStatus.pending
            ? "pending"
            : status == AppointmentStatus.done
                ? "done"
                : status == AppointmentStatus.cancelled
                    ? "cancelled"
                    : "rescheduled",
      };
}
