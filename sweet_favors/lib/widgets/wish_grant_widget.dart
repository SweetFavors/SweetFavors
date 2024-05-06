import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sweet_favors/Utils/color_use.dart';

class WishGrant extends StatelessWidget {
  final String price;
  // final String picture;

  const WishGrant({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3.2,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/myGirl.png',
                          width: 350,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                        fontSize: 24.0,
                        color: colorUse.textColorSecondary,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
