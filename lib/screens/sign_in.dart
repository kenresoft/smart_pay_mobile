import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_pay_mobile/screens/pin.dart';
import 'package:smart_pay_mobile/screens/sign_up.dart';

import '../services/prefs.dart';
import '../services/sign_in_service.dart';
import '../utils/routes.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? loginMessage;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();
    page = RouteConstants.signIn;
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

  void login() async {
    // Clear any previous error message
    clearError();

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    final response = await SignInService.signIn(
      email: email,
      password: password,
      deviceName: device,
    );

    if (response.containsKey('errors')) {
      final Map<String, dynamic> errors = response['errors'];
      if (errors.containsKey('email')) {
        showMessage(errors['email'][0]);
      }
      if (errors.containsKey('password')) {
        showMessage(errors['password'][0]);
      }

      /// Not necessary
      /*if (errors.containsKey('device_name')) {
        showMessage(errors['device_name'][0]);
      }*/

      //callback(false, loginMessage!, null, null);
    } else {
      if (response['status'] == true) {
        final userData = response['data']['user'];
        final token = response['data']['token'];
        final userId = userData['id'];
        fullName = userData['full_name'];
        //callback(true, 'Sign in successful!', userId, token);
        Future.delayed(const Duration(milliseconds: 3000), () {
          // Navigate to the next screen after animations complete
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PinScreen(),
            ),
          );
        });
      } else {
        final errorMessage = response['message'];
        showMessage(errorMessage ?? 'Error');
        //callback(false, errorMessage, null, null);
      }
    }
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

  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.051),
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
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
                padding: EdgeInsets.only(/*top: height * 0.029, */ bottom: height * 0.005),
                child: AnimatedTextKit(
                  pause: const Duration(seconds: 1),
                  displayFullTextOnTap: true,
                  animatedTexts: [
                    TyperAnimatedText(
                      'Hi There! 👋',
                      textStyle: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 27,
                        fontFamily: 'SFProDisplay',
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
                child: const Text(
                  'Welcome back, Sign in to your account',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 19,
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w400,
                    //height: 0.09,
                    letterSpacing: 0.30,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.054, bottom: height * 0.019),
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 19,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.30,
                      ),
                    ),
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 21,
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.04),
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
                    obscureText: obscureText,
                    obscuringCharacter: '●',
                    controller: passwordController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
                        onPressed: () {
                          setState(() => obscureText = !obscureText);
                        },
                      ),
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
                      fontSize: 24,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, RouteConstants.passwordRecovery);
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: height * 0.004),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFF0A6375),
                      fontSize: 19,
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.03),
                child: GestureDetector(
                  onTap: login,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: height * 0.071,
                    padding: const EdgeInsets.all(8),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF111827),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sign In',
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

              //  demo@demo.com Dopheus22

              // Animated widgets for success message
              Container(
                height: height * 0.04,
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
                          //speed: const Duration(milliseconds: 100),
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
                  width: MediaQuery.of(context).size.width,
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
                      const Text(
                        'OR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 17,
                          fontFamily: 'SFProDisplay',
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
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
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
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(vertical: height * 0.035),
                  child: GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ),
                    ),
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don’t have an account? ',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 19,
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.w400,
                              //height: 0.09,
                              letterSpacing: 0.30,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF0A6375),
                              fontSize: 19,
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.w600,
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
