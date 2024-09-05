import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  final _auth = FirebaseAuth.instance;

  //Variabel untuk spinner + async
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      //inputDecoration untuk mempercantik tampilan pada kotak untuk menulis (pencet kTextFieldDecoration)
                      hintText: 'Enter Your Password')),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  text: 'Log In',
                  tombol: () async {
                    //Do something
                    //Spinner loading true untuk muncul
                    setState(() {
                      showSpinner = true;
                    });

                    //Untuk meminta user login dengan akun buatannya
                    final UserCredential userLogin =
                        await _auth.signInWithEmailAndPassword(
                            email: email!, password: password!);
                    try {
                      // ignore: unnecessary_null_comparison
                      if (userLogin != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }

                      //Spinner Berhenti
                      showSpinner = true;
                    } catch (e) {
                      print(e);
                    }
                  },
                  warna: Colors.lightBlueAccent)
            ],
          ),
        ),
      ),
    );
  }
}
