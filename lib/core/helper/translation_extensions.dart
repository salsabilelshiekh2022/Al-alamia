import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

extension TranslationExtension on BuildContext {
  String get login => tr('login');
  String get alalamia => tr('alalamia');
  String get phone => tr('phone');
  String get phoneHint => tr('phone_hint');
  String get password => tr('password');
  String get passwordHint => tr('password_hint');
  String get forgotPassword => tr('forgot_password');
  String get loginButton => tr('login_button');
  String get noAccount => tr('no_account');
  String get createAccount => tr('create_account');
}
