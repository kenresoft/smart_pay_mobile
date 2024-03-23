import 'dart:async';
import 'dart:collection';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_pay_mobile/screens/sign_in.dart';

import '../services/prefs.dart';
import '../utils/routes.dart';
import '../widgets/custom_keyboard.dart';
import '../widgets/notification_dialog.dart';
import 'confirmation.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> with TickerProviderStateMixin {
  final List<TextEditingController> controllers = List.generate(5, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(5, (index) => FocusNode());

  bool isInputComplete = false;
  bool isLoading = false;
  bool isSecondTrial = false;

  int attemptCounter = 0;
  bool isSuccessful = false;

  String? previousPin;
  String? currentPin;

  Timer? _timer;
  int _countdown = 10;

  final StreamController<String> _messageStreamController = StreamController<String>();
  final NotificationDialog _notificationDialog = NotificationDialog(messageQueue: Queue<String>());

  @override
  void initState() {
    super.initState();
    page = RouteConstants.pin;
    previousPin = '';
    currentPin = '';

    print(isSignedIn);

    for (int i = 0; i < controllers.length; i++) {
      controllers[i].addListener(() {
        setState(() {
          // Check if all text fields are filled
          if (!isSuccessful) {
            isInputComplete = controllers.every((controller) => controller.text.isNotEmpty);
          }
          if (!isSignedIn) {
            if (isInputComplete) {
              String combinedOtp = getCombinedOtp();
              if (currentPin!.isEmpty && previousPin!.isEmpty) {
                previousPin = combinedOtp;
                currentPin = '';
                _showMessageNotification('Please re-enter your PIN to confirm');
                resetInputs();
                isSecondTrial = true;
              } else if (previousPin == combinedOtp && isSecondTrial) {
                currentPin = combinedOtp;
                _showMessageNotification('Pin matched');
                isSuccessful = true;
                isInputComplete = true;
              } else if (previousPin != combinedOtp && isSecondTrial) {
                // Notify user to enter PIN again
                _showMessageNotification('PINs do not match. Please enter your PIN again');
                _restartPinEntry();
                // Increment attempt counter
                attemptCounter++;
              } else {
                _restartPinEntry();
                // Increment attempt counter
                attemptCounter++;
              }

              if (attemptCounter >= 3) {
                // Disable further trials after three attempts
                isSecondTrial = false;
                _showMessageNotification('You have reached the maximum number of attempts');
                resetInputs();
                startTimer();
              }
              print('previous$previousPin');
              print('current$currentPin');
            } else {
              // Nothing to do here
            }
          }
        });
      });
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          timer.cancel();
          _timer?.cancel();
          setState(() {
            _countdown = 10;
            previousPin = '';
            currentPin = '';
            attemptCounter = 0;
            _showMessageNotification('You can now enter your PIN again');
          });
        }
      });
    });
  }

  void resetInputs() {
    for (var controller in controllers) {
      controller.clear();
    }
    for (var focus in focusNodes) {
      focus.unfocus();
    }
  }

  void _restartPinEntry() {
    previousPin = '';
    currentPin = '';
    resetInputs();
    isSecondTrial = false;
  }

  @override
  void dispose() {
    _messageStreamController.close();
    _timer?.cancel();
    super.dispose();
  }

  void _showMessageNotification(String message) {
    _messageStreamController.add(message);

    // Reset message after showing the notification
    Future.delayed(const Duration(seconds: 5), () {
      _messageStreamController.add('');
    });
  }

  String getCombinedOtp() {
    String combinedOtp = '';
    for (var controller in controllers) {
      combinedOtp += controller.text.trim();
    }
    print(combinedOtp);
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
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.06),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.051, bottom: height * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
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
                        attemptCounter >= 3
                            ? Text(
                                '$_countdown sec remaining',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.005),
                    child: AnimatedTextKit(
                      pause: const Duration(seconds: 1),
                      displayFullTextOnTap: true,
                      animatedTexts: [
                        TyperAnimatedText(
                          !isSignedIn ? 'Set your PIN code' : 'Enter your PIN code',
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
                      'We use state-of-the-art security measures to protect your information at all times',
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
                    padding: EdgeInsets.only(top: height * 0.038),
                    child: Container(
                      width: width,
                      height: height * 0.067,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int i = 0; i < controllers.length; i++)
                            Container(
                              width: height * 0.067,
                              margin: i <= 3 ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(right: 0),
                              child: TextFormField(
                                obscureText: true,
                                obscuringCharacter: '●',
                                controller: controllers[i],
                                focusNode: focusNodes[i],
                                maxLength: 1,
                                keyboardType: TextInputType.none,
                                onChanged: (value) {
                                  if (value.length > 1) {
                                    controllers[i].text = value.substring(0, 1);
                                  }
                                },
                                style: const TextStyle(
                                  color: Color(0xFF111827),
                                  fontSize: 17,
                                  fontFamily: 'SFProDisplay',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.30,
                                ),
                                showCursor: true,
                                cursorColor: const Color(0xff2FA2B9),
                                decoration: InputDecoration(
                                  counter: const Offstage(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Color(0xFF0A6375)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Color(0xFF0A6375)),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  /// Button to authenticate user
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.09),
                    child: GestureDetector(
                      onTap: () {
                        if (isSignedIn) {
                          if (getCombinedOtp() == pin) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const Confirmation()),
                            );
                          } else {
                            _showMessageNotification('Incorrect PIN!');
                          }
                        } else {
                          if (isInputComplete && previousPin == currentPin) {
                            pin = currentPin!;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const Confirmation()),
                            );
                          }
                        }
                      },
                      child: Container(
                        width: width,
                        height: height * 0.071,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: isInputComplete && previousPin == currentPin ? const Color(0xFF111827) : const Color(0xFF111827).withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Confirm',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: height * 0.02),
                    child: CustomKeyboard(onKeyPressed: attemptCounter >= 3 ? (_) {} : handleKeyInput),
                  ),
                ],
              ),
            ),
            /*StreamBuilder<String>(
              stream: _messageStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
                  return Positioned(
                    top: 50,
                    child: NotificationDialog(message: snapshot.data!),
                  );
                } else {
                  return Container(); // Return an empty container if no message is available
                }
              },
            ),*/
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
