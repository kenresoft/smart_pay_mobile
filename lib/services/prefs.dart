import 'package:extensionresoft/extensionresoft.dart';
import 'package:smart_pay_mobile/utils/constants.dart';
import 'package:smart_pay_mobile/utils/routes.dart';

//
String get emailAddress => SharedPreferencesService.getString('emailAddress') ?? Constants.empty;

set emailAddress(String value) => SharedPreferencesService.setString('emailAddress', value);

//
String get verificationEmailAddress => SharedPreferencesService.getString('verificationEmailAddress') ?? Constants.empty;

set verificationEmailAddress(String value) => SharedPreferencesService.setString('verificationEmailAddress', value);

//
String get token => SharedPreferencesService.getString('token') ?? Constants.empty;

set token(String value) => SharedPreferencesService.setString('token', value);

//
String get page => SharedPreferencesService.getString('page') ?? RouteConstants.onboarding;

set page(String value) => SharedPreferencesService.setString('page', value);

//
bool get isCodeSent => SharedPreferencesService.getBool('isCodeSent') ?? false;

set isCodeSent(bool value) => SharedPreferencesService.setBool('isCodeSent', value);

//
String get country => SharedPreferencesService.getString('country') ?? Constants.empty;

set country(String value) => SharedPreferencesService.setString('country', value);

//
String get countryCode => SharedPreferencesService.getString('countryCode') ?? Constants.empty;

set countryCode(String value) => SharedPreferencesService.setString('countryCode', value);

//
String get fullName => SharedPreferencesService.getString('fullName') ?? Constants.empty;

set fullName(String value) => SharedPreferencesService.setString('fullName', value);

//
String get userName => SharedPreferencesService.getString('userName') ?? Constants.empty;

set userName(String value) => SharedPreferencesService.setString('userName', value);

//
String get device => SharedPreferencesService.getString('device') ?? Constants.empty;

set device(String value) => SharedPreferencesService.setString('device', value);

//
String get pin => SharedPreferencesService.getString('pin') ?? Constants.empty;

set pin(String value) => SharedPreferencesService.setString('pin', value);

//
bool get isSignedIn => SharedPreferencesService.getBool('isSignedIn') ?? false;

set isSignedIn(bool value) => SharedPreferencesService.setBool('isSignedIn', value);
