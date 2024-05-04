import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/text_use.dart';
import 'package:sweet_favors/pages/Payment/payment.dart';
import 'package:sweet_favors/pages/home.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/widgets/title_bar.dart';

class WishDetails extends StatelessWidget {
  const WishDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarNavigation(title: 'Waifu', backDestination: Home()),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              Image.asset('testWishdetails.jpg',
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
              ),
              const SizedBox(height: 25,),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    RegularTextBold('\$9999999999999'),
                    Padding(
                      padding: EdgeInsets.all(3),
                      child: RegularText(' Quantity: 1')
                    ),
                    SizedBox(height: 10,),
                    Divider(
                      color: Colors.grey,

                    ),
                    SizedBox(height: 20,),
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: RegularTextBold('Request by'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: RegularText('test'),
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: RegularTextBold('Link URL'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: RegularText('test'),
                        ),
                  ],
                ),
              ),
              const Spacer(),
              ButtonAtBottom(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Payment()));
              }, text: 'GRANT WISH')
            ],
          ),
        ),      
      ),
    );
  }
}