import 'dart:async';
import 'dart:collection';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fontresoft/fontresoft.dart';
import 'package:smart_pay_mobile/screens/identity.dart';
import 'package:smart_pay_mobile/screens/sign_up.dart';
import 'package:smart_pay_mobile/services/prefs.dart';

import '../services/otp_service.dart';
import '../services/sign_up_service.dart';
import '../utils/routes.dart';
import '../widgets/custom_keyboard.dart';
import '../widgets/notification_dialog.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  final List<TextEditingController> controllers = List.generate(5, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(5, (index) => FocusNode());

  bool isInputComplete = false;
  bool isLoading = false;
  String loginMessage = '';

  late Timer _timer;
  bool _isResendClickable = false;

  int _secondsLeft = 30;

  int get secondsLeft => isCodeSent ? _secondsLeft : 0;

  set secondsLeft(int value) => _secondsLeft = value;

  final StreamController<String> _messageStreamController = StreamController<String>();
  final NotificationDialog _notificationDialog = NotificationDialog(messageQueue: Queue<String>());

  @override
  void initState() {
    super.initState();
    page = RouteConstants.otp;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _messageStreamController.close();
    super.dispose();
  }

  void _showMessageNotification(String message) {
    _messageStreamController.add(message);

    // Reset message after showing the notification
    Future.delayed(const Duration(seconds: 5), () {
      _messageStreamController.add('');
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
        });
      } else {
        setState(() {
          _isResendClickable = true;
        });
        _timer.cancel();
      }
    });
  }

  Future<void> _resendCode() async {
    if (_isResendClickable) {
      final Map<String, dynamic> response = await SignUpService().authenticateEmail(emailAddress);

      if (response.containsKey('error')) {
        setState(() {
          loginMessage = response['error'];
          debugPrint(loginMessage);
        });
      } else {
        final bool status = response['status'];
        final String message = response['message'];
        final Map<String, dynamic> data = response['data'];

        if (status) {
          // Successful authentication
          setState(() {
            token = data['token'];
          });

          setState(() {
            loginMessage = status.toString();
          });
        } else {
          final String errorMessage = message.isNotEmpty ? message : 'Authentication failed';
          setState(() {
            loginMessage = errorMessage;
          });
          debugPrint(loginMessage);
        }
      }
      _isResendClickable = false;
      secondsLeft = 30;
      _startTimer();
    }
  }

  String getCombinedOtp() {
    String combinedOtp = '';
    for (var controller in controllers) {
      combinedOtp += controller.text.trim();
    }
    debugPrint(combinedOtp);
    return combinedOtp;
  }

  void handleKeyInput(String key) {
    if (key == 'delete') {
      // Handle delete button press
      for (int i = controllers.length - 1; i >= 0; i--) {
        if (controllers[i].text.isNotEmpty) {
          controllers[i].text = '';
          if (i >= 0) {
            FocusScope.of(context).requestFocus(focusNodes[i]);
          }
          break;
        }
      }
    } else {
      int emptyIndex = controllers.indexWhere((controller) => controller.text.isEmpty);
      if (emptyIndex != -1) {
        controllers[emptyIndex].text = key;
        if (emptyIndex + 1 < controllers.length) {
          FocusScope.of(context).requestFocus(focusNodes[emptyIndex + 1]);
        }
      }
    }

    setState(() {
      isInputComplete = controllers.every((controller) => controller.text.isNotEmpty);
    });
  }

  Future<void> authenticateUser(String token, Function(bool, String) callback) async {
    setState(() {
      isLoading = true;
    });

    final response = await OtpService().getToken(emailAddress, token);

    if (response.containsKey('errors')) {
      final Map<String, dynamic> errors = response['errors'];
      if (errors.containsKey('token')) {
        _showMessageNotification(errors['token'][0]);
      }
      callback(false, errors['token'][0]);
    } else {
      if (response['status'] == true) {
        //final token = response['data']['token']; // Returned by API but not needed.
        _showMessageNotification('Token verified successfully!');
        callback(true, 'Token verified successfully!');
        setState(() {
          isLoading = false;
        });
      } else {
        final errorMessage = response['message'];
        _showMessageNotification(errorMessage);
        callback(false, errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    debugPrint('$emailAddress - $token');
    _showMessageNotification(token);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
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
                    padding: EdgeInsets.only(bottom: height * 0.005),
                    child: AnimatedTextKit(
                      pause: const Duration(seconds: 1),
                      displayFullTextOnTap: true,
                      animatedTexts: [
                        TyperAnimatedText(
                          'Verify it’s you',
                          textStyle: Font.sFProDisplay().copyWith(
                            color: const Color(0xFF111827),
                            fontSize: 27,
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
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'We send a code to ( ',
                            style: Font.sFProDisplay().copyWith(
                              color: const Color(0xFF6B7280),
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.30,
                            ),
                          ),
                          TextSpan(
                            text: '*****@mail.com ',
                            style: Font.sFProDisplay().copyWith(
                              color: const Color(0xFF111827),
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.30,
                            ),
                          ),
                          TextSpan(
                            text: '). Enter it here to verify your identity',
                            style: Font.sFProDisplay().copyWith(
                              color: const Color(0xFF6B7280),
                              fontSize: 19,

                              fontWeight: FontWeight.w400,
                              //height: 0.09,
                              letterSpacing: 0.30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// TextField
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.01),
                    child: Container(
                      width: width,
                      height: height * 0.067,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int i = 0; i < controllers.length; i++)
                            Container(
                              width: height * 0.067,
                              clipBehavior: Clip.antiAlias,
                              margin: i <= 3 ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(right: 0),
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF9FAFB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: TextFormField(
                                controller: controllers[i],
                                focusNode: focusNodes[i],
                                maxLength: 1,
                                keyboardType: TextInputType.none,
                                onChanged: (value) {
                                  if (value.length > 1) {
                                    controllers[i].text = value.substring(0, 1);
                                  }
                                },
                                style: Font.sFProDisplay().copyWith(
                                  color: const Color(0xFF111827),
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.30,
                                ),
                                showCursor: false,
                                decoration: InputDecoration(
                                  counter: const Offstage(),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Color(0x00000000)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Color(0xFF2FA2B9)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () => _isResendClickable ? _resendCode() : null,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: height * 0.05, bottom: height * 0.04),
                      child: Text(
                        'Resend Code ${secondsLeft.toString().padLeft(2, '0')} secs',
                        textAlign: TextAlign.center,
                        style: Font.sFProDisplay().copyWith(
                          color: !_isResendClickable ? const Color(0xFF717171) : const Color(0xFF111827),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ),
                  ),

                  // Button to authenticate user
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.01),
                    child: GestureDetector(
                      onTap: () {
                        authenticateUser(getCombinedOtp(), (success, message) {
                          conditionFunction(
                            success,
                            () {
                              isCodeSent = false;
                              return Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const Identity()),
                              );
                            },
                            () => null,
                          );
                        });
                      },
                      child: Container(
                        width: width,
                        height: height * 0.07,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: isInputComplete ? const Color(0xFF111827) : const Color(0xFF111827).withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Confirm',
                          textAlign: TextAlign.center,
                          style: Font.sFProDisplay().copyWith(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: height * 0.01),
                    child: CustomKeyboard(onKeyPressed: handleKeyInput),
                  ),
                ],
              ),
            ),
            StreamBuilder<String>(
              stream: _messageStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
                  // Add the message to the messageQueue of NotificationDialog
                  _notificationDialog.messageQueue.add(snapshot.data!);
                  return Positioned(
                    top: 50,
                    child: NotificationDialog(messageQueue: _notificationDialog.messageQueue),
                  );
                } else {
                  return Container(); // Return an empty container if no message is available
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
