import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @welcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Welcome, [Volunteer Name]!'**
  String get welcomeUser;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'youremail@domain.com | +01 09876 54321'**
  String get contactInfo;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account & Profile Settings'**
  String get accountSettings;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @availableStatus.
  ///
  /// In en, this message translates to:
  /// **'Available (Ready to Serve)'**
  String get availableStatus;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @currentLanguage.
  ///
  /// In en, this message translates to:
  /// **'Arabic (Darja)'**
  String get currentLanguage;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'User Data Protection Policy'**
  String get privacyPolicy;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @verificationMessage.
  ///
  /// In en, this message translates to:
  /// **'Your certificate is being verified. We will notify you when it’s done!'**
  String get verificationMessage;

  /// No description provided for @buttonPressed.
  ///
  /// In en, this message translates to:
  /// **'Button clicked'**
  String get buttonPressed;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergency;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @testButton.
  ///
  /// In en, this message translates to:
  /// **'Language works!'**
  String get testButton;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency App'**
  String get appTitle;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @dangerTitle.
  ///
  /// In en, this message translates to:
  /// **'Is there a danger? Need help?'**
  String get dangerTitle;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyTitle;

  /// No description provided for @typesOfData.
  ///
  /// In en, this message translates to:
  /// **'Types of data we collect'**
  String get typesOfData;

  /// No description provided for @typesOfDataDesc.
  ///
  /// In en, this message translates to:
  /// **'We collect some information (location, name, phone number, type of help)...'**
  String get typesOfDataDesc;

  /// No description provided for @howWeUse.
  ///
  /// In en, this message translates to:
  /// **'How we use your personal data'**
  String get howWeUse;

  /// No description provided for @howWeUseDesc.
  ///
  /// In en, this message translates to:
  /// **'We only use this data to operate the rescue system...'**
  String get howWeUseDesc;

  /// No description provided for @disclosure.
  ///
  /// In en, this message translates to:
  /// **'Data disclosure'**
  String get disclosure;

  /// No description provided for @disclosureDesc.
  ///
  /// In en, this message translates to:
  /// **'We do not sell or share your data...'**
  String get disclosureDesc;

  /// No description provided for @dangerText.
  ///
  /// In en, this message translates to:
  /// **'Is there a danger? Need help?'**
  String get dangerText;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsTitle;

  /// No description provided for @termsUse.
  ///
  /// In en, this message translates to:
  /// **'Use of the app'**
  String get termsUse;

  /// No description provided for @termsUseDesc.
  ///
  /// In en, this message translates to:
  /// **'By using this app, you agree to these terms...'**
  String get termsUseDesc;

  /// No description provided for @userResponsibility.
  ///
  /// In en, this message translates to:
  /// **'User responsibilities'**
  String get userResponsibility;

  /// No description provided for @userResponsibilityDesc.
  ///
  /// In en, this message translates to:
  /// **'Users must provide correct information...'**
  String get userResponsibilityDesc;

  /// No description provided for @privacyData.
  ///
  /// In en, this message translates to:
  /// **'Privacy of data'**
  String get privacyData;

  /// No description provided for @privacyDataDesc.
  ///
  /// In en, this message translates to:
  /// **'We are committed to protecting your privacy...'**
  String get privacyDataDesc;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get disclaimer;

  /// No description provided for @disclaimerDesc.
  ///
  /// In en, this message translates to:
  /// **'This app aims to facilitate emergency access...'**
  String get disclaimerDesc;

  /// No description provided for @updates.
  ///
  /// In en, this message translates to:
  /// **'Updates to terms'**
  String get updates;

  /// No description provided for @updatesDesc.
  ///
  /// In en, this message translates to:
  /// **'We reserve the right to modify these terms...'**
  String get updatesDesc;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get settingsTooltip;

  /// No description provided for @followUs.
  ///
  /// In en, this message translates to:
  /// **'Follow us on social media'**
  String get followUs;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get faq;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate our app on Google Play'**
  String get rateApp;

  /// No description provided for @loadingTitle.
  ///
  /// In en, this message translates to:
  /// **'We\'re with you'**
  String get loadingTitle;

  /// No description provided for @loadingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Stay calm / Relax'**
  String get loadingSubtitle;

  /// No description provided for @emergencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Danger!! Need help?'**
  String get emergencyTitle;

  /// No description provided for @emergencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Press the big button\nTake a deep breath... everything will be fine'**
  String get emergencySubtitle;

  /// No description provided for @skipButton.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipButton;

  /// No description provided for @cannotOpenPhoneApp.
  ///
  /// In en, this message translates to:
  /// **'Cannot open phone app'**
  String get cannotOpenPhoneApp;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred:'**
  String get errorOccurred;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Become a volunteer with us'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We need your basic information to contact you'**
  String get registerSubtitle;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get nameHint;

  /// No description provided for @nameValidator.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get nameValidator;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneHint;

  /// No description provided for @phoneValidator.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get phoneValidator;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// No description provided for @emailValidator.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailValidator;

  /// No description provided for @addressHint.
  ///
  /// In en, this message translates to:
  /// **'Full Address'**
  String get addressHint;

  /// No description provided for @addressValidator.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full address'**
  String get addressValidator;

  /// No description provided for @pickFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Pick from gallery'**
  String get pickFromGallery;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// No description provided for @fileUploaded.
  ///
  /// In en, this message translates to:
  /// **'File uploaded'**
  String get fileUploaded;

  /// No description provided for @acceptTermsWarning.
  ///
  /// In en, this message translates to:
  /// **'You must accept the terms and conditions'**
  String get acceptTermsWarning;

  /// No description provided for @uploadCertificateWarning.
  ///
  /// In en, this message translates to:
  /// **'You must upload your accreditation certificate'**
  String get uploadCertificateWarning;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully registered'**
  String get registerSuccess;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccount;

  /// No description provided for @genderHint.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderHint;

  /// No description provided for @genderValidator.
  ///
  /// In en, this message translates to:
  /// **'Please select your gender'**
  String get genderValidator;

  /// No description provided for @stateHint.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get stateHint;

  /// No description provided for @stateValidator.
  ///
  /// In en, this message translates to:
  /// **'Please select your state'**
  String get stateValidator;

  /// No description provided for @uploadCertificateHint.
  ///
  /// In en, this message translates to:
  /// **'Upload your accreditation certificate'**
  String get uploadCertificateHint;

  /// No description provided for @termsText.
  ///
  /// In en, this message translates to:
  /// **'I agree to the terms and conditions'**
  String get termsText;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @loginEmailPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or phone number'**
  String get loginEmailPhone;

  /// No description provided for @loginEmailPhoneError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email or phone number'**
  String get loginEmailPhoneError;

  /// No description provided for @loginPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPassword;

  /// No description provided for @loginPasswordError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get loginPasswordError;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logged in successfully'**
  String get loginSuccess;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @dataCollectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Data We Collect'**
  String get dataCollectedTitle;

  /// No description provided for @dataCollectedContent.
  ///
  /// In en, this message translates to:
  /// **'We collect some information (location, name, phone number, type of help) to ensure assistance is delivered on time. This data is necessary for the app.'**
  String get dataCollectedContent;

  /// No description provided for @howDataUsedTitle.
  ///
  /// In en, this message translates to:
  /// **'How We Use Your Data'**
  String get howDataUsedTitle;

  /// No description provided for @howDataUsedContent.
  ///
  /// In en, this message translates to:
  /// **'We only use this data to operate the rescue system (locate the call, notify volunteers). We never share your data unless necessary to save lives.'**
  String get howDataUsedContent;

  /// No description provided for @dataDisclosureTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Disclosure'**
  String get dataDisclosureTitle;

  /// No description provided for @dataDisclosureContent.
  ///
  /// In en, this message translates to:
  /// **'We do not sell or distribute your information. Disclosure only happens for legal reasons or to protect lives.'**
  String get dataDisclosureContent;

  /// No description provided for @appUseTitle.
  ///
  /// In en, this message translates to:
  /// **'App Usage'**
  String get appUseTitle;

  /// No description provided for @appUseContent.
  ///
  /// In en, this message translates to:
  /// **'By using this app, you agree to these terms. The app provides emergency and rescue services responsibly.'**
  String get appUseContent;

  /// No description provided for @userResponsibilitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'User Responsibilities'**
  String get userResponsibilitiesTitle;

  /// No description provided for @userResponsibilitiesContent.
  ///
  /// In en, this message translates to:
  /// **'Users must provide accurate information and respect volunteers. Misuse of emergency services may have legal consequences.'**
  String get userResponsibilitiesContent;

  /// No description provided for @privacyContent.
  ///
  /// In en, this message translates to:
  /// **'We protect your personal data according to our privacy policy and use it only for emergency services.'**
  String get privacyContent;

  /// No description provided for @disclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get disclaimerTitle;

  /// No description provided for @disclaimerContent.
  ///
  /// In en, this message translates to:
  /// **'We cannot guarantee response times or outcomes. Contact official emergency services in critical cases.'**
  String get disclaimerContent;

  /// No description provided for @changesTitle.
  ///
  /// In en, this message translates to:
  /// **'Changes to Terms'**
  String get changesTitle;

  /// No description provided for @changesContent.
  ///
  /// In en, this message translates to:
  /// **'We may update these terms anytime. Using the app after updates means you accept the new terms.'**
  String get changesContent;

  /// No description provided for @editInfo.
  ///
  /// In en, this message translates to:
  /// **'Edit Information'**
  String get editInfo;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone;

  /// No description provided for @wilaya.
  ///
  /// In en, this message translates to:
  /// **'Wilaya'**
  String get wilaya;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @updatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Information updated successfully!'**
  String get updatedSuccessfully;

  /// No description provided for @gender_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get gender_male;

  /// No description provided for @gender_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get gender_female;

  /// No description provided for @wilaya_adrar.
  ///
  /// In en, this message translates to:
  /// **'Adrar'**
  String get wilaya_adrar;

  /// No description provided for @wilaya_chlef.
  ///
  /// In en, this message translates to:
  /// **'Chlef'**
  String get wilaya_chlef;

  /// No description provided for @wilaya_laghouat.
  ///
  /// In en, this message translates to:
  /// **'Laghouat'**
  String get wilaya_laghouat;

  /// No description provided for @wilaya_oum_el_bouaghi.
  ///
  /// In en, this message translates to:
  /// **'Oum El Bouaghi'**
  String get wilaya_oum_el_bouaghi;

  /// No description provided for @wilaya_batna.
  ///
  /// In en, this message translates to:
  /// **'Batna'**
  String get wilaya_batna;

  /// No description provided for @wilaya_bejaia.
  ///
  /// In en, this message translates to:
  /// **'Béjaïa'**
  String get wilaya_bejaia;

  /// No description provided for @wilaya_biskra.
  ///
  /// In en, this message translates to:
  /// **'Biskra'**
  String get wilaya_biskra;

  /// No description provided for @wilaya_bechar.
  ///
  /// In en, this message translates to:
  /// **'Béchar'**
  String get wilaya_bechar;

  /// No description provided for @wilaya_blida.
  ///
  /// In en, this message translates to:
  /// **'Blida'**
  String get wilaya_blida;

  /// No description provided for @wilaya_bouira.
  ///
  /// In en, this message translates to:
  /// **'Bouira'**
  String get wilaya_bouira;

  /// No description provided for @wilaya_tamanrasset.
  ///
  /// In en, this message translates to:
  /// **'Tamanrasset'**
  String get wilaya_tamanrasset;

  /// No description provided for @wilaya_tbessa.
  ///
  /// In en, this message translates to:
  /// **'Tébessa'**
  String get wilaya_tbessa;

  /// No description provided for @wilaya_tlemcen.
  ///
  /// In en, this message translates to:
  /// **'Tlemcen'**
  String get wilaya_tlemcen;

  /// No description provided for @wilaya_tiaret.
  ///
  /// In en, this message translates to:
  /// **'Tiaret'**
  String get wilaya_tiaret;

  /// No description provided for @wilaya_tizi_ouzou.
  ///
  /// In en, this message translates to:
  /// **'Tizi Ouzou'**
  String get wilaya_tizi_ouzou;

  /// No description provided for @wilaya_algiers.
  ///
  /// In en, this message translates to:
  /// **'Algiers'**
  String get wilaya_algiers;

  /// No description provided for @wilaya_djelfa.
  ///
  /// In en, this message translates to:
  /// **'Djelfa'**
  String get wilaya_djelfa;

  /// No description provided for @wilaya_jijel.
  ///
  /// In en, this message translates to:
  /// **'Jijel'**
  String get wilaya_jijel;

  /// No description provided for @wilaya_setif.
  ///
  /// In en, this message translates to:
  /// **'Sétif'**
  String get wilaya_setif;

  /// No description provided for @wilaya_saida.
  ///
  /// In en, this message translates to:
  /// **'Saïda'**
  String get wilaya_saida;

  /// No description provided for @wilaya_skikda.
  ///
  /// In en, this message translates to:
  /// **'Skikda'**
  String get wilaya_skikda;

  /// No description provided for @wilaya_sidi_bel_abbes.
  ///
  /// In en, this message translates to:
  /// **'Sidi Bel Abbès'**
  String get wilaya_sidi_bel_abbes;

  /// No description provided for @wilaya_annaba.
  ///
  /// In en, this message translates to:
  /// **'Annaba'**
  String get wilaya_annaba;

  /// No description provided for @wilaya_guelma.
  ///
  /// In en, this message translates to:
  /// **'Guelma'**
  String get wilaya_guelma;

  /// No description provided for @wilaya_constantine.
  ///
  /// In en, this message translates to:
  /// **'Constantine'**
  String get wilaya_constantine;

  /// No description provided for @wilaya_medea.
  ///
  /// In en, this message translates to:
  /// **'Médéa'**
  String get wilaya_medea;

  /// No description provided for @wilaya_mostaganem.
  ///
  /// In en, this message translates to:
  /// **'Mostaganem'**
  String get wilaya_mostaganem;

  /// No description provided for @wilaya_mila.
  ///
  /// In en, this message translates to:
  /// **'Mila'**
  String get wilaya_mila;

  /// No description provided for @wilaya_msila.
  ///
  /// In en, this message translates to:
  /// **'M\'Sila'**
  String get wilaya_msila;

  /// No description provided for @wilaya_mascara.
  ///
  /// In en, this message translates to:
  /// **'Mascara'**
  String get wilaya_mascara;

  /// No description provided for @wilaya_ouargla.
  ///
  /// In en, this message translates to:
  /// **'Ouargla'**
  String get wilaya_ouargla;

  /// No description provided for @wilaya_oran.
  ///
  /// In en, this message translates to:
  /// **'Oran'**
  String get wilaya_oran;

  /// No description provided for @wilaya_el_bayadh.
  ///
  /// In en, this message translates to:
  /// **'El Bayadh'**
  String get wilaya_el_bayadh;

  /// No description provided for @wilaya_illizi.
  ///
  /// In en, this message translates to:
  /// **'Illizi'**
  String get wilaya_illizi;

  /// No description provided for @wilaya_bordj_bou_arreridj.
  ///
  /// In en, this message translates to:
  /// **'Bordj Bou Arréridj'**
  String get wilaya_bordj_bou_arreridj;

  /// No description provided for @wilaya_boumerdes.
  ///
  /// In en, this message translates to:
  /// **'Boumerdès'**
  String get wilaya_boumerdes;

  /// No description provided for @wilaya_el_tarf.
  ///
  /// In en, this message translates to:
  /// **'El Tarf'**
  String get wilaya_el_tarf;

  /// No description provided for @wilaya_tindouf.
  ///
  /// In en, this message translates to:
  /// **'Tindouf'**
  String get wilaya_tindouf;

  /// No description provided for @wilaya_tissemsilt.
  ///
  /// In en, this message translates to:
  /// **'Tissemsilt'**
  String get wilaya_tissemsilt;

  /// No description provided for @wilaya_el_oued.
  ///
  /// In en, this message translates to:
  /// **'El Oued'**
  String get wilaya_el_oued;

  /// No description provided for @wilaya_khenchela.
  ///
  /// In en, this message translates to:
  /// **'Khenchela'**
  String get wilaya_khenchela;

  /// No description provided for @wilaya_souk_ahras.
  ///
  /// In en, this message translates to:
  /// **'Souk Ahras'**
  String get wilaya_souk_ahras;

  /// No description provided for @wilaya_tipaza.
  ///
  /// In en, this message translates to:
  /// **'Tipaza'**
  String get wilaya_tipaza;

  /// No description provided for @wilaya_mila2.
  ///
  /// In en, this message translates to:
  /// **'Mila (alt)'**
  String get wilaya_mila2;

  /// No description provided for @wilaya_ain_defla.
  ///
  /// In en, this message translates to:
  /// **'Aïn Defla'**
  String get wilaya_ain_defla;

  /// No description provided for @wilaya_naama.
  ///
  /// In en, this message translates to:
  /// **'Naama'**
  String get wilaya_naama;

  /// No description provided for @wilaya_ain_temouchent.
  ///
  /// In en, this message translates to:
  /// **'Aïn Témouchent'**
  String get wilaya_ain_temouchent;

  /// No description provided for @wilaya_ghardaia.
  ///
  /// In en, this message translates to:
  /// **'Ghardaïa'**
  String get wilaya_ghardaia;

  /// No description provided for @wilaya_relizane.
  ///
  /// In en, this message translates to:
  /// **'Relizane'**
  String get wilaya_relizane;

  /// No description provided for @wilaya_timimoun.
  ///
  /// In en, this message translates to:
  /// **'Timimoun'**
  String get wilaya_timimoun;

  /// No description provided for @wilaya_bordj_baji_mokhtar.
  ///
  /// In en, this message translates to:
  /// **'Bordj Baji Mokhtar'**
  String get wilaya_bordj_baji_mokhtar;

  /// No description provided for @wilaya_ouled_jellal.
  ///
  /// In en, this message translates to:
  /// **'Ouled Djellal'**
  String get wilaya_ouled_jellal;

  /// No description provided for @wilaya_beni_abbes.
  ///
  /// In en, this message translates to:
  /// **'Béni Abbès'**
  String get wilaya_beni_abbes;

  /// No description provided for @wilaya_ain_saleh.
  ///
  /// In en, this message translates to:
  /// **'Aïn Salah'**
  String get wilaya_ain_saleh;

  /// No description provided for @wilaya_ain_guezzam.
  ///
  /// In en, this message translates to:
  /// **'Aïn Guezzam'**
  String get wilaya_ain_guezzam;

  /// No description provided for @wilaya_touggourt.
  ///
  /// In en, this message translates to:
  /// **'Touggourt'**
  String get wilaya_touggourt;

  /// No description provided for @wilaya_djanet.
  ///
  /// In en, this message translates to:
  /// **'Djanet'**
  String get wilaya_djanet;

  /// No description provided for @wilaya_el_meghier.
  ///
  /// In en, this message translates to:
  /// **'El Meghier'**
  String get wilaya_el_meghier;

  /// No description provided for @wilaya_el_meniaa.
  ///
  /// In en, this message translates to:
  /// **'El Meniaa'**
  String get wilaya_el_meniaa;

  /// No description provided for @exploreTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get exploreTitle;

  /// No description provided for @preventionMethods.
  ///
  /// In en, this message translates to:
  /// **'Prevention Methods'**
  String get preventionMethods;

  /// No description provided for @safetyInstructions.
  ///
  /// In en, this message translates to:
  /// **'Safety Instructions'**
  String get safetyInstructions;

  /// No description provided for @volunteerList.
  ///
  /// In en, this message translates to:
  /// **'Volunteers List'**
  String get volunteerList;

  /// No description provided for @volunteerListTitle.
  ///
  /// In en, this message translates to:
  /// **'Volunteer List'**
  String get volunteerListTitle;

  /// No description provided for @headerImageMissing.
  ///
  /// In en, this message translates to:
  /// **'Header Image Missing'**
  String get headerImageMissing;

  /// No description provided for @calling.
  ///
  /// In en, this message translates to:
  /// **'Calling'**
  String get calling;

  /// No description provided for @mapPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Map is loading...'**
  String get mapPlaceholder;

  /// No description provided for @availableVolunteers.
  ///
  /// In en, this message translates to:
  /// **'Available volunteers'**
  String get availableVolunteers;

  /// No description provided for @showNearbyVolunteers.
  ///
  /// In en, this message translates to:
  /// **'Show Nearby Volunteers'**
  String get showNearbyVolunteers;

  /// No description provided for @allowLocation.
  ///
  /// In en, this message translates to:
  /// **'Allow Location Access'**
  String get allowLocation;

  /// No description provided for @needLocationForHelp.
  ///
  /// In en, this message translates to:
  /// **'We need your location to show nearby help'**
  String get needLocationForHelp;

  /// No description provided for @enableLocation.
  ///
  /// In en, this message translates to:
  /// **'Enable Location'**
  String get enableLocation;

  /// No description provided for @enableLocationServices.
  ///
  /// In en, this message translates to:
  /// **'Please enable location services'**
  String get enableLocationServices;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get locationPermissionDenied;

  /// No description provided for @fireSafety1.
  ///
  /// In en, this message translates to:
  /// **'Stay calm and evacuate immediately.'**
  String get fireSafety1;

  /// No description provided for @fireSafety2.
  ///
  /// In en, this message translates to:
  /// **'Do not use elevators during fire.'**
  String get fireSafety2;

  /// No description provided for @fireSafety3.
  ///
  /// In en, this message translates to:
  /// **'Use a fire extinguisher if safe.'**
  String get fireSafety3;

  /// No description provided for @fireSafety4.
  ///
  /// In en, this message translates to:
  /// **'Close doors behind you to slow the spread of fire.'**
  String get fireSafety4;

  /// No description provided for @fireSafety5.
  ///
  /// In en, this message translates to:
  /// **'Never use elevators - use stairs only.'**
  String get fireSafety5;

  /// No description provided for @fireSafety6.
  ///
  /// In en, this message translates to:
  /// **'Check doors before opening; if hot, do not open them.'**
  String get fireSafety6;

  /// No description provided for @fireSafety7.
  ///
  /// In en, this message translates to:
  /// **'Go to the designated assembly point and do not return to the building.'**
  String get fireSafety7;

  /// No description provided for @firePrevention1.
  ///
  /// In en, this message translates to:
  /// **'Keep flammable materials away from heat sources'**
  String get firePrevention1;

  /// No description provided for @firePrevention2.
  ///
  /// In en, this message translates to:
  /// **'Install smoke detectors in your home'**
  String get firePrevention2;

  /// No description provided for @firePrevention3.
  ///
  /// In en, this message translates to:
  /// **'Have a fire extinguisher accessible'**
  String get firePrevention3;

  /// No description provided for @firePrevention4.
  ///
  /// In en, this message translates to:
  /// **'Do not leave cooking unattended'**
  String get firePrevention4;

  /// No description provided for @firePrevention5.
  ///
  /// In en, this message translates to:
  /// **'Avoid overloading electrical outlets'**
  String get firePrevention5;

  /// No description provided for @firePrevention6.
  ///
  /// In en, this message translates to:
  /// **'Educate children about fire safety'**
  String get firePrevention6;

  /// No description provided for @firePrevention7.
  ///
  /// In en, this message translates to:
  /// **'Plan and practice escape routes'**
  String get firePrevention7;

  /// No description provided for @trafficAccidentSafety1.
  ///
  /// In en, this message translates to:
  /// **'Check for injuries and call emergency services.'**
  String get trafficAccidentSafety1;

  /// No description provided for @trafficAccidentSafety2.
  ///
  /// In en, this message translates to:
  /// **'Move to a safe location if possible.'**
  String get trafficAccidentSafety2;

  /// No description provided for @trafficAccidentSafety3.
  ///
  /// In en, this message translates to:
  /// **'Provide first aid if trained.'**
  String get trafficAccidentSafety3;

  /// No description provided for @trafficAccidentSafety4.
  ///
  /// In en, this message translates to:
  /// **'Provide basic first aid if there are injuries.'**
  String get trafficAccidentSafety4;

  /// No description provided for @trafficAccidentSafety5.
  ///
  /// In en, this message translates to:
  /// **'Move away from traffic and wait for help.'**
  String get trafficAccidentSafety5;

  /// No description provided for @trafficAccidentSafety6.
  ///
  /// In en, this message translates to:
  /// **'Do not move injured people unless they are in immediate danger.'**
  String get trafficAccidentSafety6;

  /// No description provided for @trafficAccidentSafety7.
  ///
  /// In en, this message translates to:
  /// **'Record accident details for police and insurance purposes.'**
  String get trafficAccidentSafety7;

  /// No description provided for @floodSafety1.
  ///
  /// In en, this message translates to:
  /// **'Move to higher ground.'**
  String get floodSafety1;

  /// No description provided for @floodSafety2.
  ///
  /// In en, this message translates to:
  /// **'Avoid walking or driving through flood water.'**
  String get floodSafety2;

  /// No description provided for @floodSafety3.
  ///
  /// In en, this message translates to:
  /// **'Listen to official warnings.'**
  String get floodSafety3;

  /// No description provided for @floodSafety4.
  ///
  /// In en, this message translates to:
  /// **'Follow local authorities’ instructions.'**
  String get floodSafety4;

  /// No description provided for @floodSafety5.
  ///
  /// In en, this message translates to:
  /// **'Avoid touching electrical wires during floods.'**
  String get floodSafety5;

  /// No description provided for @floodSafety6.
  ///
  /// In en, this message translates to:
  /// **'Keep clean water and emergency food supplies.'**
  String get floodSafety6;

  /// No description provided for @floodSafety7.
  ///
  /// In en, this message translates to:
  /// **'If in a car, leave it immediately if submerged.'**
  String get floodSafety7;

  /// No description provided for @electricalSafety1.
  ///
  /// In en, this message translates to:
  /// **'Disconnect electricity from the main source if possible.'**
  String get electricalSafety1;

  /// No description provided for @electricalSafety2.
  ///
  /// In en, this message translates to:
  /// **'Do not touch exposed wires or wet electrical devices.'**
  String get electricalSafety2;

  /// No description provided for @electricalSafety3.
  ///
  /// In en, this message translates to:
  /// **'Use protective equipment when handling electricity.'**
  String get electricalSafety3;

  /// No description provided for @electricalSafety4.
  ///
  /// In en, this message translates to:
  /// **'Do not try to repair electricity yourself if unqualified.'**
  String get electricalSafety4;

  /// No description provided for @electricalSafety5.
  ///
  /// In en, this message translates to:
  /// **'Ensure you have an electrical fire extinguisher.'**
  String get electricalSafety5;

  /// No description provided for @electricalSafety6.
  ///
  /// In en, this message translates to:
  /// **'Report any electrical leak to authorities.'**
  String get electricalSafety6;

  /// No description provided for @electricalSafety7.
  ///
  /// In en, this message translates to:
  /// **'Avoid using electrical devices in high moisture conditions.'**
  String get electricalSafety7;

  /// No description provided for @noPreventionInfoAvailable.
  ///
  /// In en, this message translates to:
  /// **'No prevention information available for this accident type'**
  String get noPreventionInfoAvailable;

  /// No description provided for @noSafetyInfoAvailable.
  ///
  /// In en, this message translates to:
  /// **'No safety instructions available.'**
  String get noSafetyInfoAvailable;

  /// No description provided for @trafficAccidentPrevention1.
  ///
  /// In en, this message translates to:
  /// **'Always wear a seatbelt'**
  String get trafficAccidentPrevention1;

  /// No description provided for @trafficAccidentPrevention2.
  ///
  /// In en, this message translates to:
  /// **'Follow traffic rules'**
  String get trafficAccidentPrevention2;

  /// No description provided for @trafficAccidentPrevention3.
  ///
  /// In en, this message translates to:
  /// **'Avoid using mobile phones while driving'**
  String get trafficAccidentPrevention3;

  /// No description provided for @trafficAccidentPrevention4.
  ///
  /// In en, this message translates to:
  /// **'Do not drive under the influence'**
  String get trafficAccidentPrevention4;

  /// No description provided for @trafficAccidentPrevention5.
  ///
  /// In en, this message translates to:
  /// **'Keep a safe distance from other vehicles'**
  String get trafficAccidentPrevention5;

  /// No description provided for @trafficAccidentPrevention6.
  ///
  /// In en, this message translates to:
  /// **'Use indicators for turning'**
  String get trafficAccidentPrevention6;

  /// No description provided for @trafficAccidentPrevention7.
  ///
  /// In en, this message translates to:
  /// **'Check your vehicle regularly'**
  String get trafficAccidentPrevention7;

  /// No description provided for @fire.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get fire;

  /// No description provided for @trafficAccident.
  ///
  /// In en, this message translates to:
  /// **'Traffic Accident'**
  String get trafficAccident;

  /// No description provided for @earthquake.
  ///
  /// In en, this message translates to:
  /// **'Earthquake'**
  String get earthquake;

  /// No description provided for @flood.
  ///
  /// In en, this message translates to:
  /// **'Flood'**
  String get flood;

  /// No description provided for @buildingCollapse.
  ///
  /// In en, this message translates to:
  /// **'Building Collapse'**
  String get buildingCollapse;

  /// No description provided for @electricAccident.
  ///
  /// In en, this message translates to:
  /// **'Electric Accident'**
  String get electricAccident;

  /// No description provided for @injuries.
  ///
  /// In en, this message translates to:
  /// **'Injuries'**
  String get injuries;

  /// No description provided for @drowning.
  ///
  /// In en, this message translates to:
  /// **'Drowning'**
  String get drowning;

  /// No description provided for @poisoning.
  ///
  /// In en, this message translates to:
  /// **'Poisoning'**
  String get poisoning;

  /// No description provided for @suffocation.
  ///
  /// In en, this message translates to:
  /// **'Suffocation'**
  String get suffocation;

  /// No description provided for @earthquakeSafety1.
  ///
  /// In en, this message translates to:
  /// **'Drop, cover, and hold on.'**
  String get earthquakeSafety1;

  /// No description provided for @earthquakeSafety2.
  ///
  /// In en, this message translates to:
  /// **'Stay indoors until shaking stops.'**
  String get earthquakeSafety2;

  /// No description provided for @earthquakeSafety3.
  ///
  /// In en, this message translates to:
  /// **'Avoid windows and heavy furniture.'**
  String get earthquakeSafety3;

  /// No description provided for @earthquakeSafety4.
  ///
  /// In en, this message translates to:
  /// **'Evacuate the building carefully after shaking stops.'**
  String get earthquakeSafety4;

  /// No description provided for @earthquakeSafety5.
  ///
  /// In en, this message translates to:
  /// **'Avoid using elevators.'**
  String get earthquakeSafety5;

  /// No description provided for @earthquakeSafety6.
  ///
  /// In en, this message translates to:
  /// **'Check yourself and others for injuries.'**
  String get earthquakeSafety6;

  /// No description provided for @earthquakeSafety7.
  ///
  /// In en, this message translates to:
  /// **'Follow official emergency instructions.'**
  String get earthquakeSafety7;

  /// No description provided for @suffocationSafety1.
  ///
  /// In en, this message translates to:
  /// **'Call emergency services immediately.'**
  String get suffocationSafety1;

  /// No description provided for @suffocationSafety2.
  ///
  /// In en, this message translates to:
  /// **'Perform the Heimlich maneuver if trained.'**
  String get suffocationSafety2;

  /// No description provided for @suffocationSafety3.
  ///
  /// In en, this message translates to:
  /// **'Keep airway clear.'**
  String get suffocationSafety3;

  /// No description provided for @suffocationSafety4.
  ///
  /// In en, this message translates to:
  /// **'Perform CPR if necessary.'**
  String get suffocationSafety4;

  /// No description provided for @suffocationSafety5.
  ///
  /// In en, this message translates to:
  /// **'Keep the person calm and still.'**
  String get suffocationSafety5;

  /// No description provided for @suffocationSafety6.
  ///
  /// In en, this message translates to:
  /// **'Monitor breathing until help arrives.'**
  String get suffocationSafety6;

  /// No description provided for @suffocationSafety7.
  ///
  /// In en, this message translates to:
  /// **'Follow official emergency instructions.'**
  String get suffocationSafety7;

  /// No description provided for @buildingCollapseSafety1.
  ///
  /// In en, this message translates to:
  /// **'Evacuate carefully.'**
  String get buildingCollapseSafety1;

  /// No description provided for @buildingCollapseSafety2.
  ///
  /// In en, this message translates to:
  /// **'Avoid debris and falling objects.'**
  String get buildingCollapseSafety2;

  /// No description provided for @buildingCollapseSafety3.
  ///
  /// In en, this message translates to:
  /// **'Call emergency services immediately.'**
  String get buildingCollapseSafety3;

  /// No description provided for @electricShockSafety1.
  ///
  /// In en, this message translates to:
  /// **'Do not touch the victim if in contact with electricity.'**
  String get electricShockSafety1;

  /// No description provided for @electricShockSafety2.
  ///
  /// In en, this message translates to:
  /// **'Turn off the power source first.'**
  String get electricShockSafety2;

  /// No description provided for @electricShockSafety3.
  ///
  /// In en, this message translates to:
  /// **'Call emergency services.'**
  String get electricShockSafety3;

  /// No description provided for @drowningSafety1.
  ///
  /// In en, this message translates to:
  /// **'Call for help immediately.'**
  String get drowningSafety1;

  /// No description provided for @drowningSafety2.
  ///
  /// In en, this message translates to:
  /// **'Provide flotation devices.'**
  String get drowningSafety2;

  /// No description provided for @drowningSafety3.
  ///
  /// In en, this message translates to:
  /// **'Perform CPR if trained.'**
  String get drowningSafety3;

  /// No description provided for @poisoningSafety1.
  ///
  /// In en, this message translates to:
  /// **'Call poison control or emergency services.'**
  String get poisoningSafety1;

  /// No description provided for @poisoningSafety2.
  ///
  /// In en, this message translates to:
  /// **'Do not induce vomiting unless instructed.'**
  String get poisoningSafety2;

  /// No description provided for @poisoningSafety3.
  ///
  /// In en, this message translates to:
  /// **'Provide information about the substance.'**
  String get poisoningSafety3;

  /// No description provided for @injuriesSafety1.
  ///
  /// In en, this message translates to:
  /// **'Stop any bleeding using pressure.'**
  String get injuriesSafety1;

  /// No description provided for @injuriesSafety2.
  ///
  /// In en, this message translates to:
  /// **'Keep the injured part still.'**
  String get injuriesSafety2;

  /// No description provided for @injuriesSafety3.
  ///
  /// In en, this message translates to:
  /// **'Seek medical attention.'**
  String get injuriesSafety3;

  /// No description provided for @landslideSafety1.
  ///
  /// In en, this message translates to:
  /// **'Move away from the slide path.'**
  String get landslideSafety1;

  /// No description provided for @landslideSafety2.
  ///
  /// In en, this message translates to:
  /// **'Stay alert for further movement.'**
  String get landslideSafety2;

  /// No description provided for @landslideSafety3.
  ///
  /// In en, this message translates to:
  /// **'Do not enter affected areas.'**
  String get landslideSafety3;

  /// No description provided for @stormSafety1.
  ///
  /// In en, this message translates to:
  /// **'Stay indoors and away from windows.'**
  String get stormSafety1;

  /// No description provided for @stormSafety2.
  ///
  /// In en, this message translates to:
  /// **'Avoid using electrical appliances.'**
  String get stormSafety2;

  /// No description provided for @stormSafety3.
  ///
  /// In en, this message translates to:
  /// **'Follow weather alerts.'**
  String get stormSafety3;

  /// No description provided for @explosionSafety1.
  ///
  /// In en, this message translates to:
  /// **'Take cover immediately.'**
  String get explosionSafety1;

  /// No description provided for @explosionSafety2.
  ///
  /// In en, this message translates to:
  /// **'Evacuate the area once safe.'**
  String get explosionSafety2;

  /// No description provided for @explosionSafety3.
  ///
  /// In en, this message translates to:
  /// **'Call emergency services.'**
  String get explosionSafety3;

  /// No description provided for @chemicalSpillSafety1.
  ///
  /// In en, this message translates to:
  /// **'Avoid contact with chemicals.'**
  String get chemicalSpillSafety1;

  /// No description provided for @chemicalSpillSafety2.
  ///
  /// In en, this message translates to:
  /// **'Ventilate the area if safe.'**
  String get chemicalSpillSafety2;

  /// No description provided for @chemicalSpillSafety3.
  ///
  /// In en, this message translates to:
  /// **'Call emergency services.'**
  String get chemicalSpillSafety3;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @passwordValidator.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordValidator;

  /// No description provided for @passwordLengthValidator.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordLengthValidator;

  /// No description provided for @roleSelectionHeader.
  ///
  /// In en, this message translates to:
  /// **'What do you want to do?'**
  String get roleSelectionHeader;

  /// No description provided for @needHelpCard.
  ///
  /// In en, this message translates to:
  /// **'Find the nearest helper'**
  String get needHelpCard;

  /// No description provided for @volunteerCard.
  ///
  /// In en, this message translates to:
  /// **'I want to volunteer!'**
  String get volunteerCard;

  /// No description provided for @exploreCard.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get exploreCard;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @chooseNearestVolunteer.
  ///
  /// In en, this message translates to:
  /// **'Choose the nearest volunteer'**
  String get chooseNearestVolunteer;

  /// No description provided for @suffocationPrevention1.
  ///
  /// In en, this message translates to:
  /// **'Keep small objects away from children'**
  String get suffocationPrevention1;

  /// No description provided for @suffocationPrevention2.
  ///
  /// In en, this message translates to:
  /// **'Avoid loose bedding for infants'**
  String get suffocationPrevention2;

  /// No description provided for @suffocationPrevention3.
  ///
  /// In en, this message translates to:
  /// **'Do not tie cords around necks'**
  String get suffocationPrevention3;

  /// No description provided for @suffocationPrevention4.
  ///
  /// In en, this message translates to:
  /// **'Supervise children during meals'**
  String get suffocationPrevention4;

  /// No description provided for @suffocationPrevention5.
  ///
  /// In en, this message translates to:
  /// **'Use age-appropriate toys'**
  String get suffocationPrevention5;

  /// No description provided for @drowningPrevention1.
  ///
  /// In en, this message translates to:
  /// **'Never leave children unattended near water'**
  String get drowningPrevention1;

  /// No description provided for @drowningPrevention2.
  ///
  /// In en, this message translates to:
  /// **'Learn CPR and first aid'**
  String get drowningPrevention2;

  /// No description provided for @drowningPrevention3.
  ///
  /// In en, this message translates to:
  /// **'Use life jackets when boating'**
  String get drowningPrevention3;

  /// No description provided for @drowningPrevention4.
  ///
  /// In en, this message translates to:
  /// **'Do not swim alone'**
  String get drowningPrevention4;

  /// No description provided for @drowningPrevention5.
  ///
  /// In en, this message translates to:
  /// **'Avoid alcohol before swimming'**
  String get drowningPrevention5;

  /// No description provided for @burnPrevention1.
  ///
  /// In en, this message translates to:
  /// **'Handle hot liquids carefully'**
  String get burnPrevention1;

  /// No description provided for @burnPrevention2.
  ///
  /// In en, this message translates to:
  /// **'Use oven mitts when cooking'**
  String get burnPrevention2;

  /// No description provided for @burnPrevention3.
  ///
  /// In en, this message translates to:
  /// **'Keep children away from hot surfaces'**
  String get burnPrevention3;

  /// No description provided for @burnPrevention4.
  ///
  /// In en, this message translates to:
  /// **'Check water temperature before bathing'**
  String get burnPrevention4;

  /// No description provided for @burnPrevention5.
  ///
  /// In en, this message translates to:
  /// **'Avoid firework mishandling'**
  String get burnPrevention5;

  /// No description provided for @fracturePrevention1.
  ///
  /// In en, this message translates to:
  /// **'Wear protective gear during sports'**
  String get fracturePrevention1;

  /// No description provided for @fracturePrevention2.
  ///
  /// In en, this message translates to:
  /// **'Use handrails on stairs'**
  String get fracturePrevention2;

  /// No description provided for @fracturePrevention3.
  ///
  /// In en, this message translates to:
  /// **'Keep floors clear of obstacles'**
  String get fracturePrevention3;

  /// No description provided for @fracturePrevention4.
  ///
  /// In en, this message translates to:
  /// **'Avoid slippery surfaces'**
  String get fracturePrevention4;

  /// No description provided for @fracturePrevention5.
  ///
  /// In en, this message translates to:
  /// **'Ensure proper lighting'**
  String get fracturePrevention5;

  /// No description provided for @poisoningPrevention1.
  ///
  /// In en, this message translates to:
  /// **'Keep chemicals out of children\'s reach'**
  String get poisoningPrevention1;

  /// No description provided for @poisoningPrevention2.
  ///
  /// In en, this message translates to:
  /// **'Do not mix household chemicals'**
  String get poisoningPrevention2;

  /// No description provided for @poisoningPrevention3.
  ///
  /// In en, this message translates to:
  /// **'Store medicines safely'**
  String get poisoningPrevention3;

  /// No description provided for @poisoningPrevention4.
  ///
  /// In en, this message translates to:
  /// **'Read labels before consumption'**
  String get poisoningPrevention4;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome {name}'**
  String welcomeMessage(Object name);

  /// No description provided for @errorFetchingVolunteers.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while fetching volunteers.'**
  String get errorFetchingVolunteers;

  /// No description provided for @noVolunteersFound.
  ///
  /// In en, this message translates to:
  /// **'No volunteers found'**
  String get noVolunteersFound;

  /// No description provided for @selectWilaya.
  ///
  /// In en, this message translates to:
  /// **'Select a wilaya'**
  String get selectWilaya;

  /// No description provided for @clearSelection.
  ///
  /// In en, this message translates to:
  /// **'Clear selection'**
  String get clearSelection;

  /// No description provided for @locationEnableTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow location access'**
  String get locationEnableTitle;

  /// No description provided for @locationEnableSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We need your location to find the nearest rescuer'**
  String get locationEnableSubtitle;

  /// No description provided for @activateLocation.
  ///
  /// In en, this message translates to:
  /// **'Enable location'**
  String get activateLocation;

  /// No description provided for @manualWilayaChoice.
  ///
  /// In en, this message translates to:
  /// **'Choose wilaya manually'**
  String get manualWilayaChoice;

  /// No description provided for @viewNearbyVolunteers.
  ///
  /// In en, this message translates to:
  /// **'View nearby volunteers'**
  String get viewNearbyVolunteers;

  /// No description provided for @snackLocationActivated.
  ///
  /// In en, this message translates to:
  /// **'Location enabled ✓\\nWilaya:'**
  String get snackLocationActivated;

  /// No description provided for @snackPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get snackPermissionDenied;

  /// No description provided for @snackServiceDisabled.
  ///
  /// In en, this message translates to:
  /// **'Please enable location services'**
  String get snackServiceDisabled;

  /// No description provided for @snackError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred:'**
  String get snackError;

  /// No description provided for @snackManualChoice.
  ///
  /// In en, this message translates to:
  /// **'Unable to detect wilaya — choose it manually'**
  String get snackManualChoice;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @nearestVolunteersTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the nearest rescuer'**
  String get nearestVolunteersTitle;

  /// No description provided for @selectedWilaya.
  ///
  /// In en, this message translates to:
  /// **'Wilaya:'**
  String get selectedWilaya;

  /// No description provided for @volunteersCount.
  ///
  /// In en, this message translates to:
  /// **'{count} volunteers'**
  String volunteersCount(Object count);

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noVolunteers.
  ///
  /// In en, this message translates to:
  /// **'No volunteers in this wilaya.'**
  String get noVolunteers;
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
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
