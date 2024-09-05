import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = '/welcome';

  const WelcomeScreen({super.key});
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this, //bekerja sebagai ticker
      duration: const Duration(seconds: 3),
    );

    // animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller!);
    controller!.forward();

    // animation!.addStatusListener((status) {
    //   print(status);
    //   if (status == AnimationStatus.completed) {
    //     controller!.reverse(from: 1);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller!.forward(from: 0);
    //   }
    // });
    controller!.addListener(() {
      setState(() {
        //untuk merubah keadaan agar bisa dianimasikan
      });
      //untuk menampilkan nilai ke konsol pada initstate perlu addlistener
      print(animation!.value);
    });
  }

  @override
  void dispose() {
    //dispose membersihkan suatu fungsi ketika selesai digunakan (agar tidak terjadi kebocoran memori)
    // TODO: implement dispose
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white.withOpacity(animation!.value),//sebelum ubah ke tween
      backgroundColor: animation!.value, //setelah ubah ke tween
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                  child: AnimatedTextKit(
                    // '${controller!.value * 100.toInt()}%',
                    animatedTexts: [
                      TypewriterAnimatedText('Flash Chat',
                          curve: Curves.linear, speed: Duration(seconds: 1))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                text: 'Log In',
                tombol: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                warna: Colors.lightBlueAccent),
            RoundedButton(
                text: 'Register',
                tombol: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                warna: Colors.blueAccent)
          ],
        ),
      ),
    );
  }
}
