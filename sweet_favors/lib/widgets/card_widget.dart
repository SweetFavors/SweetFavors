import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/Utils/text_use.dart';
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
              ),
            );
          },
          child: Card(
            // margin: EdgeInsets.only(bottom: 25),
            color: Color.fromARGB(255, 244, 221, 255),
            elevation: 7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 10.0),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      product,
                      style: TextStyles.cardTitleStyle(),
                    ),
                  ),
                  subtitle: Text(
                    'Granted by $grantBy',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 93, 94, 101),
                    ).merge(
                      TextStyles.cardSubtitleStyle(),
                    ),
                  ),
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

class ProfileCard extends StatelessWidget {
  final String product;
  final Widget? destination;
  final IconData icon;
  const ProfileCard(
      {super.key, required this.product, this.destination, required this.icon});

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
                builder: (context) => destination!,
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
                  leading: Icon(icon),
                  title: RegularText(product),
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
