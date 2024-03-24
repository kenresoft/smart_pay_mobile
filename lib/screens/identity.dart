import 'package:country_icons/country_icons.dart';
import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fontresoft/fontresoft.dart';
import 'package:smart_pay_mobile/screens/otp.dart';
import 'package:smart_pay_mobile/screens/pin.dart';
import 'package:smart_pay_mobile/services/identity_service.dart';

import '../services/prefs.dart';
import '../utils/routes.dart';
import '../widgets/country_selection_sheet.dart';

class Identity extends StatefulWidget {
  const Identity({super.key});

  @override
  State<Identity> createState() => _IdentityState();
}

class _IdentityState extends State<Identity> with TickerProviderStateMixin {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController(text: country);

  void _updateSelectedCountry() {
    setState(() {
      country = _countryController.text;
    });
  }

  final TextEditingController passwordController = TextEditingController();
  var obscureText = true;
  String? loginMessage;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();
    page = RouteConstants.identity;
    _countryController.addListener(_updateSelectedCountry);
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
    _countryController.dispose();
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

  void register(
    String fullName,
    String userName,
    String password,
    Function(bool status, String message) callback,
  ) async {
    final response = await IdentityService.registerUser(
      fullName: fullName,
      userName: userName,
      email: emailAddress,
      password: password,
      countryCode: countryCode.toString().toLowerCase(),
      deviceName: device,
    );

    if (response.containsKey('errors')) {
      final Map<String, dynamic> errors = response['errors'];
      if (errors.containsKey('full_name')) {
        showMessage(errors['full_name'][0]);
      }
      if (errors.containsKey('username')) {
        showMessage(errors['username'][0]);
      }
      if (errors.containsKey('email')) {
        showMessage(errors['email'][0]);
      }
      if (errors.containsKey('password')) {
        showMessage(errors['password'][0]);
      }
      if (errors.containsKey('country')) {
        showMessage(errors['country'][0]);
      }
      /// Not necessary
      /*if (errors.containsKey('device_name')) {
        showMessage(errors['device_name'][0]);
      }*/
    } else {
      if (response['status'] == true) {
        //final userData = response['data']['user'];
        //final token = response['data']['token'];
        callback(true, 'Registration successful!');
      } else {
        final errorMessage = response['message'];
        showMessage(errorMessage);
        callback(false, errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            height: height * 0.8,
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
                        builder: (context) => const OtpScreen(),
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
                          text: 'Hey there! tell us a bit \nabout ',
                          style: Font.sFProDisplay().copyWith(
                            color: const Color(0xFF111827),
                            fontSize: 27,

                            fontWeight: FontWeight.w700,
                            //height: 0.05,
                            letterSpacing: -0.20,
                          ),
                        ),
                        TextSpan(
                          text: 'yourself',
                          style: Font.sFProDisplay().copyWith(
                            color: const Color(0xFF0A6375),
                            fontSize: 27,

                            fontWeight: FontWeight.w700,
                            //height: 0.05,
                            letterSpacing: -0.20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Full Name TextField
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
                      controller: fullNameController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Full name',
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

                /// User Name TextField
                Padding(
                  padding: EdgeInsets.only(top: height * 0.025),
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
                      controller: userNameController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Username',
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

                /// Select Country TextField
                Padding(
                  padding: EdgeInsets.only(top: height * 0.025),
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
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CountrySelectionBottomSheet(
                              onCountrySelected: (country) {
                                _countryController.text = ''; // Clear the text to update the UI
                                Future.delayed(const Duration(milliseconds: 50), () {
                                  setState(() {
                                    countryCode = country.code;
                                    _countryController.text = country.name;
                                  });
                                });
                              },
                            );
                          },
                        );
                      },
                      readOnly: true,
                      controller: _countryController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: condition(
                          countryCode.isNotEmpty,
                          Container(
                            width: 48,
                            height: double.infinity,
                            padding: const EdgeInsets.all(8),
                            //child: CountryFlag.fromCountryCode(country, height: 30),
                            child: CountryIcons.getSvgFlag(countryCode),
                          ),
                          null,
                        ),
                        suffixIcon: const Icon(Icons.keyboard_arrow_down),
                        hintText: 'Select Country',
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

                /// Password TextField
                Padding(
                  padding: EdgeInsets.only(top: height * 0.025),
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

                /// Button
                Padding(
                  padding: EdgeInsets.only(top: height * 0.03),
                  child: GestureDetector(
                    onTap: () => register(
                      fullNameController.text,
                      userNameController.text,
                      passwordController.text,
                      (status, message) => conditionFunction(
                        status,
                        () {
                          fullName = fullNameController.text;
                          return Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PinScreen(),
                            ),
                          );
                        },
                        () => null,
                      ),
                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
