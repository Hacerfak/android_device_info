import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Informações do Dispositivo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const DeviceInfoScreen(),
    );
  }
}

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  // Mapa para armazenar os dados do dispositivo, agora categorizados
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  final List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  // Use um ID de teste para evitar problemas com a política do AdMob
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-4241608895500197/3480394281'
      : 'ca-app-pub-4241608895500197/8905424431';

  @override
  void initState() {
    super.initState();
    _initDeviceInfo();
    _initSensors();
    _loadBannerAd();
    // Adiciona um callback para buscar as infos da tela após o primeiro frame ser construído
    WidgetsBinding.instance.addPostFrameCallback((_) => _initDisplayInfo());
  }

  // Função para carregar as informações do dispositivo
  Future<void> _initDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> data = <String, dynamic>{};
    try {
      if (Platform.isAndroid) {
        data = await _getAndroidDeviceInfo(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        data = {
          'Plataforma': {'Nome': 'iOS (não implementado)'},
        };
      }
    } catch (e) {
      data = <String, dynamic>{
        'Erro': {'Detalhes': 'Falha ao obter informações do dispositivo.'},
      };
    }

    if (mounted) {
      setState(() {
        _deviceData = data;
        // Inicializa a categoria de sensores
        if (!_deviceData.containsKey('Sensores (em tempo real)')) {
          _deviceData['Sensores (em tempo real)'] = <String, String>{
            'Acelerômetro (x, y, z)': 'Aguardando dados...',
            'Acelerômetro do Usuário (x, y, z)': 'Aguardando dados...',
            'Giroscópio (x, y, z)': 'Aguardando dados...',
            'Magnetômetro (x, y, z)': 'Aguardando dados...',
          };
        }
      });
    }
  }

  // Nova função para buscar as informações da tela de forma segura
  void _initDisplayInfo() {
    if (!mounted || context == null) return;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final pixelRatio = mediaQuery.devicePixelRatio;
    final physicalWidth = size.width * pixelRatio;
    final physicalHeight = size.height * pixelRatio;

    final Map<String, dynamic> displayData = {
      'Informações da Tela': <String, dynamic>{
        'Resolução (pixels lógicos)':
            '${size.width.toStringAsFixed(0)} x ${size.height.toStringAsFixed(0)}',
        'Proporção de Pixels do Dispositivo': pixelRatio.toStringAsFixed(2),
        'Resolução (pixels físicos)':
            '${physicalWidth.toStringAsFixed(0)} x ${physicalHeight.toStringAsFixed(0)}',
        'Fator de Escala de Texto': mediaQuery.textScaleFactor.toStringAsFixed(
          2,
        ),
        'Orientação': mediaQuery.orientation.toString().split('.').last,
      },
    };

    setState(() {
      // Mescla os dados da tela com os dados já existentes do dispositivo
      _deviceData.addAll(displayData);
    });
  }

  // Mapeia os dados do Android para um formato categorizado e legível
  Future<Map<String, dynamic>> _getAndroidDeviceInfo(
    AndroidDeviceInfo build,
  ) async {
    return <String, dynamic>{
      'Informações do Software': <String, dynamic>{
        'Versão do SO': build.version.release,
        'Nível da API do SDK': build.version.sdkInt,
        'Versão Base do SO': build.version.baseOS ?? 'N/A',
        'Codinome da Versão': build.version.codename,
        'ID de Build': build.id,
        'Tags de Build': build.tags,
        'Tipo de Build': build.type,
      },
      'Informações do Hardware': <String, dynamic>{
        'Fabricante': build.manufacturer,
        'Marca': build.brand,
        'Modelo': build.model,
        'Dispositivo': build.device,
        'Produto': build.product,
        'Hardware': build.hardware,
        'Placa': build.board,
        'É um dispositivo físico?': build.isPhysicalDevice,
        'Recursos do Sistema':
            build.systemFeatures.take(5).join(', ') +
            '...', // Limita para visualização
      },
    };
  }

  // Inicializa os listeners para os sensores
  void _initSensors() {
    _streamSubscriptions.add(
      accelerometerEventStream().listen((AccelerometerEvent event) {
        if (mounted) {
          setState(() {
            _deviceData['Sensores (em tempo real)']?['Acelerômetro (x, y, z)'] =
                '${event.x.toStringAsFixed(2)}, ${event.y.toStringAsFixed(2)}, ${event.z.toStringAsFixed(2)}';
          });
        }
      }),
    );
    _streamSubscriptions.add(
      userAccelerometerEventStream().listen((UserAccelerometerEvent event) {
        if (mounted) {
          setState(() {
            _deviceData['Sensores (em tempo real)']?['Acelerômetro do Usuário (x, y, z)'] =
                '${event.x.toStringAsFixed(2)}, ${event.y.toStringAsFixed(2)}, ${event.z.toStringAsFixed(2)}';
          });
        }
      }),
    );
    _streamSubscriptions.add(
      gyroscopeEventStream().listen((GyroscopeEvent event) {
        if (mounted) {
          setState(() {
            _deviceData['Sensores (em tempo real)']?['Giroscópio (x, y, z)'] =
                '${event.x.toStringAsFixed(2)}, ${event.y.toStringAsFixed(2)}, ${event.z.toStringAsFixed(2)}';
          });
        }
      }),
    );
    _streamSubscriptions.add(
      magnetometerEventStream().listen((MagnetometerEvent event) {
        if (mounted) {
          setState(() {
            _deviceData['Sensores (em tempo real)']?['Magnetômetro (x, y, z)'] =
                '${event.x.toStringAsFixed(2)}, ${event.y.toStringAsFixed(2)}, ${event.z.toStringAsFixed(2)}';
          });
        }
      }),
    );
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() => _isAdLoaded = true),
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    final categories = _deviceData.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações Detalhadas'),
        centerTitle: true,
      ),
      body: _deviceData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final categoryTitle = category.key;
                final categoryItems = (category.value as Map<String, dynamic>)
                    .entries
                    .toList();

                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 8.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ExpansionTile(
                    initiallyExpanded:
                        categoryTitle.contains('Software') ||
                        categoryTitle.contains('Tela'),
                    title: Text(
                      categoryTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.indigo,
                      ),
                    ),
                    children: categoryItems.map((item) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 24.0,
                        ),
                        title: Text(
                          item.key,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          '${item.value}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
      bottomNavigationBar: _isAdLoaded && _bannerAd != null
          ? SafeArea(
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }
}
