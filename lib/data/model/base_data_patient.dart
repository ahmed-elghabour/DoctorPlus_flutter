class PatientBaseData {
  late List<String> degrees, pdfFiles;
  late String specialty, university, degree, degreeDate;

  PatientBaseData({
    required String diet,
    required String smoke,
    required String sleep,
    required String stress,
    required String exercise,
    required String hydration,
    required String allergies,
    required String mentalHealth,
    required List<String> diseases,
    required List<String> medications,
  });
}
