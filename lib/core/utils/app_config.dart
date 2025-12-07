class ApiConfig {
  static const String _flavor =
      String.fromEnvironment('FLAVOR', defaultValue: 'development');

  static String get baseUrl {
    switch (_flavor) {
      case 'production':
        return 'https://al-alamia.arabapps.co/api/v1';
      case 'development':
      default:
        return 'https://al-alamia.arabapps.co/api/v1';
    }
  }
}
