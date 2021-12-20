import 'package:animechanproject/view/login_screen.dart';
import 'package:animechanproject/view/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.active){
                if(snapshot.data == null){
                  return const LoginScreen();
                } else{
                  return const MainScreen();
                }
              }

              return const Scaffold(
                body: Center(
                    child: Text(
                        "Authenticating...."
                    )
                ),
              );
            },
          );
        }

        return const Scaffold(
          body: Center(
            child: Text("connecting to the app..."),
          ),
        );
      },
    );
  }
}
