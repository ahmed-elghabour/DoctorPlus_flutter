class DummyDoctorModel {
  final String id;
  final String doctorId;
  final String doctorName;
  final String specification;
  final String description;

  DummyDoctorModel({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.specification,
    required this.description,
  });

  DummyDoctorModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          doctorId: json['doctorId'],
          doctorName: json['doctorName'],
          specification: json['specification'],
          description: json['description'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'doctorId': doctorId,
        'doctorName': doctorName,
        'specification': specification,
        'description': description,
      };
}
