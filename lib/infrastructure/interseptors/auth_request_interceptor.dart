import 'dart:async';

import 'package:chopper/chopper.dart';

import '../helpers/prefs.dart' show getToken;

class AuthRequestInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final token = await getToken();
    return applyHeaders(request, {'Authorization': 'Bearer $token'});
  }

  Request applyHeaders(
    Request request,
    Map<String, String> headers, {
    bool override = true,
  }) {
    final h = Map<String, String>.from(request.headers);

    for (var k in headers.keys) {
      if (!override && h.containsKey(k)) continue;
      h[k] = headers[k];
    }

    return request.copyWith(headers: h);
  }
}
