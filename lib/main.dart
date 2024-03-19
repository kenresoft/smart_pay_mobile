import 'package:flutter/material.dart';
import 'package:smart_pay_mobile/screens/onboarding.dart';
import 'package:smart_pay_mobile/screens/sign_in.dart';
import 'package:smart_pay_mobile/screens/sign_up.dart';
import 'package:smart_pay_mobile/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: const Color(0xff84CEFE),
        fontFamily: 'SFProDisplay',
        /*package: FontResoft.package,*/
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      routes: {
        //'/': (context) => const Home(),
        '/': (context) => const Splash(),
        '/onboarding': (context) => const Onboarding(),
        '/sign_up': (context) => const SignUp(),
        '/sign_in': (context) => const SignIn(),
      },
    );
  }
}
