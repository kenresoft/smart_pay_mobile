import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_pay_mobile/services/prefs.dart';
import 'package:smart_pay_mobile/utils/utils.dart';

import '../utils/routes.dart';
import '../widgets/action_dialog.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({super.key});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {

  @override
  void initState() {
    super.initState();
    page = RouteConstants.pin;
    isSignedIn = true;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.323,
                height: height * 0.140,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: height * 0.031,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(-0.16),
                        child: Container(
                          width: width * 0.26,
                          height: height * 0.120,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/thumbs_up.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      width: width * 0.032,
                      top: height * 0.021,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(0.26),
                        child: Container(
                          width: width * 0.0313,
                          height: height * 0.016,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFFFB300),
                            shape: StarBorder(
                              points: 5,
                              innerRadiusRatio: 0.38,
                              pointRounding: 0,
                              valleyRounding: 0,
                              rotation: 0,
                              squash: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: width * 0.293,
                      top: height * 0.05,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(-0.26),
                        child: Container(
                          width: width * 0.0313,
                          height: height * 0.016,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFFFB300),
                            shape: StarBorder(
                              points: 5,
                              innerRadiusRatio: 0.38,
                              pointRounding: 0,
                              valleyRounding: 0,
                              rotation: 0,
                              squash: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: width * 0.23,
                      top: 0,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(0.19),
                        child: Container(
                          width: width * 0.065,
                          height: height * 0.03,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFFFB300),
                            shape: StarBorder(
                              points: 5,
                              innerRadiusRatio: 0.38,
                              pointRounding: 0,
                              valleyRounding: 0,
                              rotation: 0,
                              squash: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.035),
              SizedBox(
                width: width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Congratulations, ${Utils.getFirstName(fullName)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 29,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.20,
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    SizedBox(
                      width: width,
                      child: const Text(
                        'You’ve completed the onboarding, \nyou can start using',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 20,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.035),
              GestureDetector(
                onTap: () {
                  //page = RouteConstants.onboarding;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomDialog();
                    },
                  ).then((value) {
                    if (value != null) {
                      if (value) {
                        SharedPreferencesService.clear();
                      } else {
                        Navigator.pop(context);
                        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                      }
                    }
                  });

                },
                child: Container(
                  width: width * 0.85,
                  height: height * 0.07,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF111827),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
