import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('en')
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @elements.
  ///
  /// In en, this message translates to:
  /// **'Elements'**
  String get elements;

  /// No description provided for @components.
  ///
  /// In en, this message translates to:
  /// **'Components'**
  String get components;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @codeTheme.
  ///
  /// In en, this message translates to:
  /// **'Code Theme'**
  String get codeTheme;

  /// No description provided for @function.
  ///
  /// In en, this message translates to:
  /// **'Function'**
  String get function;

  /// No description provided for @functions.
  ///
  /// In en, this message translates to:
  /// **'Functions'**
  String get functions;

  /// No description provided for @package.
  ///
  /// In en, this message translates to:
  /// **'Package'**
  String get package;

  /// No description provided for @packages.
  ///
  /// In en, this message translates to:
  /// **'Packages'**
  String get packages;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @sourceCode.
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get sourceCode;

  /// No description provided for @docsAndResources.
  ///
  /// In en, this message translates to:
  /// **'Docs and Resources'**
  String get docsAndResources;

  /// No description provided for @myWebsite.
  ///
  /// In en, this message translates to:
  /// **'My Website'**
  String get myWebsite;

  /// No description provided for @officialSite.
  ///
  /// In en, this message translates to:
  /// **'Official Site'**
  String get officialSite;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'salved'**
  String get saved;

  /// No description provided for @removed.
  ///
  /// In en, this message translates to:
  /// **'removed'**
  String get removed;

  /// No description provided for @savedWidget.
  ///
  /// In en, this message translates to:
  /// **'Saved Widget'**
  String get savedWidget;

  /// No description provided for @savedWidgets.
  ///
  /// In en, this message translates to:
  /// **'Saved Widgets'**
  String get savedWidgets;

  /// No description provided for @widgetRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed Widget'**
  String get widgetRemoved;

  /// No description provided for @savedFunction.
  ///
  /// In en, this message translates to:
  /// **'Saved Function'**
  String get savedFunction;

  /// No description provided for @savedFunctions.
  ///
  /// In en, this message translates to:
  /// **'Saved Functions'**
  String get savedFunctions;

  /// No description provided for @functionRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed Function'**
  String get functionRemoved;

  /// No description provided for @savedPackage.
  ///
  /// In en, this message translates to:
  /// **'Saved Package'**
  String get savedPackage;

  /// No description provided for @savedPackages.
  ///
  /// In en, this message translates to:
  /// **'Saved Packages'**
  String get savedPackages;

  /// No description provided for @packageRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed Package'**
  String get packageRemoved;

  /// No description provided for @noWidgetSaved.
  ///
  /// In en, this message translates to:
  /// **'No widget has been saved yet.'**
  String get noWidgetSaved;

  /// No description provided for @noFunctionSaved.
  ///
  /// In en, this message translates to:
  /// **'No function has been saved yet.'**
  String get noFunctionSaved;

  /// No description provided for @noPackageSaved.
  ///
  /// In en, this message translates to:
  /// **'No package has been saved yet.'**
  String get noPackageSaved;

  /// No description provided for @selectTheTheme.
  ///
  /// In en, this message translates to:
  /// **'Select the Theme'**
  String get selectTheTheme;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @loginScreen.
  ///
  /// In en, this message translates to:
  /// **'Login Screen'**
  String get loginScreen;

  /// No description provided for @phoneVerificationScreen.
  ///
  /// In en, this message translates to:
  /// **'Phone Verification Screen'**
  String get phoneVerificationScreen;

  /// No description provided for @loginScreenWithBackgroundImage.
  ///
  /// In en, this message translates to:
  /// **'Login With Background Image Screen'**
  String get loginScreenWithBackgroundImage;

  /// No description provided for @emailsApp.
  ///
  /// In en, this message translates to:
  /// **'Emails App'**
  String get emailsApp;

  /// No description provided for @chatScreen.
  ///
  /// In en, this message translates to:
  /// **'Chat Screen'**
  String get chatScreen;

  /// No description provided for @customPopupMenu.
  ///
  /// In en, this message translates to:
  /// **'Custom Popup Menu'**
  String get customPopupMenu;

  /// No description provided for @customDropdown.
  ///
  /// In en, this message translates to:
  /// **'Custom Dropdown'**
  String get customDropdown;

  /// No description provided for @gaps.
  ///
  /// In en, this message translates to:
  /// **'Gaps'**
  String get gaps;

  /// No description provided for @passwordField.
  ///
  /// In en, this message translates to:
  /// **'Password Field'**
  String get passwordField;

  /// No description provided for @loadingButton.
  ///
  /// In en, this message translates to:
  /// **'Loading Button'**
  String get loadingButton;

  /// No description provided for @infiniteGridView.
  ///
  /// In en, this message translates to:
  /// **'Infinite Grid View'**
  String get infiniteGridView;

  /// No description provided for @pagination.
  ///
  /// In en, this message translates to:
  /// **'Pagination'**
  String get pagination;

  /// No description provided for @configuringDio.
  ///
  /// In en, this message translates to:
  /// **'Configuring Dio'**
  String get configuringDio;

  /// No description provided for @loadingDialog.
  ///
  /// In en, this message translates to:
  /// **'Loading Dialog'**
  String get loadingDialog;

  /// No description provided for @loadingScreen.
  ///
  /// In en, this message translates to:
  /// **'Loading Screen'**
  String get loadingScreen;

  /// No description provided for @imageLoader.
  ///
  /// In en, this message translates to:
  /// **'Image Loader'**
  String get imageLoader;

  /// No description provided for @contribute.
  ///
  /// In en, this message translates to:
  /// **'Contribute'**
  String get contribute;

  /// No description provided for @supportProject.
  ///
  /// In en, this message translates to:
  /// **'Support the project by buying a coffee.'**
  String get supportProject;

  /// No description provided for @donate.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donate;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @flutterDocs.
  ///
  /// In en, this message translates to:
  /// **'Flutter Docs'**
  String get flutterDocs;

  /// No description provided for @dartDocs.
  ///
  /// In en, this message translates to:
  /// **'Dart Docs'**
  String get dartDocs;

  /// No description provided for @samples.
  ///
  /// In en, this message translates to:
  /// **'Samples'**
  String get samples;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copyToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Code copied to the clipboard'**
  String get copyToClipboard;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'An educational app developed with Flutter that helps developers learn the technology through practical examples.'**
  String get aboutDescription;

  /// No description provided for @viewOnPlayStore.
  ///
  /// In en, this message translates to:
  /// **'View on Play Store'**
  String get viewOnPlayStore;

  /// No description provided for @selectCodeTheme.
  ///
  /// In en, this message translates to:
  /// **'Select Code Theme'**
  String get selectCodeTheme;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @componentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Could not locate the \'{componentName}\' component in \'{type}\'.'**
  String componentNotFound(Object componentName, Object type);

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['pt', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'pt':
      return AppLocalizationsPt();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
