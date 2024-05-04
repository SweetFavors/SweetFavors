import 'package:flutter/material.dart';
import 'package:sweet_favors/pages/home.dart';
import 'package:sweet_favors/widgets/text_form.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/widgets/add_image.dart';

class NewWishAdd extends StatelessWidget {
  const NewWishAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item"),
        leading: IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home())),
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.25,
            width: 600,
            child: Column(children: [
              TextForm(label: 'Item name'),
              TextForm(label: 'Quantity'),
              TextForm(label: 'Price'),
              TextForm(label: 'Link URL'),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: AddImage(),
              ),
              ButtonAtBottom(onPressed: () {}, text: 'Submit'),
            ]),
          ),
        ],
      ),
    );
  }
}
