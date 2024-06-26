import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/data/data%20sources/payment_remote_data_source.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose Payment Method:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            // Display Image based on selected payment method
            if (selectedPaymentMethod == 'cash')
              Image.asset(
                'assets/imgs/cash_image.png',
                height: 200,
                fit: BoxFit.contain,
              ),
            if (selectedPaymentMethod == 'card')
              Image.asset(
                'assets/imgs/card_image.png',
                height: 200,
                fit: BoxFit.contain,
              ),
            if (selectedPaymentMethod != 'cash' &&
                selectedPaymentMethod != 'card')
              Image.asset(
                'assets/imgs/transparent.png',
                height: 200,
                fit: BoxFit.contain,
              ),
            const SizedBox(height: 20.0),
            // Pay via Cash Button
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  selectedPaymentMethod = 'cash';
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                backgroundColor:
                    selectedPaymentMethod == 'cash' ? Colors.green : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: const Icon(Icons.money),
              label: const Text(
                'Pay via Cash',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            const SizedBox(height: 20.0),
            // Pay via Debit/Credit Card Button
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  selectedPaymentMethod = 'card';
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                backgroundColor:
                    selectedPaymentMethod == 'card' ? Colors.green : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: const Icon(Icons.credit_card),
              label: const Text(
                'Pay via Debit/Credit Card',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            const Spacer(), // Pushes the next widget to the bottom
            // Confirmation Button
            if (selectedPaymentMethod.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Navigate to payment confirmation page based on selected method
                    if (selectedPaymentMethod == 'cash') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CashPaymentSuccessPage(),
                        ),
                      );
                    } else if (selectedPaymentMethod == 'card') {
                      _redirectToPaymentGateway(context);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Confirm Payment Method',
                    style: TextStyle(fontSize: 18.0, color: Colors.red),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _redirectToPaymentGateway(BuildContext context) async {
    String authToken = await PaymentRemoteDataSource.getAuthToken();
    int orderId = await PaymentRemoteDataSource.createOrder(authToken, 260);
    String paymentURL =
        await PaymentRemoteDataSource.getPaymentURL(orderId, authToken, 260, {
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
                  Navigator.pop(context);
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

    //     Navigator.push(context,MaterialPageRoute(
    //   builder: (context) => PaymentWebViewPage(paymentURL: paymentURL,),
    // ),);
  }
}

class CashPaymentSuccessPage extends StatelessWidget {
  const CashPaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(
        title: 'Payment Success',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100.0,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Reservation Successful!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'You will pay in cash when \nyou go to your appointment.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
