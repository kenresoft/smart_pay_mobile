import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fontresoft/fontresoft.dart';
import 'package:smart_pay_mobile/utils/utils.dart';

import '../services/prefs.dart';
import '../utils/routes.dart';

class VerifyIdentity extends StatefulWidget {
  const VerifyIdentity({super.key});

  @override
  State<VerifyIdentity> createState() => _VerifyIdentityState();
}

class _VerifyIdentityState extends State<VerifyIdentity> with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController(text: verificationEmailAddress);

  String? loginMessage;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();
    page = RouteConstants.verifyIdentity;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
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
                          child: SvgPicture.asset('assets/icons/person_print.svg'),
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
                            'Verify your identity',
                            textStyle: Font.sFProDisplay().copyWith(
                              color: const Color(0xFF111827),
                              fontSize: 27,
                              
                              fontWeight: FontWeight.w700,
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
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Where would you like ',
                              style: Font.sFProDisplay().copyWith(
                                color: const Color(0xFF6B7280),
                                fontSize: 19,
                                
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.30,
                              ),
                            ),
                            TextSpan(
                              text: 'Smartpay',
                              style: Font.sFProDisplay().copyWith(
                                color: const Color(0xFF0A6375),
                                fontSize: 19,
                                
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.30,
                              ),
                            ),
                            TextSpan(
                              text: ' to send your security code?',
                              style: Font.sFProDisplay().copyWith(
                                color: const Color(0xFF6B7280),
                                fontSize: 19,
                                
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      height: height * 0.1,
                      margin: EdgeInsets.only(top: height * 0.038),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF9FAFB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const ShapeDecoration(
                                          color: Color(0xFF0A6375),
                                          shape: OvalBorder(),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 18),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Email',
                                    style: Font.sFProDisplay().copyWith(
                                      color: const Color(0xFF111827),
                                      fontSize: 18,
                                      
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.30,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    getEmail ?? 'Email is not valid',
                                    style: Font.sFProDisplay().copyWith(
                                      color: const Color(0xFF6B7280),
                                      fontSize: 14,
                                      
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                            child: const Icon(
                              Icons.email_outlined,
                              color: Color(0xff9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// Button
              GestureDetector(
                onTap: () {
                  conditionFunction(
                    getEmail != null,
                    () => Navigator.pushNamed(context, RouteConstants.resetPassword),
                    () => null,
                  );
                },
                child: Container(
                  width: width,
                  height: height * 0.071,
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: getEmail != null ? const Color(0xFF111827) : Colors.grey,
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
                        'Continue',
                        textAlign: TextAlign.center,
                        style: Font.sFProDisplay().copyWith(
                          color: Colors.white,
                          fontSize: 19,
                          
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ],
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
                          style: Font.sFProDisplay().copyWith(
                            color: Colors.green,
                            fontSize: 18,
                            
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

  String? get getEmail => Utils.maskEmail(verificationEmailAddress);
}
