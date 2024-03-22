import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay_mobile/screens/sign_in.dart';

import '../services/prefs.dart';
import '../utils/routes.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();

  String? loginMessage;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();
    page = RouteConstants.passwordRecovery;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _slideInAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void clearError() {
    setState(() {
      loginMessage = null;
    });
  }

  void showMessage(String message) {
    setState(() {
      loginMessage = message;
      _animationController.forward(from: 0.0);
    });
    // Hide the message after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      clearError();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          height: height,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.051, bottom: height * 0.04),
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.046),
                  child: Container(
                    width: 72,
                    height: 72,
                    padding: const EdgeInsets.all(15),
                    decoration: const ShapeDecoration(
                      color: Color(0xFFF9FAFB),
                      shape: OvalBorder(),
                    ),
                    child: SvgPicture.asset('assets/icons/lock_closed.svg'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.005),
                child: AnimatedTextKit(
                  pause: const Duration(seconds: 1),
                  displayFullTextOnTap: true,
                  animatedTexts: [
                    TyperAnimatedText(
                      'Password Recovery',
                      textStyle: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 27,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.20,
                      ),
                      speed: const Duration(milliseconds: 100),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.02),
                child: const Text(
                  'Enter your registered email below to receive password instructions',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 19,
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.30,
                  ),
                ),
              ),

              /// TextField
              Padding(
                padding: EdgeInsets.only(top: height * 0.054),
                child: Container(
                  width: width,
                  height: height * 0.067,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xffF9FAFB),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xff2FA2B9),
                          width: 1,
                        ),
                      ),
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 19,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.30,
                      ),
                    ),
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 20,
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.30,
                    ),
                  ),
                ),
              ),

              /// Button
              Padding(
                padding: EdgeInsets.only(top: height * 0.03),
                child: GestureDetector(
                  onTap: () {
                    verificationEmailAddress = emailController.text.trim();
                    Navigator.pushNamed(context, RouteConstants.verifyIdentity);
                  },
                  child: Container(
                    width: width,
                    height: height * 0.071,
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
                          'Send me email',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Animated widgets for success message
              Container(
                height: height * 0.05,
                alignment: Alignment.bottomCenter,
                child: AnimatedBuilder(
                  builder: (context, _) {
                    return FadeTransition(
                      opacity: _fadeInAnimation,
                      child: SlideTransition(
                        position: _slideInAnimation,
                        child: Text(
                          loginMessage ?? '',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                  animation: _animationController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
