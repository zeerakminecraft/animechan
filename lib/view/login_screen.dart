
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:animechanproject/constants.dart';
import 'package:animechanproject/components/button.dart';
import 'package:animechanproject/view/main_screen.dart';


class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email address'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              ButtonWithinPadding(
                  colour: Colors.lightBlueAccent,
                  text: 'Login',
                  onPressed: () async{
                    setState(() {
                      showSpinner = true;
                    });
                    try{
                      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                      Navigator.pushNamed(context, MainScreen.id);
                    } catch(e){
                      print('Error $e');
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  }
              ),
              ButtonWithinPadding(
                  colour: Colors.lightBlueAccent,
                  text: 'Sign Up',
                  onPressed: () async{
                    setState(() {
                      showSpinner = true;
                    });
                    try{
                      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      // Navigator.pushNamed(context, LoginScreen.id);
                    } on FirebaseException catch(e){
                      showDialog(context: context, builder: (context){
                        return AlertDialog(

                        );
                      });
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
