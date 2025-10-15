// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Info del Dispositivo';

  @override
  String get detailedInfo => 'Información Detallada';

  @override
  String get about => 'Acerca de';

  @override
  String get loading => 'Cargando...';

  @override
  String get errorFailedToGetInfo =>
      'No se pudo obtener la información del dispositivo.';

  @override
  String get platform => 'Plataforma';

  @override
  String platformNotImplemented(String platformName) {
    return '$platformName (no implementado)';
  }

  @override
  String get error => 'Error';

  @override
  String get errorDetails => 'Detalles';

  @override
  String get sensorsRealTime => 'Sensores (tiempo real)';

  @override
  String get waitingForData => 'Esperando datos...';

  @override
  String get accelerometer => 'Acelerómetro (x, y, z)';

  @override
  String get userAccelerometer => 'Acelerómetro de Usuario (x, y, z)';

  @override
  String get gyroscope => 'Giroscopio (x, y, z)';

  @override
  String get magnetometer => 'Magnetómetro (x, y, z)';

  @override
  String get gravity => 'Gravedad (x, y, z)';

  @override
  String get softwareInfo => 'Información de Software';

  @override
  String get osVersion => 'Versión del SO';

  @override
  String get sdkApiLevel => 'Nivel de API del SDK';

  @override
  String get baseOSVersion => 'Versión Base del SO';

  @override
  String get osCodename => 'Nombre Clave de Versión';

  @override
  String get buildId => 'ID de Build';

  @override
  String get buildTags => 'Etiquetas de Build';

  @override
  String get buildType => 'Tipo de Build';

  @override
  String get hardwareInfo => 'Información de Hardware';

  @override
  String get manufacturer => 'Fabricante';

  @override
  String get brand => 'Marca';

  @override
  String get model => 'Modelo';

  @override
  String get device => 'Dispositivo';

  @override
  String get product => 'Producto';

  @override
  String get hardware => 'Hardware';

  @override
  String get board => 'Placa';

  @override
  String get isPhysical => '¿Es un dispositivo físico?';

  @override
  String get systemFeatures => 'Características del Sistema';

  @override
  String get displayInfo => 'Información de la Pantalla';

  @override
  String get logicalResolution => 'Resolución (píxeles lógicos)';

  @override
  String get devicePixelRatio => 'Relación de Píxeles del Dispositivo';

  @override
  String get physicalResolution => 'Resolución (píxeles físicos)';

  @override
  String get textScaleFactor => 'Factor de Escala de Texto';

  @override
  String get orientation => 'Orientación';

  @override
  String get appName => 'Nombre de la App';

  @override
  String get version => 'Versión';

  @override
  String get buildNumber => 'Número de Build';

  @override
  String get packageName => 'Nombre del Paquete';

  @override
  String get developer => 'Desarrollador';

  @override
  String get dependencies => 'Dependencias';
}
