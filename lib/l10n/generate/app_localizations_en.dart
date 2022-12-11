import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Personal management';

  @override
  String get appAuthor => 'mDev';

  @override
  String get indexBack => 'Back';

  @override
  String get homePage => 'Overview';

  @override
  String get settingPage => 'Setting';

  @override
  String get settingDesign => 'Deisgn';

  @override
  String get settingLanguage => 'Language:';

  @override
  String get settingLanguageHint => 'Select your language';

  @override
  String get settingLanguageVi => 'Tiếng Việt';

  @override
  String get settingLanguageEn => 'English';

  @override
  String get settingTheme => 'Themes:';

  @override
  String get settingThemeHint => 'Select your themes';

  @override
  String get settingThemeSystem => 'System theme';

  @override
  String get settingThemeLight => 'Light theme';

  @override
  String get settingThemeDark => 'Dark theme';

  @override
  String get settingSettingSave => 'Save';

  @override
  String get taskManagerPage => 'Task manager';
}
