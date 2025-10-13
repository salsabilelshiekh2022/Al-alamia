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
  String get createNewAccount => tr('create_new_account');
  String get userName => tr('user_name');
  String get userNameHint => tr('user_name_hint');
  String get confirmPassword => tr('confirm_password');
  String get confirmPasswordHint => tr('confirm_password_hint');
  String get email => tr('email');
  String get emailHint => tr('email_hint');
  String get alreadyHaveAccount => tr('already_have_account');
  String get signUp => tr('sign_up');
  String get forgetPasswordWithoutQuestion =>
      tr('forgot_password_without_question');
  String get enterPhoneToSendCode => tr('enter_phone_to_send_code');
  String get next => tr('next');
  String get verificationCode => tr('verification_code');
  String get weSentCode => tr('we_sent_code');
  String get notReceivedMessage => tr('not_received_message');
  String get preseHere => tr('prese_here');
  String get createNewPassword => tr('create_new_password');
  String get enterNewPasswordWithoutSharing =>
      tr('enter_new_password_without_sharing');
  String get newPassword => tr('new_password');
  String get newPasswordHint => tr('new_password_hint');
  String get confirmNewPassword => tr('confirm_new_password');
  String get confirmNewPasswordHint => tr('confirm_new_password_hint');
  String get confirm => tr('confirm');
  String get passwordCreatedSuccessfully => tr('password_created_successfully');
  String get rememberNotShare => tr('remember_not_share');
}
