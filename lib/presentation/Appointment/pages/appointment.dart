import 'package:doctor_plus/core/widgets/check_box.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/core/widgets/icon_picker.dart';
import 'package:doctor_plus/core/widgets/toast.dart';
import 'package:doctor_plus/data/data%20sources/payment_remote_data_source.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/domain/cubits/user/user_cubit.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:doctor_plus/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentPage extends StatefulWidget {
  final Doctor doctor;
  const AppointmentPage({super.key, required this.doctor});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage>
    with SingleTickerProviderStateMixin {
  late TextEditingController _dateController;
  late String _appointmentType = "";
  late String _paymentMethod = "";
  bool isUrgant = false;
  bool showSummary = false;
  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(
        title: 'Book Appointment',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      customCheckBox(
                        value: isUrgant,
                        label: "Is Urgent?",
                        onChanged: (newVal) =>
                            setState(() => isUrgant = newVal!),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: customIconPicker(
                          label: 'Select Reservation Date',
                          icon: Icons.calendar_month,
                          controller: _dateController,
                          validator: (Validator.nameValidator),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                helpText: "Select Reservation Date",
                                initialDate:
                                    DateTime.now().add(const Duration(days: 1)),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 60)),
                                selectableDayPredicate: (DateTime day) {
                                  final List<String> allowedDays =
                                      widget.doctor.workingDays.days;
                                  switch (day.weekday) {
                                    case DateTime.sunday:
                                      return allowedDays.contains('Sunday');
                                    case DateTime.monday:
                                      return allowedDays.contains('Monday');
                                    case DateTime.tuesday:
                                      return allowedDays.contains('Tuesday');
                                    case DateTime.wednesday:
                                      return allowedDays.contains('Wednesday');
                                    case DateTime.thursday:
                                      return allowedDays.contains('Thursday');
                                    case DateTime.friday:
                                      return allowedDays.contains('Friday');
                                    case DateTime.saturday:
                                      return allowedDays.contains('Saturday');
                                    default:
                                      return false;
                                  }
                                });
                            if (picked != null) {
                              setState(() {
                                _dateController.text =
                                    DateFormat('yyyy-MM-dd').format(picked);
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Appointment Type',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 9,
                    children: ['Examination', 'Consultation']
                        .map((type) => ChoiceChip(
                              label: Text(type),
                              selected: _appointmentType == type,
                              onSelected: (selected) {
                                setState(() {
                                  _appointmentType = selected ? type : "";
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: paymentButton(
                            label: "Pay via Cash",
                            icon: Icons.currency_pound,
                            isSelected: _paymentMethod == "cash",
                            onPressed: () =>
                                setState(() => _paymentMethod = "cash")),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: paymentButton(
                            label: "Pay via Card",
                            icon: Icons.credit_card,
                            isSelected: _paymentMethod == "card",
                            onPressed: () =>
                                setState(() => _paymentMethod = "card")),
                      ),
                    ],
                  ),
                ],
              ),
              // const Spacer(),
              showSummary ? _buildSummaryTab() : const SizedBox(),
              Row(
                mainAxisAlignment: showSummary
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_dateController.text.isEmpty) {
                        FailureToast.showToast(
                          msg: 'Please fill all the required fields!',
                        );
                      } else {
                        setState(() {
                          showSummary = true;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Continue'),
                  ),
                  !showSummary
                      ? const SizedBox()
                      : ElevatedButton(
                          onPressed: () => _bookAppointment(
                            appointment: AppointmentModel(
                              type: _appointmentType,
                              date: _dateController.text,
                              payment: _paymentMethod,
                              doctorId: widget.doctor.id!,
                              isUrgant: isUrgant,
                              patientId:
                                  context.read<UserCubit>().getUser().id!,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('Book Now'),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity * .7,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 206, 204, 204),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            const Text('Booking Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
              'Date & Time',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              _dateController.text,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'Appointment Type',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              _appointmentType,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text('Doctor Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
              "${widget.doctor.fName} ${widget.doctor.lName}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text('Payment Type',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
              _paymentMethod,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'Payment Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Fees ${_appointmentType == 'Consultation' ? 100 : widget.doctor.fees} LE',
              style: const TextStyle(fontSize: 18),
            ),
            const Text(
              'Service 50 LE',
              style: TextStyle(fontSize: 18),
            ),
            isUrgant
                ? const Text(
                    'Urgent Fees 100 LE',
                    style: TextStyle(fontSize: 18),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Total ${calcTotalFees()} LE',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  int calcTotalFees() {
    int sum =
        (_appointmentType == 'Consultation' ? 100 : widget.doctor.fees) + 50;
    return isUrgant ? sum += 100 : sum;
  }

  Future<void> _bookAppointment({required AppointmentModel appointment}) async {
    try {
      var res = await CustomFirebase().addNewNestedCollection(
        maincollection: "doctors",
        data: appointment.toDoctorJson(),
        docID: appointment.doctorId,
        nestedcollection: "appointments",
      );
      // SuccessToast.showToast(
      //   msg: "Appointment booked successfully!",
      // );
      await CustomFirebase().addNewNestedCollection(
        maincollection: "patients",
        data: appointment.toPatientJson(),
        docID: appointment.patientId,
        nestedDocID: res.id,
        nestedcollection: "appointments",
      );
      if (_paymentMethod == "cash") {
        SuccessToast.showToast(
          msg: 'Appointment booked successfully',
        );
        Navigator.pushNamed(context, Routes.home);
      }
      if (_paymentMethod == "card") {
        await redirectToPaymentGateway(context, calcTotalFees());
      }
    } catch (e) {
      FailureToast.showToast(
        msg: 'Appointment Error: $e',
      );
    }
  }
}

redirectToPaymentGateway(BuildContext context, int price) async {
  print("Payment Auth Token: sdasdasd");

  String authToken = await PaymentRemoteDataSource.getAuthToken();
  print("Payment Auth Token: $authToken");
  int orderId = await PaymentRemoteDataSource.createOrder(authToken, price);
  print("Payment Auth Token: $orderId");

  String paymentURL =
      await PaymentRemoteDataSource.getPaymentURL(orderId, authToken, price, {
    "apartment": "803",
    "email": "claudette09@exa.com",
    "floor": "42",
    "first_name": "Clifford",
    "street": "Ethan Land",
    "building": "8028",
    "phone_number": "+86(8)9135210487",
    "shipping_method": "PKG",
    "postal_code": "01898",
    "city": "Jaskolskiburgh",
    "country": "CR",
    "last_name": "Nicolas",
    "state": "Utah"
  });
  print("Payment Auth Token: $paymentURL");

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('You will be redirected to complete the payment.'),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                await launchUrl(Uri.parse(paymentURL));
                Navigator.pushNamed(context, Routes.home);
              } catch (e) {
                throw Exception(e);
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

Widget paymentButton({
  required String label,
  required IconData icon,
  bool isSelected = false,
  required void Function()? onPressed,
}) =>
    ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        backgroundColor: isSelected ? Colors.grey : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      icon: Icon(icon),
      label: Text(
        label,
        style: const TextStyle(fontSize: 18.0),
      ),
    );
