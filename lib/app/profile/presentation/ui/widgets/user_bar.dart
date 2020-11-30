import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradedepot_demo/src/res/colours.dart';
import 'package:tradedepot_demo/src/res/style.dart';

class UserBar extends StatelessWidget{

  final String fName;
  final String lName;
  final String username;
  final String email;

  UserBar(this.fName,this.lName,this.username,this.email);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:Row(
        children: [
          Icon(Icons.account_circle_rounded, color: Colours.outlineBorder,size: 100),
          const SizedBox(width:10),
          Column(
            children: [
              Text("$fName $lName", style:Style.regText,textAlign: TextAlign.left),
              const SizedBox(height:10),
              Text(username, style:Style.regText),
              const SizedBox(height:10),
              Text(email, style:Style.regText),
            ],crossAxisAlignment: CrossAxisAlignment.start,
          ),

        ],crossAxisAlignment: CrossAxisAlignment.start,
      ),
      height: 100,
    );
  }

}