import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:sweet_favors/pages/Navbar/first_home_page.dart';
import 'package:sweet_favors/pages/home.dart';
import 'package:sweet_favors/provider/token_provider.dart';
import 'package:sweet_favors/widgets/text_form.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/widgets/add_image.dart';

class NewWishAdd extends StatefulWidget {
  const NewWishAdd({super.key});

  @override
  State<NewWishAdd> createState() => _NewWishAddState();
}

class _NewWishAddState extends State<NewWishAdd> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  // final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _linkUrlController = TextEditingController();
  File? _selectedImage;

  Future<bool> addWishlistItem() async {
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    final userId = Provider.of<TokenProvider>(context, listen: false).userId;
    const url = 'http://10.0.2.2:1432/PostAddWishlist';
    String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    try {
      var formData = FormData.fromMap({
        'itemname': _itemNameController.text ?? '',
        // 'quantity': _quantityController.text ?? '',
        'Price': _priceController.text ?? '',
        'LinkURL': _linkUrlController.text ?? '',
        'file': await MultipartFile.fromFile(
          _selectedImage!.path,
          filename: fileName,
        ),
      });

      final response = await Dio().post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json', // Adjust content type as needed
          },
        ),
      );

      if (response.statusCode == 200) {
        var map = response.data as Map;

        if (map['status'] == 'Successfully registered') {
          return true;
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    // _quantityController.dispose();
    _priceController.dispose();
    _linkUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Wish",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(240, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 188, 143, 223),
        elevation: 5,
        shadowColor: const Color.fromARGB(255, 171, 171, 171),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: isWeb ? 700 : 380,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextForm(
                  label: 'Item name',
                  controller: _itemNameController,
                ),
                // TextForm(
                //   label: 'Quantity',
                //   controller: _quantityController,
                // ),
                TextForm(
                  label: 'Price',
                  controller: _priceController,
                ),
                TextForm(
                  label: 'Link URL',
                  controller: _linkUrlController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: AddImage(
                    onImageSelected: (image) {
                      if (image != null) {
                        setState(() {
                          _selectedImage = image;
                        });
                      }
                    },
                    textfill: 'Add image + ',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: ButtonAtBottom(
                    onPressed: () async {
                      bool success = await addWishlistItem();
                      if (success) {
                        print('true');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      } else {
                        print('false not successful');
                      }
                    },
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
