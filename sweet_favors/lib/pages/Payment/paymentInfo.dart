import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/text_use.dart';

class PaymentInfo extends StatefulWidget {
  final String userId;
  const PaymentInfo({super.key, required this.userId});

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  @override
  void initState() {
    super.initState();
    fetchDonate();
  }

  Future<Map<String, dynamic>> fetchDonate() async {
    Dio dio = Dio(); // Create a Dio instance
    final response =
        await dio.get('http://10.0.2.2:1432/GetDonateInfo/${widget.userId}');

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load wishlists');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: fetchDonate(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            final donateData = snapshot.data;
            final firstname = donateData?['firstname'] ?? '';
            final lastname = donateData?['lastname'] ?? '';
            final promptpayId = donateData?['prompt_pay_acc'] ?? '';
            final promptpayQR = donateData?['prompt_pay_qr'] ?? '';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                InfoItem(label: 'Name', value: firstname + ' ' + lastname),
                InfoItem(label: 'PromptPay account number', value: promptpayId),
                const SizedBox(height: 30),
                const RegularTextBold('PromptPay QR'),
                Center(
                    child: Image.network(
                  promptpayQR,
                  width: 200,
                  height: 200,
                )),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

class InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const InfoItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align labels to the left
      children: [
        RegularTextBold(label),
        const SizedBox(height: 12),
        RegularText(value),
        const SizedBox(height: 25),
      ],
    );
  }
}
