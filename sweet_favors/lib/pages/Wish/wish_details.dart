import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/Utils/text_use.dart';
import 'package:sweet_favors/pages/home.dart';

class WishDetails extends StatelessWidget {
  const WishDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Heading('Waifu'),
        leading: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()))  ,
                                icon: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      
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
              LayoutBuilder(
                builder: (context, constraints) {
                  return ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(constraints.maxWidth * 0.8, 50), // Adjust height as needed
                      backgroundColor: colorUse.activeButton
                    ),
                    child: const RegularTextButton('GRANT WISH'),
                  );
                },
              ),        
              const SizedBox(height: 30,)
            ],
            
          ),
          
            
        ),
        
      ),
    );
  }
}