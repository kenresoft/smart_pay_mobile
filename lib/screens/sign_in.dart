import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 56),
                child: Container(
                  width: 45,
                  height: 45,
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Hi There! 👋',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 24,
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w600,
                    height: 0.05,
                    letterSpacing: -0.20,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Welcome back, Sign in to your account',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 16,
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w400,
                    height: 0.09,
                    letterSpacing: 0.30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 24),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: Color(0xFFF9FAFB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 16,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w400,
                        //height: 0.09,
                        letterSpacing: 0.30,
                      ),
                    ),
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w600,
                      //height: 0.09,
                      letterSpacing: 0.30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF9FAFB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 16,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w400,
                        //height: 0.09,
                        letterSpacing: 0.30,
                      ),
                    ),
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w600,
                      //height: 0.09,
                      letterSpacing: 0.30,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Color(0xFF0A6375),
                    fontSize: 16,
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w600,
                    height: 0.09,
                    letterSpacing: 0.30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w700,
                          height: 0.09,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 24),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 21,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 80,
                          child: Divider(thickness: 1, color: Color(0xFFE5E7EB)),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'OR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w400,
                          height: 0.11,
                          letterSpacing: 0.30,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          width: 80,
                          child: Divider(thickness: 1, color: Color(0xFFE5E7EB)),
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
                  height: 56,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 56,
                          padding: const EdgeInsets.all(8),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFFE5E7EB)),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Icon(Icons.facebook),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 56,
                          padding: const EdgeInsets.all(8),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFFE5E7EB)),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Icon(Icons.apple),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don’t have an account? ',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 16,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w400,
                            height: 0.09,
                            letterSpacing: 0.30,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Color(0xFF0A6375),
                            fontSize: 16,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w600,
                            height: 0.09,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
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
