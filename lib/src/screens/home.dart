import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradedepot_demo/app/profile/presentation/ui/screens/profile.dart';
import 'package:tradedepot_demo/src/res/colours.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';

class Home extends StatefulWidget{
  final email;
  Home(this.email);
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}


class _Home extends State<Home>
  with SingleTickerProviderStateMixin {
  int currentPage;
  Color currentColor = Colors.deepPurple;
  Color inactiveColor = Colors.black;
  PageController tabBarController;


  @override
  void initState() {
  super.initState();
  currentPage = 1;
  tabBarController = new PageController(initialPage: 1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Row(children: [
          const SizedBox(width: 10),
          CircleAvatar(child:Icon(Icons.flash_on,color:Colors.white),radius: 20,backgroundColor: Colors.blue),
          const SizedBox(width: 15),
          Text("TRADE DEPOT",style: TextStyle(color: Colours.navBarText,fontSize: 25,fontWeight: FontWeight.bold))
        ],),
        elevation: 0.0,backgroundColor: Colors.transparent,centerTitle: false,
        actions: [
          IconButton(icon:Icon(Icons.highlight_off, color: Colours.navBarText,size: 30),onPressed: ()=>Navigator.of(context).pop()),
          const SizedBox(width: 15),
        ],),
      body:  PageView(
          controller: tabBarController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Placeholder(),
            Profile(widget.email),
          ]),
      backgroundColor: Colors.white,
      bottomNavigationBar: CubertoBottomBar(
                            key: Key("BottomBar"),
                            padding: EdgeInsets.all(10),
                            inactiveIconColor: Color.fromRGBO(87, 165, 244, 1.0),
                            tabStyle: CubertoTabStyle.STYLE_NORMAL,
                            selectedTab: currentPage,
                            tabs: [TabData(
                                key: Key("dashboard"),
                                iconData: Icons.dashboard,
                                title: "Dashboard",)
                                /*tabColor: currentPage==0? Color.fromRGBO(87, 165, 244, 1.0): Colors.grey,
                                tabGradient: LinearGradient(
                                    colors: [(currentPage==0? Color.fromRGBO(87, 165, 244, 1.0): Colors.grey).withOpacity(0.5), (currentPage==0? Color.fromRGBO(87, 165, 244, 1.0): Colors.grey).withOpacity(0.1)],
                                    stops: [0.0, 0.7]))*/,
                              TabData(
                                  key: Key("profile"),
                                  iconData: Icons.account_circle,
                                  title: "Profile",)
                              /*    tabColor: currentPage==1? Color.fromRGBO(87, 165, 244, 1.0): Colors.grey,
                                  tabGradient: LinearGradient(
                                      colors: [(currentPage==1? Color.fromRGBO(87, 165, 244, 1.0): Colors.grey).withOpacity(0.5), (currentPage==1? Color.fromRGBO(87, 165, 244, 1.0): Colors.grey).withOpacity(0.1)],
                                      stops: [0.0, 0.7]))*/
                             ],
                            onTabChangedListener: (position, title, color) {
    setState(() {currentPage = position;tabBarController.jumpToPage(position);});}));}


  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }
}

class Tabs {
  final IconData icon;
  final String title;
  final Color color;
  final Gradient gradient;

  Tabs(this.icon, this.title, this.color, this.gradient);
}

getGradient(Color color) {
  return LinearGradient(
      colors: [color.withOpacity(0.5), color.withOpacity(0.1)],
      stops: [0.0, 0.7]);
}