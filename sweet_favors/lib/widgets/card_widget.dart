import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';



class CardWidget extends StatelessWidget {
  final String product;
  final String grantBy;
  
  const CardWidget(
    {super.key,
     required this.product,
     required this.grantBy,

     });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.only(bottom: 25),
        color: colorUse.secondaryColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 10.0), // Space at the top
            ListTile(
              title: Text(product),
              subtitle: Text('Granted by $grantBy'),
            ),
            SizedBox(height: 10.0), // Space at the bottom
          ],
        ),
      ),
    );
  }
}