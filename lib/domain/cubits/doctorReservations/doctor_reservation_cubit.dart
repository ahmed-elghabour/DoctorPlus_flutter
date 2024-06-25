import 'package:doctor_plus/data/model/doctor_reservation.dart';
import 'package:doctor_plus/presentation/doctor%20home/utils/doctor_reservations_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorReservationCubit extends Cubit<List<DoctorReservation>> {
  DoctorReservationCubit() : super([]);

  void fetchReservations(String doctorId) {
    DoctorService.getReservations(doctorId)?.listen((data) {
      emit(data);
    });
  }
}
