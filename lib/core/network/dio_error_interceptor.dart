import 'package:dio/dio.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage;

    if (err.response != null) {
      final statusCode = err.response?.statusCode ?? 0;
      if (statusCode >= 300) {
        errorMessage =
            err.response?.data['message']?.toString() ??
            err.response?.statusMessage ??
            'Unknown error';
      } else {
        errorMessage = 'Something went wrong';
      }
    } else {
      errorMessage = 'Connection error';
    }

    final customError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      error: errorMessage,
      type: err.type,
    );

    super.onError(customError, handler);
  }
}

class UrlFixInterceptor extends Interceptor {
  final String baseUrl;

  UrlFixInterceptor(this.baseUrl);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Example: If request URL is relative (e.g., starts with "/cover-images/"),
    // prepend the baseUrl

    final url = options.path;

    // Only fix if it's an image or specific path you want to normalize
    if (url.startsWith('/cover-images/') || url.startsWith('cover-images/')) {
      // If the URL is relative, ensure we prepend baseUrl only once
      if (!url.startsWith(baseUrl)) {
        // Remove leading slash if present to avoid double slashes
        final fixedPath = url.startsWith('/') ? url.substring(1) : url;
        options.path = '$baseUrl/$fixedPath';
      }
    }

    // You can add other URL fixes here for other paths

    super.onRequest(options, handler);
  }
}

