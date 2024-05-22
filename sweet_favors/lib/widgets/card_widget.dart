import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/Utils/text_use.dart';
import 'package:sweet_favors/pages/Wish/wish_details.dart';
import 'package:sweet_favors/provider/token_provider.dart';
import 'package:sweet_favors/widgets/Button_for_pop_up.dart';
import 'package:sweet_favors/widgets/pop_up.dart';

class CardWidget extends StatelessWidget {
  final String product;
  final String? grantBy;
  final int wishlistId;
  final String? username;
  final int? userid;
  final bool? alreadyBought;
  final int? grantedByUserId;
  final VoidCallback? onUpdate;
  final VoidCallback? onUpdateBuy;

  const CardWidget({
    super.key,
    required this.product,
    this.grantBy,
    required this.wishlistId,
    this.username,
    this.userid,
    this.alreadyBought,
    this.grantedByUserId,
    this.onUpdate,
    this.onUpdateBuy,
  });

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> _RecieverGotIt() async {
      final token = Provider.of<TokenProvider>(context, listen: false).token;
      final userId = Provider.of<TokenProvider>(context, listen: false).userId;
      Dio dio = Dio(); // Create a Dio instance
      final response = await dio.put(
        'http://10.0.2.2:1432/UpdateReceiverGotIt/$wishlistId/$grantedByUserId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json', // Adjust content type as needed
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to put _RecieverGotIt');
      }
    }

    Future<Map<String, dynamic>> _RecieverDidntGetit() async {
      final token = Provider.of<TokenProvider>(context, listen: false).token;
      final userId = Provider.of<TokenProvider>(context, listen: false).userId;
      Dio dio = Dio(); // Create a Dio instance
      final response = await dio.put(
        'http://10.0.2.2:1432/UpdateReceiverDidntGetIt/$wishlistId/$grantedByUserId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json', // Adjust content type as needed
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to put _RecieverDidntGetit');
      }
    }

    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        child: InkWell(
          onTap: () {
            if (grantBy != null && alreadyBought == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishDetails(
                    wishlist_id: wishlistId,
                    username: username ?? 'null',
                    onUpdateBuy: onUpdateBuy,
                  ),
                ),
              );
            } else if (grantBy != null && alreadyBought != true) {
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return PopUp(
                      title: 'Did you recieved the wish?',
                      buttons: [
                        ButtonForPopUp(
                            onPressed: () async {
                              Navigator.of(dialogContext).pop();
                              await _RecieverGotIt();
                              onUpdate!();
                            },
                            text: 'Yes'),
                        ButtonForPopUp(
                            onPressed: () async {
                              Navigator.of(dialogContext).pop();
                              await _RecieverDidntGetit();
                              onUpdate!();
                            },
                            text: 'No'),
                      ],
                    );
                  });
            } else if (grantBy == null && alreadyBought == null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishDetails(
                    wishlist_id: wishlistId,
                    username: username ?? 'null',
                    onUpdateBuy: onUpdateBuy,
                  ),
                ),
              );
            }
          },
          child: Card(
            // margin: EdgeInsets.only(bottom: 25),
            color: grantBy != null && alreadyBought == true
                ? const Color.fromARGB(
                    173, 183, 255, 219) // Green (granted and bought)
                : (grantBy != null || alreadyBought == true)
                    ? const Color.fromARGB(153, 255, 225, 90)
                    : const Color.fromARGB(198, 242, 215, 255),
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
                          color: grantBy != null && alreadyBought == true
                              ? const Color.fromARGB(200, 5, 117, 70)
                              : colorUse.textFriend)),
                    ),
                  ),
                  subtitle: Text(
                    grantBy != null
                        ? 'Granted by $grantBy'
                        : alreadyBought == true
                            ? 'Already bought'
                            : 'Not granted yet',
                    style: (grantBy != null &&
                            alreadyBought ==
                                true) // Use nested ternary for subtitle style
                        ? const TextStyle(
                                color: Color.fromARGB(202, 76, 122, 102))
                            .merge(TextStyles.cardSubtitleStyle())
                        : (grantBy != null || alreadyBought == true)
                            ? const TextStyle(
                                    color: Color.fromARGB(224, 103, 78, 117))
                                .merge(TextStyles.cardSubtitleStyle())
                            : TextStyles
                                .cardSubtitleStyle(), // Default style if neither condition is true
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
