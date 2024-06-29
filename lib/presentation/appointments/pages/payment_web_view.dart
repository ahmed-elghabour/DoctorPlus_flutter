import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class PaymentWebViewPage extends StatefulWidget {
  final String paymentURL;
  const PaymentWebViewPage({super.key, required this.paymentURL});

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
   controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.paymentURL),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(title: "Pay with card",),
      body: WebViewWidget(controller: controller),
    );
  }
}
