import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/text_use.dart';



class PaymentInfo extends StatelessWidget {
  const PaymentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        SizedBox(height: 25),
        InfoItem(label: 'Name', value: 'James'),
        InfoItem(label: 'PromptPay account number', value: '1 2345 678901 23 4'),
        SizedBox(height: 30), 
        RegularTextBold('PromptPay QR'),
        Center(child: Image.asset('assets/QR.png')),
      ],
    );
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
        SizedBox(height: 12),
        RegularText(value),
        SizedBox(height: 25), 
      ],
    );
  }
}