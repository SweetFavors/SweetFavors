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
    return Card(
      color: const Color.fromARGB(255, 247, 242, 255),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Container(
                //color: colorUse.activeButton,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3.8,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  pic,
                                  width: 500,
                                  height: 200,
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                price,
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    color: colorUse.textColorSecondary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
