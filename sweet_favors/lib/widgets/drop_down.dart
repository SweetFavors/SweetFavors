import 'package:flutter/material.dart';
import 'package:sweet_favors/widgets/follower_content.dart';
import 'package:sweet_favors/widgets/following_content.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String _selectedItem = 'Followers';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: _selectedItem,
          onChanged: (String? newValue) {
            setState(() {
              _selectedItem = newValue!;
            });
          },
          items: <String>['Followers', 'Following'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        _selectedItem == 'Followers'
            ? const FollowerContent()
            : const FollowingContent(),
      ],
    );
  }
}
