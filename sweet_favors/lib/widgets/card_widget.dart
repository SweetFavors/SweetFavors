import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/Wish/wish_details.dart';

class CardWidget extends StatelessWidget {
  final String product;
  final String grantBy;

  const CardWidget({super.key, required this.product, required this.grantBy});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WishDetails(),
                // builder: (context) => WishDetails(product: product, grantBy: grantBy),
              ),
            );
          },
          child: Card(
            // margin: EdgeInsets.only(bottom: 25),
            color: colorUse.secondaryColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 10.0),
                ListTile(
                  title: Text(product),
                  subtitle: Text('Granted by $grantBy'),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
