import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fontresoft/fontresoft.dart';

import '../services/prefs.dart';
import '../utils/routes.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> with TickerProviderStateMixin {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  var obscurePasswordText = true;
  var obscureConfirmPasswordText = true;
  String? loginMessage;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();
    page = RouteConstants.resetPassword;
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(context, RouteConstants.passwordRecovery),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.051),
                        child: Container(
                          width: height * 0.048,
                          height: height * 0.048,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFFE5E7EB)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Icon(CupertinoIcons.chevron_left),
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
                            'Create New Password',
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
                      child: Text(
                        'Please, enter a new password below different from the previous password',
                        style: Font.sFProDisplay().copyWith(
                          color: const Color(0xFF6B7280),
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ),

                    /// TextField
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.054),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: height * 0.067,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: height * 0.008),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF9FAFB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: TextField(
                          obscureText: obscurePasswordText,
                          obscuringCharacter: '●',
                          controller: passwordController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureConfirmPasswordText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                                color: const Color(
                                  0xff6B7280,
                                ),
                              ),
                              onPressed: () {
                                setState(() => obscurePasswordText = !obscurePasswordText);
                              },
                            ),
                            hintStyle: Font.sFProDisplay().copyWith(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.30,
                            ),
                          ),
                          style: Font.sFProDisplay().copyWith(
                            color: const Color(0xFF111827),
                            fontSize: 24,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.024),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: height * 0.067,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: height * 0.008),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF9FAFB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: TextField(
                          obscureText: obscureConfirmPasswordText,
                          obscuringCharacter: '●',
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureConfirmPasswordText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                                color: const Color(
                                  0xff6B7280,
                                ),
                              ),
                              onPressed: () {
                                setState(() => obscureConfirmPasswordText = !obscureConfirmPasswordText);
                              },
                            ),
                            hintStyle: Font.sFProDisplay().copyWith(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.30,
                            ),
                          ),
                          style: Font.sFProDisplay().copyWith(
                            color: const Color(0xFF111827),
                            fontSize: 24,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Button
              Padding(
                padding: EdgeInsets.only(top: height * 0.03),
                child: GestureDetector(
                  onTap: () {
                    verificationEmailAddress = confirmPasswordController.text.trim();
                    Navigator.pushNamed(context, RouteConstants.signIn);
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Create new password',
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
}
