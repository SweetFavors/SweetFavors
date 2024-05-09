import 'package:flutter/material.dart';
import 'package:sweet_favors/pages/home.dart';
import 'package:sweet_favors/widgets/text_form.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/widgets/add_image.dart';

class NewWishAdd extends StatelessWidget {
  const NewWishAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Item",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // leading: IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: isWeb ? 700 : 380,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextForm(label: 'Item name'),
                const TextForm(label: 'Quantity'),
                const TextForm(label: 'Price'),
                const TextForm(label: 'Link URL'),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: AddImage(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: ButtonAtBottom(
                    onPressed: () {},
                    text: 'SUBMIT',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
