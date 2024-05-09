import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';

class AddImage extends StatelessWidget {
  const AddImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        child: InkWell(
          onTap: () {},
          child: Card(
            // margin: EdgeInsets.only(bottom: 25),
            color: colorUse.secondaryColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 40, right: 40, bottom: 30),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/myGirl.png',
                      width: 170,
                      height: 170,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Add Image +',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: colorUse.textColorSecondary,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
