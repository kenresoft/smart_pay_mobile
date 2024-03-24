import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/material.dart';
import 'package:fontresoft/fontresoft.dart';
import 'package:smart_pay_mobile/screens/confirmation.dart';
import 'package:smart_pay_mobile/screens/identity.dart';
import 'package:smart_pay_mobile/screens/onboarding.dart';
import 'package:smart_pay_mobile/screens/otp.dart';
import 'package:smart_pay_mobile/screens/password_recovery.dart';
import 'package:smart_pay_mobile/screens/pin.dart';
import 'package:smart_pay_mobile/screens/reset_password.dart';
import 'package:smart_pay_mobile/screens/sign_in.dart';
import 'package:smart_pay_mobile/screens/sign_up.dart';
import 'package:smart_pay_mobile/screens/splash.dart';
import 'package:smart_pay_mobile/screens/verify_identity.dart';
import 'package:smart_pay_mobile/services/prefs.dart';
import 'package:smart_pay_mobile/utils/constants.dart';
import 'package:smart_pay_mobile/utils/routes.dart';
import 'package:smart_pay_mobile/utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  final deviceName = await Utils.getDeviceName();
  device = deviceName?? Constants.unknownDevice;
  debugPrint(deviceName);
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
        fontFamily: FontResoft.sFProText,
        package: FontResoft.package,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      routes: {
        //RouteConstants.splash: (context) => const Splash(),
        RouteConstants.splash: (context) => const Splash(),
        RouteConstants.onboarding: (context) => const Onboarding(),
        RouteConstants.signUp: (context) => const SignUp(),
        RouteConstants.signIn: (context) => const SignIn(),
        RouteConstants.otp: (context) => const OtpScreen(),
        RouteConstants.identity: (context) => const Identity(),
        RouteConstants.pin: (context) => const PinScreen(),
        RouteConstants.confirmation: (context) => const Confirmation(),
        RouteConstants.passwordRecovery: (context) => const PasswordRecovery(),
        RouteConstants.verifyIdentity: (context) => const VerifyIdentity(),
        RouteConstants.resetPassword: (context) => const ResetPassword(),
      },
    );
  }
}
