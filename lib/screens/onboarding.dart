import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            const SizedBox(height: 83),
            Container(
              width: 253,
              height: 359,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/onboard-image-1.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 38.44,
                    left: 11.42,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(-0.11),
                      child: Container(
                        width: 48.15,
                        height: 48.15,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x289BA3AF),
                              blurRadius: 25,
                              offset: Offset(-5, 10),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: SvgPicture.asset('assets/icons/fluent_shield.svg'),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 152,
                    left: 130,
                    child: Container(
                      width: 160,
                      height: 97.67,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.16),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0F6B727F),
                            blurRadius: 25,
                            offset: Offset(-15, 15),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 11.16, left: 12.09),
                            child: SizedBox(
                              width: 50.23,
                              height: 13.95,
                              child: Text(
                                'This month',
                                style: TextStyle(
                                  color: Color(0xFF111827),
                                  fontSize: 9.30,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w600,
                                  height: 0.16,
                                  letterSpacing: 0.28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 229.2,
                    child: Container(
                      width: 142,
                      height: 51,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x149BA3AF),
                            blurRadius: 25,
                            offset: Offset(-5, 10),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 11, left: 11),
                        child: SizedBox(
                          width: 50.23,
                          height: 13.95,
                          child: Text(
                            'This month',
                            style: TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 9.30,
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w600,
                              height: 0.16,
                              letterSpacing: 0.28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
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
            SizedBox(height: 34),
            Container(
              width: 287,
              height: 56,
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: Color(0xFF111827),
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
            )
          ],
        ),
      ),
    );
  }
}
