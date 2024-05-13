import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/components/favorite_button.dart';

class WishGrant extends StatelessWidget {
  final String price;
  final String pic;
  // final String picture;

  const WishGrant({super.key, required this.price, required this.pic});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      child: Card(
        color: const Color.fromARGB(208, 249, 235, 251),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.8,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          pic,
                          width: 500,
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      right: 1.0,
                      child: FavoriteButton(),
                      // child: ElevatedButton.icon(
                      //   onPressed: () {
                      //     // Handle favorite button tap
                      //   },
                      //   label: const SizedBox.shrink(), // Empty label
                      //   style: ElevatedButton.styleFrom(
                      //     shape: const CircleBorder(),
                      //   ),
                      //   icon: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       const Icon(
                      //         Icons.favorite_border,
                      //         color: colorUse.appBarColor,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Flexible(
                fit: FlexFit.loose,
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: colorUse.textFriend,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
