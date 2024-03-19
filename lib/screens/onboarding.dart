import 'package:flutter/material.dart';
import 'package:smart_pay_mobile/screens/sign_in.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(top: 68, right: 24),
              child: const Text(
                'Skip',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF2FA2B9),
                  fontSize: 16,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                  letterSpacing: 0.30,
                ),
              ),
            ),
            const SizedBox(height: 123),
            Container(
              width: double.infinity,
              height: 359,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/onboard-image-1.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: SizedBox(
                width: 287,
                child: Text(
                  'Finance app the safest and most trusted',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 24,
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w600,
                    //height: 0.05,
                    //letterSpacing: -0.20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(
              width: 287,
              child: Text(
                'Your finance work starts here. Our here to help you track and deal with speeding up your transactions.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  //height: 0.11,
                  letterSpacing: 0.30,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 32,
              height: 6,
              decoration: ShapeDecoration(
                color: Color(0xFF111827),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(500),
                ),
              ),
            ),
            const SizedBox(height: 34),
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignIn(),
                ),
              ),
              child: Container(
                width: 287,
                height: 56,
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: const Color(0xFF111827),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Get Started',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w700,
                        height: 0.09,
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
