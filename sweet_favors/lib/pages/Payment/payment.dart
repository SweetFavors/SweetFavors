import 'package:flutter/material.dart';
import 'package:sweet_favors/pages/Payment/paymentInfo.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/widgets/title_bar.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarPop(title: 'Payment', centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          Divider(color: Colors.grey),
           Container( 
              padding: EdgeInsets.all(20), 
              child: PaymentInfo(), 
          ),
          const Spacer(), 
          ButtonAtBottom(onPressed: () {}, text: 'Done'), 
        ],
      ),
    );
  }
}