import 'package:flutter/material.dart';

class DoctorManagementPage extends StatefulWidget {
  static const routeName = '/doctorManagementPage';

  const DoctorManagementPage({Key? key}) : super(key: key);

  @override
  _DoctorManagementPageState createState() => _DoctorManagementPageState();
}

class _DoctorManagementPageState extends State<DoctorManagementPage> {
  List<Map<String, dynamic>> dummyDoctors = [
    {
      'id': '1',
      'fName': 'Amr',
      'lName': 'Yehia',
      'specialty': 'Ophthalmology',
      'birthDate': '2024-06-28',
      'days': ['Tuesday', 'Wednesday', 'Thursday', 'Sunday'],
      'degrees': ['Master', 'Fellowship'],
      'description': 'Dr. Amr is an experienced ophthalmologist.',
      'email': 'dr.amr@gmail.com',
      'endingWorkHour': '6',
      'fees': 500,
      'gender': 'Male',
      'graduationDate': '2024-06-28',
      'location': '37.4219983,-122.084',
      'patients': 25,
      'phone': '0123456789',
      'startingWorkHour': '1',
      'type': 'doctor',
      'university': 'Alexandria University',
    },
    {
      'id': '2',
      'fName': 'Sara',
      'lName': 'Smith',
      'specialty': 'Cardiology',
      'birthDate': '1985-05-14',
      'days': ['Monday', 'Wednesday', 'Friday'],
      'degrees': ['PhD', 'MD'],
      'description': 'Dr. Sara is a renowned cardiologist.',
      'email': 'dr.sara@gmail.com',
      'endingWorkHour': '5',
      'fees': 700,
      'gender': 'Female',
      'graduationDate': '2010-06-20',
      'location': '40.712776,-74.005974',
      'patients': 40,
      'phone': '0987654321',
      'startingWorkHour': '9',
      'type': 'doctor',
      'university': 'Harvard University',
    },
    {
      'id': '3',
      'fName': 'John',
      'lName': 'Doe',
      'specialty': 'Dermatology',
      'birthDate': '1978-12-01',
      'days': ['Tuesday', 'Thursday'],
      'degrees': ['MD'],
      'description': 'Dr. John is an expert in skin diseases.',
      'email': 'dr.john@gmail.com',
      'endingWorkHour': '4',
      'fees': 300,
      'gender': 'Male',
      'graduationDate': '2005-11-15',
      'location': '34.052235,-118.243683',
      'patients': 30,
      'phone': '1234509876',
      'startingWorkHour': '10',
      'type': 'doctor',
      'university': 'Stanford University',
    },
    {
      'id': '4',
      'fName': 'Emily',
      'lName': 'Johnson',
      'specialty': 'Pediatrics',
      'birthDate': '1990-08-22',
      'days': ['Monday', 'Wednesday', 'Friday'],
      'degrees': ['MD', 'Fellowship'],
      'description': 'Dr. Emily is a compassionate pediatrician.',
      'email': 'dr.emily@gmail.com',
      'endingWorkHour': '3',
      'fees': 400,
      'gender': 'Female',
      'graduationDate': '2014-05-10',
      'location': '51.507351,-0.127758',
      'patients': 50,
      'phone': '2345678901',
      'startingWorkHour': '8',
      'type': 'doctor',
      'university': 'Cambridge University',
    },
    {
      'id': '5',
      'fName': 'David',
      'lName': 'Williams',
      'specialty': 'Neurology',
      'birthDate': '1982-11-30',
      'days': ['Tuesday', 'Thursday', 'Saturday'],
      'degrees': ['PhD', 'MD'],
      'description': 'Dr. David specializes in neurological disorders.',
      'email': 'dr.david@gmail.com',
      'endingWorkHour': '7',
      'fees': 800,
      'gender': 'Male',
      'graduationDate': '2008-09-25',
      'location': '48.856613,2.352222',
      'patients': 35,
      'phone': '3456789012',
      'startingWorkHour': '11',
      'type': 'doctor',
      'university': 'Oxford University',
    },
    {
      'id': '6',
      'fName': 'Laura',
      'lName': 'Brown',
      'specialty': 'Gynecology',
      'birthDate': '1975-02-14',
      'days': ['Monday', 'Thursday'],
      'degrees': ['MD'],
      'description': 'Dr. Laura is dedicated to women\'s health.',
      'email': 'dr.laura@gmail.com',
      'endingWorkHour': '2',
      'fees': 600,
      'gender': 'Female',
      'graduationDate': '2000-04-18',
      'location': '35.689487,139.691711',
      'patients': 45,
      'phone': '4567890123',
      'startingWorkHour': '7',
      'type': 'doctor',
      'university': 'Tokyo University',
    },
  ];

  void _removeDoctor(String doctorId) {
    setState(() {
      dummyDoctors.removeWhere((doctor) => doctor['id'] == doctorId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Doctors')),
      body: ListView.builder(
        itemCount: dummyDoctors.length,
        itemBuilder: (context, index) {
          final doctor = dummyDoctors[index];
          return ListTile(
            title: Text('${doctor['fName']} ${doctor['lName']}'),
            subtitle: Text(doctor['specialty']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorDetailPage(
                    doctor: doctor,
                    onAccept: _removeDoctor,
                    onReject: _removeDoctor,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DoctorDetailPage extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final Function(String) onAccept;
  final Function(String) onReject;

  const DoctorDetailPage({
    Key? key,
    required this.doctor,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${doctor['fName']} ${doctor['lName']}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Specialty', doctor['specialty']),
            _buildDetailRow('Birth Date', doctor['birthDate']),
            _buildDetailRow('Work Days', doctor['days'].join(', ')),
            _buildDetailRow('Degrees', doctor['degrees'].join(', ')),
            _buildDetailRow('Description', doctor['description']),
            _buildDetailRow('Email', doctor['email']),
            _buildDetailRow('Phone', doctor['phone']),
            _buildDetailRow('Gender', doctor['gender']),
            _buildDetailRow('Location', doctor['location']),
            _buildDetailRow('Patients', doctor['patients'].toString()),
            _buildDetailRow('Fees', doctor['fees'].toString()),
            _buildDetailRow('Starting Work Hour', doctor['startingWorkHour']),
            _buildDetailRow('Ending Work Hour', doctor['endingWorkHour']),
            _buildDetailRow('University', doctor['university']),
            _buildDetailRow('Graduation Date', doctor['graduationDate']),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onAccept(doctor['id']);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text('Accept'),
                ),
                ElevatedButton(
                  onPressed: () {
                    onReject(doctor['id']);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text('Reject'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(child: Text(value)),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DoctorManagementPage(),
    );
  }
}
