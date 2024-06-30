import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/data/model/prescription.dart';
import 'package:doctor_plus/domain/cubits/prescriptions/prescription_state.dart';

class PrescriptionCubit extends Cubit<PrescriptionState> {
  PrescriptionCubit() : super(PrescriptionsInitial());

  List<Prescription> prescriptions = [];
  getPrescriptions({required String patientId}) async {
    emit(PrescriptionsLoading());
    try {
      // prescriptions = await PrescriptionRepository(
      //         remoteDataSource: PrescriptionRemoteDataSource())
      //     .getPrescriptions(patientId);
      // print("prescriptions: ${prescriptions.length}");
      emit(PrescriptionsLoaded(prescriptions));
    } catch (e) {
      print("prescription: $e");
      emit(PrescriptionsError(e.toString()));
    }
  }

  addNewPrescription({required Prescription presc}) async {
    emit(PrescriptionsLoading());
    try {
      await CustomFirebase().addNewNestedCollection(
        docID: presc.patientId,
        maincollection: "patients",
        nestedcollection: "prescriptions",
        data: presc.toJson(),
      );
    } catch (e) {
      emit(PrescriptionsError(e.toString()));
    }
  }
}
