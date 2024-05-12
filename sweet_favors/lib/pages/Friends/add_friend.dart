import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.5,
            width: 400,
            child: Form(
              key: _formKey,
              child: FriendForm(
                label: 'Search friend',
                onSaved: (value) => _query = value!,
                onSubmitted: _submitForm,
              ),
            ),
          ),
          if (_isLoading)
            const CircularProgressIndicator()
          else if (friends.isEmpty)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'We couldn\'t find the user',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          else
            Expanded(
              child: FriendList(friends: friends),
            ),
        ],
      ),
      // bottomNavigationBar: bottomBar(),
    );
  }
}
