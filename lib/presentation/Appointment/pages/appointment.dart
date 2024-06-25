import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime? _selectedDate;
  String? _selectedTime;
  String? _appointmentType;
  String? _paymentMethod;
  String? _userId;
  String? _userEmail;

  final Map<String, dynamic> _appointmentData = {
    'id': '123456',
    'doctorId': '123',
    'doctorImage': '',
    'doctorName': 'ahmed elghabour',
    'patientId': '',
    'patientImage': '',
    'patientName': '',
    'appointmentType': '',
    'paymentMethod': '',
    'appointmentDateTime': null,
    'status': 'upcoming',
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = prefs.getString('user.email');
    });
    if (_userEmail != null) {
      _fetchUserId();
    }
  }

  Future<void> _fetchUserId() async {
    if (_userEmail != null) {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _userEmail)
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        setState(() {
          _userId = userSnapshot.docs.first.id;
          _appointmentData['patientId'] = _userId;
          _appointmentData['patientName'] =
              "${userSnapshot.docs.first['fName']} ${userSnapshot.docs.first['lName']}";
        });
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Column(
            children: [
              _buildTimeline(),
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Date & Time'),
                  Tab(text: 'Payment'),
                  Tab(text: 'Summary'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDateTimeTab(),
          _buildPaymentTab(),
          _buildSummaryTab(),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTimelineStep('Date & Time', 0),
          _buildTimelineStep('Payment', 1),
          _buildTimelineStep('Summary', 2),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(String title, int index) {
    bool isSelected = _tabController.index == index;
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: isSelected ? Colors.blue : Colors.grey,
          child: Text(
            (index + 1).toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _pickDate,
            child: Text(_selectedDate == null
                ? 'Select Date'
                : _selectedDate.toString()),
          ),
          const SizedBox(height: 20),
          const Text('Available time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: [
              '08:00 AM',
              '08:30 AM',
              '09:00 AM',
              '09:30 AM',
              '10:00 AM',
              '11:00 AM'
            ]
                .map((time) => ChoiceChip(
                      label: Text(time),
                      selected: _selectedTime == time,
                      onSelected: (selected) {
                        setState(() {
                          _selectedTime = selected ? time : null;
                        });
                      },
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          const Text('Appointment Type',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: ['In Person', 'Video Call', 'Phone Call']
                .map((type) => ChoiceChip(
                      label: Text(type),
                      selected: _appointmentType == type,
                      onSelected: (selected) {
                        setState(() {
                          _appointmentType = selected ? type : null;
                        });
                      },
                    ))
                .toList(),
          ),
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _tabController.animateTo(1);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.blue,
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Payment Option',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Column(
            children: [
              'Credit Card',
              'Master Card',
              'American Express',
              'Capital One',
              'Barclays',
              'Bank Transfer',
              'Paypal'
            ]
                .map((method) => RadioListTile(
                      title: Text(method),
                      value: method,
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value.toString();
                        });
                      },
                    ))
                .toList(),
          ),
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _tabController.animateTo(2);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.blue,
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text('Booking Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('Date & Time'),
          Text(
              '${_selectedDate != null ? _selectedDate.toString() : ''} ${_selectedTime ?? ''}'),
          const SizedBox(height: 10),
          const Text('Appointment Type'),
          Text(_appointmentType ?? ''),
          const SizedBox(height: 20),
          const Text('Doctor Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text('Dr. Randy Wigham'),
          const Text('General | RSUD Gatot Subroto'),
          const Text('4.8 (4,279 reviews)'),
          const SizedBox(height: 20),
          const Text('Payment Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(_paymentMethod ?? ''),
          const SizedBox(height: 10),
          const Text('Payment Info'),
          const Text('Subtotal \$4694'),
          const Text('Tax \$250'),
          const Text('Payment Total \$4944'),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _bookAppointment,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.blue,
              ),
              child: const Text('Book Now'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _appointmentData['appointmentDateTime'] =
            Timestamp.fromDate(pickedDate);
      });
    }
  }

  Future<void> _bookAppointment() async {
    if (_selectedDate != null &&
        _selectedTime != null &&
        _appointmentType != null &&
        _paymentMethod != null &&
        _userId != null) {
      _appointmentData['appointmentDateTime'] = Timestamp.fromDate(DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        int.parse(_selectedTime!.split(':')[0]),
        int.parse(_selectedTime!.split(':')[1].split(' ')[0]),
      ));
      _appointmentData['appointmentType'] = _appointmentType;
      _appointmentData['status'] = "upcoming";

      AppointmentModel appointment = AppointmentModel(
        id: _appointmentData['id'],
        doctorId: _appointmentData['doctorId'],
        doctorImage: _appointmentData['doctorImage'],
        doctorName: _appointmentData['doctorName'],
        patientId: _appointmentData['patientId'],
        patientImage: _appointmentData['patientImage'],
        patientName: _appointmentData['patientName'],
        appointmentType: _appointmentData['appointmentType'],
        paymentMethod: _appointmentData['paymentMethod'],
        appointmentDateTime: _appointmentData['appointmentDateTime'],
        status: AppointmentStatus.upcoming,
      );

      await FirebaseFirestore.instance
          .collection('appointments')
          .add(appointment.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment booked successfully!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete all fields')));
    }
  }
}
