import 'package:flutter/material.dart';
import 'package:fontresoft/fontresoft.dart';
import 'package:smart_pay_mobile/screens/sign_up.dart';
import 'package:smart_pay_mobile/utils/routes.dart';

import '../services/prefs.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  @override
  void initState() {
    super.initState();
    page = RouteConstants.onboarding;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    debugPrint('width: $width, height: $height');

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: const Color(0xFFF9FAFB),
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(top: height * 0.074, right: 24),
              child: GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUp(),
                  ),
                ),
                child: Text(
                  'Skip',
                  textAlign: TextAlign.right,
                  style: Font.sFProDisplay().copyWith(
                    color: const Color(0xFF2FA2B9),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.30,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.1026),
            Container(
              width: width * 0.75,
              height: height * 0.369,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/onboard_image_1.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.072),
              child: SizedBox(
                width: width * 0.8,
                child: Text(
                  'Finance app the safest and most trusted',
                  style: Font.sFProDisplay().copyWith(
                    color: const Color(0xFF111827),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: height * 0.025),
            SizedBox(
              width: width * 0.8,
              child: Text(
                'Your finance work starts here. Our here to help you track and deal with speeding up your transactions.',
                textAlign: TextAlign.center,
                style: Font.sFProDisplay().copyWith(
                  color: const Color(0xFF6B7280),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.30,
                ),
              ),
            ),
            SizedBox(height: height * 0.025),
            Container(
              width: 32,
              height: 6,
              decoration: ShapeDecoration(
                color: const Color(0xFF111827),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(500),
                ),
              ),
            ),
            SizedBox(height: height * 0.04),
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUp(),
                ),
              ),
              child: Container(
                width: 287,
                height: height * 0.058,
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: const Color(0xFF111827),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Get Started',
                      textAlign: TextAlign.center,
                      style: Font.sFProDisplay().copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.30,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
