// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppStrings {
  AppStrings();

  static AppStrings? _current;

  static AppStrings get current {
    assert(
      _current != null,
      'No instance of AppStrings was loaded. Try to initialize the AppStrings delegate before accessing AppStrings.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppStrings> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppStrings();
      AppStrings._current = instance;

      return instance;
    });
  }

  static AppStrings of(BuildContext context) {
    final instance = AppStrings.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppStrings present in the widget tree. Did you add AppStrings.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppStrings? maybeOf(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings);
  }

  /// `Smart Toy`
  String get appName {
    return Intl.message('Smart Toy', name: 'appName', desc: '', args: []);
  }

  /// `Thông báo`
  String get notification {
    return Intl.message('Thông báo', name: 'notification', desc: '', args: []);
  }

  /// `Cá nhân`
  String get profile {
    return Intl.message('Cá nhân', name: 'profile', desc: '', args: []);
  }

  /// `Đăng nhập`
  String get login {
    return Intl.message('Đăng nhập', name: 'login', desc: '', args: []);
  }

  /// `Đăng ký`
  String get register {
    return Intl.message('Đăng ký', name: 'register', desc: '', args: []);
  }

  /// `Vui lòng nhập số điện thoại bạn muốn dùng để đăng ký tài khoản. OTP sẽ được gửi đến số điện thoại của bạn.`
  String get registerMsg {
    return Intl.message(
      'Vui lòng nhập số điện thoại bạn muốn dùng để đăng ký tài khoản. OTP sẽ được gửi đến số điện thoại của bạn.',
      name: 'registerMsg',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại`
  String get registerPhone {
    return Intl.message(
      'Số điện thoại',
      name: 'registerPhone',
      desc: '',
      args: [],
    );
  }

  /// `Nhập số điện thoại`
  String get registerPhoneHint {
    return Intl.message(
      'Nhập số điện thoại',
      name: 'registerPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `OTP`
  String get registerOTP {
    return Intl.message('OTP', name: 'registerOTP', desc: '', args: []);
  }

  /// `Đăng xuất`
  String get logout {
    return Intl.message('Đăng xuất', name: 'logout', desc: '', args: []);
  }

  /// `Xác nhận đăng xuất`
  String get logoutTitle {
    return Intl.message(
      'Xác nhận đăng xuất',
      name: 'logoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn đăng xuất tài khoản?`
  String get logoutMsg {
    return Intl.message(
      'Bạn có chắc chắn muốn đăng xuất tài khoản?',
      name: 'logoutMsg',
      desc: '',
      args: [],
    );
  }

  /// `Xóa tài khoản`
  String get deleteAccount {
    return Intl.message(
      'Xóa tài khoản',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận xóa tài khoản`
  String get deleteAccountTitle {
    return Intl.message(
      'Xác nhận xóa tài khoản',
      name: 'deleteAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn xóa tài khoản? Tài khoản không thể khôi phục sau khi xóa`
  String get deleteAccountMsg {
    return Intl.message(
      'Bạn có chắc chắn muốn xóa tài khoản? Tài khoản không thể khôi phục sau khi xóa',
      name: 'deleteAccountMsg',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get buttonLogin {
    return Intl.message('Đăng nhập', name: 'buttonLogin', desc: '', args: []);
  }

  /// `Đăng ký`
  String get buttonRegister {
    return Intl.message('Đăng ký', name: 'buttonRegister', desc: '', args: []);
  }

  /// `Xác nhận`
  String get buttonConfirm {
    return Intl.message('Xác nhận', name: 'buttonConfirm', desc: '', args: []);
  }

  /// `Từ chối`
  String get buttonReject {
    return Intl.message('Từ chối', name: 'buttonReject', desc: '', args: []);
  }

  /// `Tìm kiếm`
  String get buttonSearch {
    return Intl.message('Tìm kiếm', name: 'buttonSearch', desc: '', args: []);
  }

  /// `Hủy`
  String get buttonCancel {
    return Intl.message('Hủy', name: 'buttonCancel', desc: '', args: []);
  }

  /// `Ghi lại`
  String get buttonRecord {
    return Intl.message('Ghi lại', name: 'buttonRecord', desc: '', args: []);
  }

  /// `Lưu`
  String get buttonSave {
    return Intl.message('Lưu', name: 'buttonSave', desc: '', args: []);
  }

  /// `Gửi`
  String get buttonSend {
    return Intl.message('Gửi', name: 'buttonSend', desc: '', args: []);
  }

  /// `Đăng xuất`
  String get buttonLogout {
    return Intl.message('Đăng xuất', name: 'buttonLogout', desc: '', args: []);
  }

  /// `Lưu thành công`
  String get buttonSaveMsgSuccess {
    return Intl.message(
      'Lưu thành công',
      name: 'buttonSaveMsgSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Lưu thất bại`
  String get buttonSaveMsgErr {
    return Intl.message(
      'Lưu thất bại',
      name: 'buttonSaveMsgErr',
      desc: '',
      args: [],
    );
  }

  /// `Xóa tài khoản`
  String get buttonDeleteAccount {
    return Intl.message(
      'Xóa tài khoản',
      name: 'buttonDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Gửi OTP`
  String get buttonSendOTP {
    return Intl.message('Gửi OTP', name: 'buttonSendOTP', desc: '', args: []);
  }

  /// `Đã gửi OTP thành công`
  String get buttonSendOTPMsgSuccess {
    return Intl.message(
      'Đã gửi OTP thành công',
      name: 'buttonSendOTPMsgSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Đã có tài khoản? Đăng nhập`
  String get buttonReadyAccount {
    return Intl.message(
      'Đã có tài khoản? Đăng nhập',
      name: 'buttonReadyAccount',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Hủy`
  String get cancel {
    return Intl.message('Hủy', name: 'cancel', desc: '', args: []);
  }

  /// `Thử lại`
  String get retry {
    return Intl.message('Thử lại', name: 'retry', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppStrings> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppStrings> load(Locale locale) => AppStrings.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
