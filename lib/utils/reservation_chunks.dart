import 'package:doctor_plus/data/model/doctor_reservation.dart';

List<List<DoctorReservation>> chunkedReservList(
    List<DoctorReservation> list, int chunkSize) {
  List<List<DoctorReservation>> chunks = [];
  for (var i = 0; i < list.length; i += chunkSize) {
    chunks.add(list.sublist(
        i, i + chunkSize > list.length ? list.length : i + chunkSize));
  }
  return chunks;
}