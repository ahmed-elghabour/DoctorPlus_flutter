import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/repositories/appointments_repository.dart';
import 'package:doctor_plus/data/data%20sources/appointments_remote_data_source.dart';
import 'package:doctor_plus/domain/cubits/doctor%20reservations/doctor_reservation_state.dart';

class DoctorReservationCubit extends Cubit<DoctorReservationState> {
  DoctorReservationCubit() : super(DoctorReservationInitial());
  List<AppointmentModel> appointments = [];
  void fetchReservations(String doctorId) async {
    emit(DoctorReservationLoading());
    try {
      appointments = await AppointmentsRepository(
              remoteDataSource: AppointmentsRemoteDataSource())
          .getDoctorAppointments(doctorId);
      List<String> patientsId = appointments.map((e) => e.patientId).toList();
      appointments.sort((a, b) {
        DateTime dateA = DateTime.parse(a.date);
        DateTime dateB = DateTime.parse(b.date);
        return dateA.compareTo(dateB);
      });
      List<Patient> patients = await AppointmentsRepository(
              remoteDataSource: AppointmentsRemoteDataSource())
          .getAppointmentedPatients(patientsId);

      int current = 0;
      int old = 0;
      int newP = 0;
      for (var appointment in appointments) {
        if (compareDates(appointment.date) == "equal") {
          current++;
        } else if (compareDates(appointment.date) == "less") {
          old++;
        } else if (compareDates(appointment.date) == "greater") {
          newP++;
        }
      }

      emit(DoctorReservationLoaded(appointments, current, old, newP, patients));
    } catch (e) {
      emit(DoctorReservationError(e.toString()));
    }
  }
}

String compareDates(String dateString) {
  DateTime givenDate = DateTime.parse(dateString);

  DateTime today = DateTime.now();
  DateTime todayWithoutTime = DateTime(today.year, today.month, today.day);
  print("loaded - Check Date");

  if (givenDate.isAfter(todayWithoutTime)) {
    print("loaded - Date is: New");
    return "greater";
  } else if (givenDate.isBefore(todayWithoutTime)) {
    print("loaded - Date is: Old");
    return "less";
  } else {
    print("loaded - Date is: Current");
    return "equal";
  }
}
