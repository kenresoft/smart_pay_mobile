import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fontresoft/fontresoft.dart';
import 'package:smart_pay_mobile/screens/onboarding.dart';
import 'package:smart_pay_mobile/screens/sign_in.dart';
import 'package:smart_pay_mobile/services/sign_up_service.dart';

import '../services/prefs.dart';
import '../utils/routes.dart';
import 'otp.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController(text: emailAddress);

  String? loginMessage;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();
    page = RouteConstants.signUp;
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

  Future<void> signUp(String email, Function(bool, String) callback) async {
    final Map<String, dynamic> response = await SignUpService().authenticateEmail(email);

    if (response.containsKey('errors')) {
      final Map<String, dynamic> errors = response['errors'];
      if (errors.containsKey('email')) {
        showMessage(errors['email'][0]);
      }
      callback(false, errors['email'][0]);
    } else {
      if (response['status'] == true) {
        setState(() {
          token = response['data']['token'];
          isCodeSent = true;
          emailAddress = email;
        });
        callback(true, 'Token generated successfully!');
      } else {
        final errorMessage = response['message'];
        if (errorMessage == 'Too Many Attempts.') {
          showMessage(errorMessage);
          callback(false, errorMessage);
        } else {
          showMessage(errorMessage);
          callback(false, errorMessage);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;

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
                child: GestureDetector(
                  onTap: () =>
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Onboarding(),
                        ),
                      ),
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
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Create a ',
                        style: Font.sFProDisplay().copyWith(
                          color: const Color(0xFF111827),
                          fontSize: 27,
                          
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.20,
                        ),
                      ),
                      TextSpan(
                        text: 'Smartpay\n',
                        style: Font.sFProDisplay().copyWith(
                          color: const Color(0xFF0A6375),
                          fontSize: 27,
                          
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.20,
                        ),
                      ),
                      TextSpan(
                        text: 'account',
                        style: Font.sFProDisplay().copyWith(
                          color: const Color(0xFF111827),
                          fontSize: 27,
                          
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.20,
                        ),
                      ),
                    ],
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF9FAFB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Email',
                      hintStyle: Font.sFProDisplay().copyWith(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 19,
                        
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.30,
                      ),
                    ),
                    style: Font.sFProDisplay().copyWith(
                      color: const Color(0xFF111827),
                      fontSize: 21,
                      
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.30,
                    ),
                  ),
                ),
              ),

              /// Button
              Padding(
                padding: EdgeInsets.only(top: height * 0.03),
                child: GestureDetector(
                  onTap: () =>
                      signUp(emailController.text.trim(), (status, message) {
                        if (status) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OtpScreen(),
                            ),
                          );
                        } else {
                          debugPrint(message);
                        }
                      }),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sign In',
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

              Padding(
                padding: EdgeInsets.only(bottom: height * 0.01),
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 21,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 80,
                          child: Container(
                            height: 1,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.white, Color(0xFFE5E7EB)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [0, 1],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'OR',
                        textAlign: TextAlign.center,
                        style: Font.sFProDisplay().copyWith(
                          color: const Color(0xFF6B7280),
                          fontSize: 17,
                          
                          fontWeight: FontWeight.w400,
                          height: 0.11,
                          letterSpacing: 0.30,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          width: 80,
                          child: Container(
                            height: 1,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.white, Color(0xFFE5E7EB)],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                stops: [0, 1],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.026),
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: height * 0.07,
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFFE5E7EB)),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: SvgPicture.asset('assets/icons/google.svg', height: 30),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: height * 0.07,
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFFE5E7EB)),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const FaIcon(FontAwesomeIcons.apple, size: 34),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(vertical: height * 0.119),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignIn(),
                        ),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: Font.sFProDisplay().copyWith(
                              color: const Color(0xFF6B7280),
                              fontSize: 19,
                              
                              fontWeight: FontWeight.w400,
                              //height: 0.09,
                              letterSpacing: 0.30,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign In',
                            style: Font.sFProDisplay().copyWith(
                              color: const Color(0xFF0A6375),
                              fontSize: 19,
                              
                              fontWeight: FontWeight.w700,
                              //height: 0.09,
                              letterSpacing: 0.30,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
