class ApiConfig {
  ApiConfig._();

  /// PrimeGym API server.
  /// Override: `flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000`
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.200.12.142:8000',
  );

  /// Virtual-host name for Laragon/Valet/Herd when [baseUrl] is an IP.
  /// Empty means no Host override is needed.
  static const String hostHeader = String.fromEnvironment(
    'API_HOST_HEADER',
    defaultValue: '',
  );

  /// Rewrites absolute API media URLs that use [hostHeader] to [baseUrl].
  static String rewriteLocalUrl(String url) {
    if (url.isEmpty || hostHeader.isEmpty) return url;
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) return url;
    if (uri.host != hostHeader) return url;

    final base = Uri.parse(baseUrl);
    return uri.replace(
      scheme: base.scheme,
      host: base.host,
      port: base.hasPort ? base.port : null,
    ).toString();
  }
}
