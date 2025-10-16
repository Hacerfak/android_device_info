// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Device Info';

  @override
  String get detailedInfo => 'Detailed Information';

  @override
  String get about => 'About';

  @override
  String get loading => 'Loading information...';

  @override
  String get platform => 'Platform';

  @override
  String platformNotImplemented(String platformName) {
    return 'Not implemented for $platformName';
  }

  @override
  String get error => 'Error';

  @override
  String get errorFailedToGetInfo => 'Failed to get device information.';

  @override
  String get softwareInfo => 'Software Information';

  @override
  String get osVersion => 'OS Version';

  @override
  String get sdkApiLevel => 'SDK API Level';

  @override
  String get baseOSVersion => 'Base OS Version';

  @override
  String get osCodename => 'OS Codename';

  @override
  String get buildId => 'Build ID';

  @override
  String get buildTags => 'Build Tags';

  @override
  String get buildType => 'Build Type';

  @override
  String get hardwareInfo => 'Hardware Information';

  @override
  String get manufacturer => 'Manufacturer';

  @override
  String get brand => 'Brand';

  @override
  String get model => 'Model';

  @override
  String get device => 'Device';

  @override
  String get product => 'Product';

  @override
  String get hardware => 'Hardware';

  @override
  String get board => 'Board';

  @override
  String get isPhysical => 'Is physical device?';

  @override
  String get systemFeatures => 'System Features';

  @override
  String get displayInfo => 'Display Information';

  @override
  String get logicalResolution => 'Resolution (logical pixels)';

  @override
  String get devicePixelRatio => 'Device Pixel Ratio';

  @override
  String get physicalResolution => 'Resolution (physical pixels)';

  @override
  String get textScaleFactor => 'Text Scale Factor';

  @override
  String get orientation => 'Orientation';

  @override
  String get sensorsRealTime => 'Sensors (real-time)';

  @override
  String get waitingForData => 'Waiting for data...';

  @override
  String get accelerometer => 'Accelerometer (x, y, z)';

  @override
  String get userAccelerometer => 'User Accelerometer (x, y, z)';

  @override
  String get gyroscope => 'Gyroscope (x, y, z)';

  @override
  String get magnetometer => 'Magnetometer (x, y, z)';

  @override
  String get barometer => 'Barometer (hPa)';

  @override
  String get appName => 'App Name';

  @override
  String get version => 'Version';

  @override
  String get buildNumber => 'Build Number';

  @override
  String get developer => 'Developer';

  @override
  String get dependencies => 'Dependencies';
}
