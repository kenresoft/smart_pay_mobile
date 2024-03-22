import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_pay_mobile/utils/constants.dart';
import 'package:smart_pay_mobile/utils/routes.dart';

import '../services/prefs.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
      () => Navigator.pushReplacementNamed(context, page == Constants.empty ? RouteConstants.onboarding : page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width /*148*/,
          height: MediaQuery.of(context).size.height /*130*/,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png'),
              const SizedBox(height: 20),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Smart',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 32,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w600,
                        height: 0.04,
                      ),
                    ),
                    TextSpan(
                      text: 'pay.',
                      style: TextStyle(
                        color: Color(0xFF0A6375),
                        fontSize: 32,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w600,
                        height: 0.04,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
