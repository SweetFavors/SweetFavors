import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sweet_favors/Utils/color_use.dart';

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
                  height: MediaQuery.of(context).size.height / 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Flexible(
                      flex: 4,
                      fit: FlexFit.loose,
                      child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                pic,
                                width: 500,
                                height: 200,
                                fit: BoxFit.fill,
                              ))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
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
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
