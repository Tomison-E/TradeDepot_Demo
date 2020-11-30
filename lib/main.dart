import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradedepot_demo/src/constants/uiData.dart';
import 'injection_container.dart' as di;
import 'package:tradedepot_demo/src/router/router.dart' as Controller ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TD Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Controller.Router.generateRoute,
      onUnknownRoute: Controller.Router.unknownRoute,
      initialRoute: UIData.loginRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

