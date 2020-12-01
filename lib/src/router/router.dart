

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedepot_demo/app/signIn/presentation/logic/authBloc/auth_cubit.dart';
import 'package:tradedepot_demo/app/signIn/presentation/ui/screens/signIn.dart';
import 'package:tradedepot_demo/src/constants/uiData.dart';
import 'package:tradedepot_demo/src/screens/home.dart';
import 'package:tradedepot_demo/src/screens/not_found.dart';

import '../../injection_container.dart';



class Router {

    static Route<dynamic> generateRoute(settings) {
      switch (settings.name) {
        case UIData.loginRoute:
          return MaterialPageRoute(builder: (_) => BlocProvider<AuthCubit>(create: (context) => AuthCubit(getIt: sl),
              child: SignIn()));
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




