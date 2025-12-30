enum Flavor { dev, prod }

class FlavorConfig {
  final Flavor flavor;
  final String appName;
  final String appLogo;

  static FlavorConfig? _instance;

  FlavorConfig.internal({
    required this.flavor,
    required this.appName,
    required this.appLogo,
  });

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception('FlavorConfig not initialized');
    }
    return _instance!;
  }

  static void initialize(Flavor flavor) {
    _instance = switch (flavor) {
      Flavor.dev => FlavorConfig.internal(
        flavor: Flavor.dev,
        appName: 'Dev App',
        appLogo: 'assets/logo/dev_launcher_icon.jpg',
      ),
      Flavor.prod => FlavorConfig.internal(
        flavor: Flavor.prod,
        appName: "Chat App",
        appLogo: "assets/logo/prod_launcher_icon.png",
      ),
    };
  }
}
