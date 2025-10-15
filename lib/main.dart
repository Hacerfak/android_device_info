import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'l10n/app_localizations.dart';

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
      // Título do app, agora usando a localização
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,

      // Configuração de localização
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

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
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  final List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-4241608895500197/3480394281'
      : 'ca-app-pub-4241608895500197/8905424431';

  late AppLocalizations _l10n;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _l10n = AppLocalizations.of(context)!;
    // Carrega as informações apenas uma vez
    if (_deviceData.isEmpty) {
      _initDeviceInfo();
      _initSensors();
      _loadBannerAd();
      WidgetsBinding.instance.addPostFrameCallback((_) => _initDisplayInfo());
    }
  }

  Future<void> _initDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> data = <String, dynamic>{};
    try {
      if (Platform.isAndroid) {
        data = await _getAndroidDeviceInfo(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        data = {
          _l10n.platform: {'Nome': _l10n.platformNotImplemented('iOS')},
        };
      }
    } catch (e) {
      data = <String, dynamic>{
        _l10n.error: {'Detalhes': _l10n.errorFailedToGetInfo},
      };
    }

    if (mounted) {
      setState(() {
        _deviceData = data;
        if (!_deviceData.containsKey(_l10n.sensorsRealTime)) {
          _deviceData[_l10n.sensorsRealTime] = <String, String>{
            _l10n.accelerometer: _l10n.waitingForData,
            _l10n.userAccelerometer: _l10n.waitingForData,
            _l10n.gyroscope: _l10n.waitingForData,
            _l10n.magnetometer: _l10n.waitingForData,
          };
        }
      });
    }
  }

  void _initDisplayInfo() {
    if (!mounted) return;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final pixelRatio = mediaQuery.devicePixelRatio;
    final physicalWidth = size.width * pixelRatio;
    final physicalHeight = size.height * pixelRatio;

    final Map<String, dynamic> displayData = {
      _l10n.displayInfo: <String, dynamic>{
        _l10n.logicalResolution:
            '${size.width.toStringAsFixed(0)} x ${size.height.toStringAsFixed(0)}',
        _l10n.devicePixelRatio: pixelRatio.toStringAsFixed(2),
        _l10n.physicalResolution:
            '${physicalWidth.toStringAsFixed(0)} x ${physicalHeight.toStringAsFixed(0)}',
        _l10n.textScaleFactor: mediaQuery.textScaleFactor.toStringAsFixed(2),
        _l10n.orientation: mediaQuery.orientation.toString().split('.').last,
      },
    };

    setState(() {
      _deviceData.addAll(displayData);
    });
  }

  Future<Map<String, dynamic>> _getAndroidDeviceInfo(
    AndroidDeviceInfo build,
  ) async {
    return <String, dynamic>{
      _l10n.softwareInfo: <String, dynamic>{
        _l10n.osVersion: build.version.release,
        _l10n.sdkApiLevel: build.version.sdkInt,
        _l10n.baseOSVersion: build.version.baseOS ?? 'N/A',
        _l10n.osCodename: build.version.codename,
        _l10n.buildId: build.id,
        _l10n.buildTags: build.tags,
        _l10n.buildType: build.type,
      },
      _l10n.hardwareInfo: <String, dynamic>{
        _l10n.manufacturer: build.manufacturer,
        _l10n.brand: build.brand,
        _l10n.model: build.model,
        _l10n.device: build.device,
        _l10n.product: build.product,
        _l10n.hardware: build.hardware,
        _l10n.board: build.board,
        _l10n.isPhysical: build.isPhysicalDevice,
        _l10n.systemFeatures: build.systemFeatures.take(5).join(', ') + '...',
      },
    };
  }

  void _initSensors() {
    _streamSubscriptions.add(
      accelerometerEventStream().listen((AccelerometerEvent event) {
        if (mounted) {
          setState(() {
            _deviceData[_l10n.sensorsRealTime]?[_l10n.accelerometer] =
                '${event.x.toStringAsFixed(2)}, ${event.y.toStringAsFixed(2)}, ${event.z.toStringAsFixed(2)}';
          });
        }
      }),
    );
    _streamSubscriptions.add(
      userAccelerometerEventStream().listen((UserAccelerometerEvent event) {
        if (mounted) {
          setState(() {
            _deviceData[_l10n.sensorsRealTime]?[_l10n.userAccelerometer] =
                '${event.x.toStringAsFixed(2)}, ${event.y.toStringAsFixed(2)}, ${event.z.toStringAsFixed(2)}';
          });
        }
      }),
    );
    _streamSubscriptions.add(
      gyroscopeEventStream().listen((GyroscopeEvent event) {
        if (mounted) {
          setState(() {
            _deviceData[_l10n.sensorsRealTime]?[_l10n.gyroscope] =
                '${event.x.toStringAsFixed(2)}, ${event.y.toStringAsFixed(2)}, ${event.z.toStringAsFixed(2)}';
          });
        }
      }),
    );
    _streamSubscriptions.add(
      magnetometerEventStream().listen((MagnetometerEvent event) {
        if (mounted) {
          setState(() {
            _deviceData[_l10n.sensorsRealTime]?[_l10n.magnetometer] =
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
    // Garante que o l10n está inicializado
    _l10n = AppLocalizations.of(context)!;
    final categories = _deviceData.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(_l10n.detailedInfo),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
      body: _deviceData.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(_l10n.loading),
                ],
              ),
            )
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
                        categoryTitle == _l10n.softwareInfo ||
                        categoryTitle == _l10n.displayInfo,
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

// Tela "Sobre" atualizada
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.about), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        children: <Widget>[
          const SizedBox(height: 20),
          // Imagem do desenvolvedor (placeholder)
          CircleAvatar(
            radius: 50,
            // Certifique-se de que a imagem está em 'assets/profile.jpg'
            backgroundImage: const AssetImage('assets/profile.jpg'),
            backgroundColor: Colors.indigo.shade100,
          ),
          const SizedBox(height: 16),
          // Nome do desenvolvedor
          Text(
            'Eder Gross Cichelero',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          Text(
            l10n.developer,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          // Informações do App
          _buildInfoTile(l10n.appName, _packageInfo.appName),
          _buildInfoTile(l10n.version, _packageInfo.version),
          _buildInfoTile(l10n.buildNumber, _packageInfo.buildNumber),
          const SizedBox(height: 16),
          // Lista de dependências
          Card(
            elevation: 1.0,
            child: ExpansionTile(
              title: Text(
                l10n.dependencies,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                _buildDependencyTile('device_info_plus'),
                _buildDependencyTile('google_mobile_ads'),
                _buildDependencyTile('sensors_plus'),
                _buildDependencyTile('package_info_plus'),
                _buildDependencyTile('flutter_localizations'),
                _buildDependencyTile('intl'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget para exibir informações do App
  Widget _buildInfoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
    );
  }

  // Widget para exibir as dependências
  Widget _buildDependencyTile(String name) {
    return ListTile(
      title: Text(name),
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
    );
  }
}
