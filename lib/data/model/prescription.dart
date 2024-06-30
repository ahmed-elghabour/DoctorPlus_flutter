class Prescription {
  String? id;
  late String patientId, doctorId, doctorName, body, date;

  Prescription({
    this.id,
    required this.date,
    required this.doctorId,
    required this.doctorName,
    required this.patientId,
    required this.body,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['id'],
      date: json['date'],
      doctorId: json['doctorId'],
      patientId: json['patientId'],
      doctorName: json['doctorName'],
      body: json['body'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'doctorId': doctorId,
        'patientId': patientId,
        'doctorName': doctorName,
        'body': body,
      };
}
