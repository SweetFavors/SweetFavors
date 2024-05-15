import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
      icon: Padding(
        padding: const EdgeInsets.only(left: 7.0),
        child: Icon(
          _isFavorite ? Icons.favorite : Icons.favorite_border,
          color: _isFavorite
              ? Colors.white
              : Colors.white, // Change color if favorite
        ),
      ),
      label: SizedBox.shrink(),
      style: ElevatedButton.styleFrom(
        backgroundColor: _isFavorite
            ? Color.fromARGB(193, 255, 131, 218)
            : Color.fromARGB(
                193, 255, 131, 218), // Change background color if favorite
        shape: const CircleBorder(),
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
      ),
    );
  }
}