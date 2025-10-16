// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Informações do Dispositivo';

  @override
  String get detailedInfo => 'Informações Detalhadas';

  @override
  String get about => 'Sobre';

  @override
  String get loading => 'Carregando informações...';

  @override
  String get platform => 'Plataforma';

  @override
  String platformNotImplemented(String platformName) {
    return 'Não implementado para $platformName';
  }

  @override
  String get error => 'Erro';

  @override
  String get errorFailedToGetInfo =>
      'Falha ao obter as informações do dispositivo.';

  @override
  String get softwareInfo => 'Informações do Software';

  @override
  String get osVersion => 'Versão do SO';

  @override
  String get sdkApiLevel => 'Nível da API do SDK';

  @override
  String get baseOSVersion => 'Versão Base do SO';

  @override
  String get osCodename => 'Codinome da Versão';

  @override
  String get buildId => 'ID de Build';

  @override
  String get buildTags => 'Tags de Build';

  @override
  String get buildType => 'Tipo de Build';

  @override
  String get hardwareInfo => 'Informações do Hardware';

  @override
  String get manufacturer => 'Fabricante';

  @override
  String get brand => 'Marca';

  @override
  String get model => 'Modelo';

  @override
  String get device => 'Dispositivo';

  @override
  String get product => 'Produto';

  @override
  String get hardware => 'Hardware';

  @override
  String get board => 'Placa';

  @override
  String get isPhysical => 'É um dispositivo físico?';

  @override
  String get systemFeatures => 'Recursos do Sistema';

  @override
  String get displayInfo => 'Informações da Tela';

  @override
  String get logicalResolution => 'Resolução (pixels lógicos)';

  @override
  String get devicePixelRatio => 'Proporção de Pixels do Dispositivo';

  @override
  String get physicalResolution => 'Resolução (pixels físicos)';

  @override
  String get textScaleFactor => 'Fator de Escala de Texto';

  @override
  String get orientation => 'Orientação';

  @override
  String get sensorsRealTime => 'Sensores (em tempo real)';

  @override
  String get waitingForData => 'Aguardando dados...';

  @override
  String get accelerometer => 'Acelerômetro (x, y, z)';

  @override
  String get userAccelerometer => 'Acelerômetro do Usuário (x, y, z)';

  @override
  String get gyroscope => 'Giroscópio (x, y, z)';

  @override
  String get magnetometer => 'Magnetômetro (x, y, z)';

  @override
  String get barometer => 'Barômetro (hPa)';

  @override
  String get appName => 'Nome do App';

  @override
  String get version => 'Versão';

  @override
  String get buildNumber => 'Número da Build';

  @override
  String get developer => 'Desenvolvedor';

  @override
  String get dependencies => 'Dependências';
}
