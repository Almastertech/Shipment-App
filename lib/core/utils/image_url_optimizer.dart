class ImageUrlOptimizer {
  static String optimize(
    String url, {
    int? width,
    int? height,
  }) {
    if (url.isEmpty) return url;
    if (width == null && height == null) return url;

    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) return url;

    final query = <String, String>{...uri.queryParameters};
    if (width != null && width > 0) {
      query.putIfAbsent('w', () => '$width');
    }
    if (height != null && height > 0) {
      query.putIfAbsent('h', () => '$height');
    }

    return uri.replace(queryParameters: query).toString();
  }
}
