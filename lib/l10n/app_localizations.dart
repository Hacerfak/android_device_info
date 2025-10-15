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
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'Informações do Dispositivo'**
  String get appTitle;

  /// No description provided for @detailedInfo.
  ///
  /// In pt, this message translates to:
  /// **'Informações Detalhadas'**
  String get detailedInfo;

  /// No description provided for @about.
  ///
  /// In pt, this message translates to:
  /// **'Sobre'**
  String get about;

  /// No description provided for @loading.
  ///
  /// In pt, this message translates to:
  /// **'Carregando...'**
  String get loading;

  /// No description provided for @errorFailedToGetInfo.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao obter informações do dispositivo.'**
  String get errorFailedToGetInfo;

  /// No description provided for @platform.
  ///
  /// In pt, this message translates to:
  /// **'Plataforma'**
  String get platform;

  /// Text showing the platform is not implemented
  ///
  /// In pt, this message translates to:
  /// **'{platformName} (não implementado)'**
  String platformNotImplemented(String platformName);

  /// No description provided for @error.
  ///
  /// In pt, this message translates to:
  /// **'Erro'**
  String get error;

  /// No description provided for @errorDetails.
  ///
  /// In pt, this message translates to:
  /// **'Detalhes'**
  String get errorDetails;

  /// No description provided for @sensorsRealTime.
  ///
  /// In pt, this message translates to:
  /// **'Sensores (em tempo real)'**
  String get sensorsRealTime;

  /// No description provided for @waitingForData.
  ///
  /// In pt, this message translates to:
  /// **'Aguardando dados...'**
  String get waitingForData;

  /// No description provided for @accelerometer.
  ///
  /// In pt, this message translates to:
  /// **'Acelerômetro (x, y, z)'**
  String get accelerometer;

  /// No description provided for @userAccelerometer.
  ///
  /// In pt, this message translates to:
  /// **'Acelerômetro do Usuário (x, y, z)'**
  String get userAccelerometer;

  /// No description provided for @gyroscope.
  ///
  /// In pt, this message translates to:
  /// **'Giroscópio (x, y, z)'**
  String get gyroscope;

  /// No description provided for @magnetometer.
  ///
  /// In pt, this message translates to:
  /// **'Magnetômetro (x, y, z)'**
  String get magnetometer;

  /// No description provided for @gravity.
  ///
  /// In pt, this message translates to:
  /// **'Gravidade (x, y, z)'**
  String get gravity;

  /// No description provided for @softwareInfo.
  ///
  /// In pt, this message translates to:
  /// **'Informações do Software'**
  String get softwareInfo;

  /// No description provided for @osVersion.
  ///
  /// In pt, this message translates to:
  /// **'Versão do SO'**
  String get osVersion;

  /// No description provided for @sdkApiLevel.
  ///
  /// In pt, this message translates to:
  /// **'Nível da API do SDK'**
  String get sdkApiLevel;

  /// No description provided for @baseOSVersion.
  ///
  /// In pt, this message translates to:
  /// **'Versão Base do SO'**
  String get baseOSVersion;

  /// No description provided for @osCodename.
  ///
  /// In pt, this message translates to:
  /// **'Codinome da Versão'**
  String get osCodename;

  /// No description provided for @buildId.
  ///
  /// In pt, this message translates to:
  /// **'ID de Build'**
  String get buildId;

  /// No description provided for @buildTags.
  ///
  /// In pt, this message translates to:
  /// **'Tags de Build'**
  String get buildTags;

  /// No description provided for @buildType.
  ///
  /// In pt, this message translates to:
  /// **'Tipo de Build'**
  String get buildType;

  /// No description provided for @hardwareInfo.
  ///
  /// In pt, this message translates to:
  /// **'Informações do Hardware'**
  String get hardwareInfo;

  /// No description provided for @manufacturer.
  ///
  /// In pt, this message translates to:
  /// **'Fabricante'**
  String get manufacturer;

  /// No description provided for @brand.
  ///
  /// In pt, this message translates to:
  /// **'Marca'**
  String get brand;

  /// No description provided for @model.
  ///
  /// In pt, this message translates to:
  /// **'Modelo'**
  String get model;

  /// No description provided for @device.
  ///
  /// In pt, this message translates to:
  /// **'Dispositivo'**
  String get device;

  /// No description provided for @product.
  ///
  /// In pt, this message translates to:
  /// **'Produto'**
  String get product;

  /// No description provided for @hardware.
  ///
  /// In pt, this message translates to:
  /// **'Hardware'**
  String get hardware;

  /// No description provided for @board.
  ///
  /// In pt, this message translates to:
  /// **'Placa'**
  String get board;

  /// No description provided for @isPhysical.
  ///
  /// In pt, this message translates to:
  /// **'É um dispositivo físico?'**
  String get isPhysical;

  /// No description provided for @systemFeatures.
  ///
  /// In pt, this message translates to:
  /// **'Recursos do Sistema'**
  String get systemFeatures;

  /// No description provided for @displayInfo.
  ///
  /// In pt, this message translates to:
  /// **'Informações da Tela'**
  String get displayInfo;

  /// No description provided for @logicalResolution.
  ///
  /// In pt, this message translates to:
  /// **'Resolução (pixels lógicos)'**
  String get logicalResolution;

  /// No description provided for @devicePixelRatio.
  ///
  /// In pt, this message translates to:
  /// **'Proporção de Pixels do Dispositivo'**
  String get devicePixelRatio;

  /// No description provided for @physicalResolution.
  ///
  /// In pt, this message translates to:
  /// **'Resolução (pixels físicos)'**
  String get physicalResolution;

  /// No description provided for @textScaleFactor.
  ///
  /// In pt, this message translates to:
  /// **'Fator de Escala de Texto'**
  String get textScaleFactor;

  /// No description provided for @orientation.
  ///
  /// In pt, this message translates to:
  /// **'Orientação'**
  String get orientation;

  /// No description provided for @appName.
  ///
  /// In pt, this message translates to:
  /// **'Nome do App'**
  String get appName;

  /// No description provided for @version.
  ///
  /// In pt, this message translates to:
  /// **'Versão'**
  String get version;

  /// No description provided for @buildNumber.
  ///
  /// In pt, this message translates to:
  /// **'Número da Build'**
  String get buildNumber;

  /// No description provided for @packageName.
  ///
  /// In pt, this message translates to:
  /// **'Nome do Pacote'**
  String get packageName;

  /// No description provided for @developer.
  ///
  /// In pt, this message translates to:
  /// **'Desenvolvedor'**
  String get developer;

  /// No description provided for @dependencies.
  ///
  /// In pt, this message translates to:
  /// **'Dependências'**
  String get dependencies;
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
