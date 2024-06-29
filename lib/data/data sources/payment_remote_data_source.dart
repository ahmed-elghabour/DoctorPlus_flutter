import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymentRemoteDataSource {
  static Future<String> getAuthToken() async{
    final String baseUrl = dotenv.env['BASE_URL']!;
    final String authRequest = dotenv.env['AUTH_REQUEST']!;
    final String apiKey = dotenv.env['API_KEY']!;
    try {
      Response authResponse = await Dio().post(
          '$baseUrl$authRequest',
          data: {
            'api_key': apiKey,
          },
        );
      String authToken = authResponse.data['token'];
      return authToken;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<int> createOrder(String authToken, int price) async {
    final String baseUrl = dotenv.env['BASE_URL']!;
    final String orderRequest = dotenv.env['ORDER']!;
    try {
      Response orderResponse = await Dio().post(
        '$baseUrl$orderRequest',
        data: {
          'auth_token': authToken,
          'delivery_needed': false,
          'amount_cents': '${price * 100}',
          'currency': "EGP"
        },
      );
      int orderId = orderResponse.data['id'];
      return orderId;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String> getPaymentURL(int orderId, String authToken, int price, Map<String,String> billingData) async{
    final String baseUrl = dotenv.env['BASE_URL']!;
    final String paymentKeyRequest = dotenv.env['PAYMENT_KEY']!;
    final String integrationId = dotenv.env['INTEGRATION_ID']!;
    try {
      Response paymentKeyResponse = await Dio().post(
          '$baseUrl$paymentKeyRequest',
          data: {
            'auth_token': authToken,
            'amount_cents': price * 100,
            'expiration': 3600,
            'order_id': orderId.toString(),
            'currency': "EGP",
            'integration_id': integrationId,
            'billing_data': billingData
          },
        );

        String key = paymentKeyResponse.data['token'];
        String paymentURL = dotenv.env['IFRAME_LINK']! + key;
        return paymentURL;
    } catch(e) {
      throw Exception(e);
    }
  }
}