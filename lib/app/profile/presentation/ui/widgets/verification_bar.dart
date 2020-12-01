import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradedepot_demo/src/res/colours.dart';
import 'package:tradedepot_demo/src/res/style.dart';

class VerificationBar extends StatelessWidget{
  final IconData icon;
  final int level;
  final String label;
  final int activeLevel;

  VerificationBar({@required this.icon,@required this.label,@required this.activeLevel,@required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color:  activeLevel > level ?Colors.grey[50]:Colors.grey[100],borderRadius: BorderRadius.circular(5)),
      height: 200,
      child: Stack(
          children:[
            Column(
              children: [
                Expanded(
                    child: Center(child:Icon(icon,color: activeLevel > level ?Colors.grey[500]:Colours.regText,size:100))
                ),
                Text("Level $level", style:Style.regText),
                const SizedBox(height:5),
                Text("$label", style:Style.regText),
                const SizedBox(height:10),
              ],
            ),
            activeLevel > level ? Align(child:Padding(child:Icon(Icons.verified,color: Color.fromRGBO(108, 210, 207, 1.0),size:20),padding: EdgeInsets.all(20)),alignment: Alignment.topRight):Text(" ")
          ]),
    );
  }


}