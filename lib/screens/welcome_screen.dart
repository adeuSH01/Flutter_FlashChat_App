import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id =
      'welcome_screen'; // when we use static key word here, dart will give us an alarm when we use welcome screen wrong.

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync:
          this, // ticker provider. it is a required property for the animations. this = use this class's object and connect with it.
      duration: Duration(seconds: 1),
    );

    //animation = ColorTween(begin: Colors.red, end: Colors.blue).animate(controller); // ekranın rengi hızlıca değişiyor belirlediğimiz 2 renk arasında.

    animation = CurvedAnimation(
        parent: controller,
        curve: Curves
            .decelerate); // when using a curve, the upperbound needs to be -1.0.
    // parent = animation controller, what we apply to.
    controller
        .forward(); // an animation value is the third requirement for animations. forward = küçükten büyüğe. reverse = büyükten küçüğe.

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value *
                        100, // bunun sayesinde logomuz küçücük olacak ve bir anda büyüyerek ekrana gelecek.
                  ),
                ),
                // '${controller.value.toInt()}%', = ekrana %100 e kadar sayaç gibi bir şey getirdi.
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(97, 97, 97, 1),
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('FLASH CHAT'),
                    ],
                    isRepeatingAnimation: true,
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              colour: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
