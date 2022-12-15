import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generate/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @appTitle.
  ///
  /// In vi, this message translates to:
  /// **'Quản lý cá nhân'**
  String get appTitle;

  /// No description provided for @appAuthor.
  ///
  /// In vi, this message translates to:
  /// **'mDev'**
  String get appAuthor;

  /// No description provided for @indexBack.
  ///
  /// In vi, this message translates to:
  /// **'Trở lại'**
  String get indexBack;

  /// No description provided for @homePage.
  ///
  /// In vi, this message translates to:
  /// **'Tổng quan'**
  String get homePage;

  /// No description provided for @settingPage.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get settingPage;

  /// No description provided for @settingDesign.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt hiển thị.'**
  String get settingDesign;

  /// No description provided for @settingLanguage.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ:'**
  String get settingLanguage;

  /// No description provided for @settingLanguageHint.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ngôn ngữ của bạn'**
  String get settingLanguageHint;

  /// No description provided for @settingLanguageVi.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get settingLanguageVi;

  /// No description provided for @settingLanguageEn.
  ///
  /// In vi, this message translates to:
  /// **'English'**
  String get settingLanguageEn;

  /// No description provided for @settingTheme.
  ///
  /// In vi, this message translates to:
  /// **'Chủ đề:'**
  String get settingTheme;

  /// No description provided for @settingThemeHint.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ngôn ngữ của bạn'**
  String get settingThemeHint;

  /// No description provided for @settingThemeSystem.
  ///
  /// In vi, this message translates to:
  /// **'Theo hệ thống'**
  String get settingThemeSystem;

  /// No description provided for @settingThemeLight.
  ///
  /// In vi, this message translates to:
  /// **'Chủ đề sáng'**
  String get settingThemeLight;

  /// No description provided for @settingThemeDark.
  ///
  /// In vi, this message translates to:
  /// **'Chủ đề tối'**
  String get settingThemeDark;

  /// No description provided for @settingSettingSave.
  ///
  /// In vi, this message translates to:
  /// **'Lưu lại'**
  String get settingSettingSave;

  /// No description provided for @taskManagerPage.
  ///
  /// In vi, this message translates to:
  /// **'Quản lý công việc'**
  String get taskManagerPage;

  /// No description provided for @devApiCallPage.
  ///
  /// In vi, this message translates to:
  /// **'API Tinh gọn'**
  String get devApiCallPage;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
