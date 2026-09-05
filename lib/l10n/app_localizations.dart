import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// Bottom bar tab and title of the first screen.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Bottom bar tab listing the ready-made interface elements.
  ///
  /// In en, this message translates to:
  /// **'Elements'**
  String get elements;

  /// Bottom bar tab listing the catalog components.
  ///
  /// In en, this message translates to:
  /// **'Components'**
  String get components;

  /// Settings entry that opens the app language selector.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Settings entry that opens the syntax highlighting theme selector.
  ///
  /// In en, this message translates to:
  /// **'Code Theme'**
  String get codeTheme;

  /// Singular label for a catalog entry of the function type.
  ///
  /// In en, this message translates to:
  /// **'Function'**
  String get function;

  /// Catalog section listing Dart and Flutter functions.
  ///
  /// In en, this message translates to:
  /// **'Functions'**
  String get functions;

  /// Singular label for a catalog entry of the package type.
  ///
  /// In en, this message translates to:
  /// **'Package'**
  String get package;

  /// Catalog section listing third-party packages.
  ///
  /// In en, this message translates to:
  /// **'Packages'**
  String get packages;

  /// Bottom bar tab and title of the settings screen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Settings row showing the installed app version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Link that opens the app repository.
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get sourceCode;

  /// Settings section grouping documentation links.
  ///
  /// In en, this message translates to:
  /// **'Docs and Resources'**
  String get docsAndResources;

  /// Link that opens the developer portfolio site.
  ///
  /// In en, this message translates to:
  /// **'Developer Portfolio'**
  String get developerPortfolio;

  /// Link that opens the app official site.
  ///
  /// In en, this message translates to:
  /// **'Official Site'**
  String get officialSite;

  /// Link that opens the privacy policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Settings entry that opens the about dialog.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Bottom bar tab listing the components the user saved.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// Tooltip of the button that toggles between light and dark theme.
  ///
  /// In en, this message translates to:
  /// **'Change theme'**
  String get changeTheme;

  /// Menu action that opens the component video on YouTube.
  ///
  /// In en, this message translates to:
  /// **'Watch on YouTube'**
  String get watchOnYoutube;

  /// Tooltip of the button that clears the search field.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// State of the save button once a component has been saved.
  ///
  /// In en, this message translates to:
  /// **'saved'**
  String get saved;

  /// State of the save button once a component has been unsaved.
  ///
  /// In en, this message translates to:
  /// **'removed'**
  String get removed;

  /// Message shown after saving a widget.
  ///
  /// In en, this message translates to:
  /// **'Saved Widget'**
  String get savedWidget;

  /// Title of the screen listing the saved widgets.
  ///
  /// In en, this message translates to:
  /// **'Saved Widgets'**
  String get savedWidgets;

  /// Message shown after removing a widget from the saved list.
  ///
  /// In en, this message translates to:
  /// **'Removed Widget'**
  String get widgetRemoved;

  /// Message shown after saving a function.
  ///
  /// In en, this message translates to:
  /// **'Saved Function'**
  String get savedFunction;

  /// Title of the screen listing the saved functions.
  ///
  /// In en, this message translates to:
  /// **'Saved Functions'**
  String get savedFunctions;

  /// Message shown after removing a function from the saved list.
  ///
  /// In en, this message translates to:
  /// **'Removed Function'**
  String get functionRemoved;

  /// Message shown after saving a package.
  ///
  /// In en, this message translates to:
  /// **'Saved Package'**
  String get savedPackage;

  /// Title of the screen listing the saved packages.
  ///
  /// In en, this message translates to:
  /// **'Saved Packages'**
  String get savedPackages;

  /// Message shown after removing a package from the saved list.
  ///
  /// In en, this message translates to:
  /// **'Removed Package'**
  String get packageRemoved;

  /// Empty state of the saved widgets screen.
  ///
  /// In en, this message translates to:
  /// **'No widget has been saved yet.'**
  String get noWidgetSaved;

  /// Empty state of the saved functions screen.
  ///
  /// In en, this message translates to:
  /// **'No function has been saved yet.'**
  String get noFunctionSaved;

  /// Empty state of the saved packages screen.
  ///
  /// In en, this message translates to:
  /// **'No package has been saved yet.'**
  String get noPackageSaved;

  /// Title of the dialog that selects the app theme.
  ///
  /// In en, this message translates to:
  /// **'Select the Theme'**
  String get selectTheTheme;

  /// Theme option that follows the device setting.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Name of the login screen sample.
  ///
  /// In en, this message translates to:
  /// **'Login Screen'**
  String get loginScreen;

  /// Name of the phone verification screen sample.
  ///
  /// In en, this message translates to:
  /// **'Phone Verification Screen'**
  String get phoneVerificationScreen;

  /// Name of the login screen sample that uses a background image.
  ///
  /// In en, this message translates to:
  /// **'Login With Background Image Screen'**
  String get loginScreenWithBackgroundImage;

  /// Name of the email client interface sample.
  ///
  /// In en, this message translates to:
  /// **'Emails App'**
  String get emailsApp;

  /// Name of the chat screen sample.
  ///
  /// In en, this message translates to:
  /// **'Chat Screen'**
  String get chatScreen;

  /// Name of the custom popup menu sample.
  ///
  /// In en, this message translates to:
  /// **'Custom Popup Menu'**
  String get customPopupMenu;

  /// Name of the custom dropdown sample.
  ///
  /// In en, this message translates to:
  /// **'Custom Dropdown'**
  String get customDropdown;

  /// Name of the sample showing spacing helpers.
  ///
  /// In en, this message translates to:
  /// **'Gaps'**
  String get gaps;

  /// Name of the password field sample.
  ///
  /// In en, this message translates to:
  /// **'Password Field'**
  String get passwordField;

  /// Name of the button with a loading state sample.
  ///
  /// In en, this message translates to:
  /// **'Loading Button'**
  String get loadingButton;

  /// Name of the infinite grid sample.
  ///
  /// In en, this message translates to:
  /// **'Infinite Grid View'**
  String get infiniteGridView;

  /// Name of the pagination sample.
  ///
  /// In en, this message translates to:
  /// **'Pagination'**
  String get pagination;

  /// Name of the sample that configures the Dio HTTP client.
  ///
  /// In en, this message translates to:
  /// **'Configuring Dio'**
  String get configuringDio;

  /// Name of the loading dialog sample.
  ///
  /// In en, this message translates to:
  /// **'Loading Dialog'**
  String get loadingDialog;

  /// Name of the loading screen sample.
  ///
  /// In en, this message translates to:
  /// **'Loading Screen'**
  String get loadingScreen;

  /// Name of the image loading sample.
  ///
  /// In en, this message translates to:
  /// **'Image Loader'**
  String get imageLoader;

  /// Title of the dialog asking for a donation.
  ///
  /// In en, this message translates to:
  /// **'Contribute'**
  String get contribute;

  /// Body of the dialog asking for a donation.
  ///
  /// In en, this message translates to:
  /// **'Support the project by buying a coffee.'**
  String get supportProject;

  /// Button that opens the donation link.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donate;

  /// Button that dismisses a dialog without acting.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Link that opens the official Flutter documentation of a component.
  ///
  /// In en, this message translates to:
  /// **'Flutter Docs'**
  String get flutterDocs;

  /// Link that opens the official Dart documentation of a component.
  ///
  /// In en, this message translates to:
  /// **'Dart Docs'**
  String get dartDocs;

  /// Section listing the code samples of a component.
  ///
  /// In en, this message translates to:
  /// **'Samples'**
  String get samples;

  /// Tab showing the source code of a sample.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// Tab showing the sample running.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// Button that adds a component to the saved list.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Button that takes a component out of the saved list.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// Menu action that copies the sample source code.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// Message confirming the sample code was copied.
  ///
  /// In en, this message translates to:
  /// **'Code copied to the clipboard'**
  String get copyToClipboard;

  /// Body of the about dialog, describing what the app is.
  ///
  /// In en, this message translates to:
  /// **'An educational app developed with Flutter that helps developers learn the technology through practical examples.'**
  String get aboutDescription;

  /// Link that opens the app listing on the Play Store.
  ///
  /// In en, this message translates to:
  /// **'View on Play Store'**
  String get viewOnPlayStore;

  /// Title of the screen that selects the syntax highlighting theme.
  ///
  /// In en, this message translates to:
  /// **'Select Code Theme'**
  String get selectCodeTheme;

  /// Theme option with a light background.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Theme option with a dark background.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Error shown when a deep link points to a component the catalog does not have.
  ///
  /// In en, this message translates to:
  /// **'Could not locate the \'{componentName}\' component in \'{type}\'.'**
  String componentNotFound(String componentName, String type);

  /// Menu action that shares a link to the component.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// Error shown when an incoming deep link cannot be parsed.
  ///
  /// In en, this message translates to:
  /// **'The link is invalid.'**
  String get invalidLink;

  /// Error shown when the deep link listener fails to start.
  ///
  /// In en, this message translates to:
  /// **'Failed to initialize the Deep Link feature.'**
  String get deepLinkInitFailure;

  /// Generic title of an error dialog.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Error shown when an external link cannot be opened.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while trying to open the link'**
  String get errorOpeningLink;

  /// Catalog group of widgets that render text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get textGroup;

  /// Catalog group of widgets the user taps.
  ///
  /// In en, this message translates to:
  /// **'Button'**
  String get buttonGroup;

  /// Catalog group of input and form widgets.
  ///
  /// In en, this message translates to:
  /// **'Form'**
  String get formGroup;

  /// Catalog group of widgets that pick a value, such as dates.
  ///
  /// In en, this message translates to:
  /// **'Picker'**
  String get pickerGroup;

  /// Catalog group of list and scrolling widgets.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get listGroup;

  /// Catalog group of widgets that arrange other widgets.
  ///
  /// In en, this message translates to:
  /// **'Layout'**
  String get layoutGroup;

  /// Catalog group of navigation widgets.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get navigationGroup;

  /// Catalog group of dialogs, sheets and other overlays.
  ///
  /// In en, this message translates to:
  /// **'Dialog & Overlay'**
  String get dialogAndOverlayGroup;

  /// Catalog group of widgets that present content, such as images.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get displayGroup;

  /// Catalog group of visual effect widgets.
  ///
  /// In en, this message translates to:
  /// **'Effects'**
  String get effectsGroup;

  /// Catalog group of gesture and interaction widgets.
  ///
  /// In en, this message translates to:
  /// **'Interaction'**
  String get interactionGroup;

  /// Catalog group of builder widgets.
  ///
  /// In en, this message translates to:
  /// **'Builder'**
  String get builderGroup;

  /// Menu action that opens the documentation of a component.
  ///
  /// In en, this message translates to:
  /// **'Doc'**
  String get doc;

  /// Singular label for a catalog entry of the widget type.
  ///
  /// In en, this message translates to:
  /// **'Widget'**
  String get widget;

  /// Catalog section listing Flutter widgets.
  ///
  /// In en, this message translates to:
  /// **'Widgets'**
  String get widgets;

  /// Button that acknowledges and dismisses a message.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// Settings entry that opens the feedback channel.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// Catalog section listing complete interface samples.
  ///
  /// In en, this message translates to:
  /// **'UIs'**
  String get uis;

  /// Title of the screen shown when startup failed before the app could run.
  ///
  /// In en, this message translates to:
  /// **'The app could not start'**
  String get startupErrorTitle;

  /// Body of the startup failure screen, telling the user what to do next.
  ///
  /// In en, this message translates to:
  /// **'Something failed while starting up. Try again, and reinstall the app if it keeps failing.'**
  String get startupErrorMessage;

  /// Title of the screen shown when a part of the running app failed to build.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get unexpectedErrorTitle;

  /// Body of the unexpected failure screen.
  ///
  /// In en, this message translates to:
  /// **'This screen failed to load. Go back and try again.'**
  String get unexpectedErrorMessage;

  /// Button that runs the failed operation again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;
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
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
