import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animechanproject/view/login_screen.dart';
import 'package:animechanproject/view/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final x =  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id : (context) => LoginScreen(),
        MainScreen.id : (context) => MainScreen(),
      },
    );
  }
}
