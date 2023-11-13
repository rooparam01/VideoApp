
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class MyHomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? _currentLocation;
  MyHomePageAppBar(this._currentLocation);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(LineAwesome.user),
        onPressed: () {

        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(LineAwesome.location_arrow_solid),
            onPressed: () {
            },
          ),
          SizedBox(width: 8.0),
          Text(this._currentLocation.toString().substring(0, 20),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),overflow: TextOverflow.ellipsis,),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(LineAwesome.bell),
          onPressed: () {
          },
        ),
      ],
    );
  }
}