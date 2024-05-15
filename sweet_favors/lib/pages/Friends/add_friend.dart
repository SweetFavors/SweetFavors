import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/Navbar/friend_page.dart';
import 'package:sweet_favors/pages/home.dart';
import 'package:sweet_favors/widgets/friend_form.dart';
import 'package:sweet_favors/widgets/bottomBar.dart';
import 'package:sweet_favors/widgets/friend_list.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({super.key});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  final _formKey = GlobalKey<FormState>();
  String _query = '';
  List<dynamic> friends = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true;
    });
    Dio dio = Dio();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final response = await dio
          .get('http://10.0.2.2:1432/GetSearchFriend/1/?query=$_query');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        // Do something with the search results
        setState(() {
          friends = jsonResponse;
          _isLoading = false;
        });
        print(friends);
      } else {
        print('Failed to load search results');
        setState(() {
          friends = [];
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Friend",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(240, 255, 255, 255),
          ),
        ),
        elevation: 5,
        centerTitle: true,
        backgroundColor: colorUse.appBarColor,
        shadowColor: const Color.fromARGB(255, 171, 171, 171),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(240, 255, 255, 255),
            )),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Center(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: FriendForm(
                    label: 'Search friend',
                    onSaved: (value) => _query = value!,
                    onSubmitted: _submitForm,
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            const CircularProgressIndicator()
          else if (_query.isNotEmpty && friends.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Text(
                "User not found",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            )
          else
            Expanded(
              child: FriendList(friends: friends),
            ),
        ],
      ),
      // bottomNavigationBar: const bottomBar(),
    );
  }
}
