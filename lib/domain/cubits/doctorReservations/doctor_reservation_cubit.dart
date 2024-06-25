import 'package:doctor_plus/presentation/Doctor%20Home/utils/doctor_reservations_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorReservationCubit extends Cubit<List<dynamic>> {
  DoctorReservationCubit() : super([]);

  void fetchReservations(String doctorId, String datePicked) {
    DoctorService.getReservations(doctorId, datePicked)?.listen((data) {
      emit(data);
    });
  }
}
