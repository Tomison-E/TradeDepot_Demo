

import 'package:flutter/material.dart';
import 'package:tradedepot_demo/app/signIn/presentation/ui/screens/signIn.dart';
import 'package:tradedepot_demo/src/constants/uiData.dart';
import 'package:tradedepot_demo/src/screens/home.dart';
import 'package:tradedepot_demo/src/screens/not_found.dart';



class Router {


    static Route<dynamic> generateRoute(settings) {
      switch (settings.name) {
        case UIData.loginRoute:
          return MaterialPageRoute(builder: (_) => SignIn());
          break;
        case UIData.homeRoute:
          return MaterialPageRoute(builder: (_) => Home(settings.arguments));
          break;
        default: return  MaterialPageRoute(
            builder: (context) => NotFoundPage());
      }

    }

    static Route<dynamic>  unknownRoute (settings) {
      return  MaterialPageRoute(
        builder: (context) => NotFoundPage());
    }

}




