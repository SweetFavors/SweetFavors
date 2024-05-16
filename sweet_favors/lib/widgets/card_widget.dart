import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/Utils/text_use.dart';
import 'package:sweet_favors/pages/Wish/wish_details.dart';

class CardWidget extends StatelessWidget {
  final String product;
  final String? grantBy;
  final int wishlistId;
  final String? username;
  final int? userid;

  const CardWidget(
      {super.key,
      required this.product,
      this.grantBy,
      required this.wishlistId,
      this.username,
      this.userid
      });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        child: InkWell(
          onTap: () {
            if (wishlistId != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishDetails(
                    wishlist_id: wishlistId,
                    username: username ?? 'null',
                  ),
                ),
              );
            }
          },
          child: Card(
            // margin: EdgeInsets.only(bottom: 25),
            color: grantBy != null
                ? const Color.fromARGB(173, 183, 255, 219)
                // : ,
                : grantBy == null
                    ? const Color.fromARGB(198, 242, 215, 255)
                    : const Color.fromARGB(153, 255, 225, 90),
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
                      style: TextStyles.cardTitleStyle().merge(TextStyle(
                          color: grantBy != null
                              ? const Color.fromARGB(200, 5, 117, 70)
                              : colorUse.textFriend)),
                    ),
                  ),
                  subtitle: Text(
                    grantBy != null ? 'Granted by $grantBy' : 'Not granted yet',
                    style: grantBy != null
                        ? const TextStyle(
                            color: Color.fromARGB(202, 76, 122, 102),
                          ).merge(
                            TextStyles.cardSubtitleStyle(),
                          )
                        : const TextStyle(
                            color: Color.fromARGB(224, 103, 78, 117),
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
        margin: const EdgeInsets.only(bottom: 15),
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
