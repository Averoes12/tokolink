import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

class ResponseErrorInterceptor implements ResponseInterceptor {
  @override
  FutureOr<Response> onResponse(Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      var messages = [];
      if (response.body != null || response.bodyString != null) {
        var body = response.body ?? jsonDecode(response.bodyString);
        try {
          var message = [];
          Map<String, dynamic> errors = body['errors'];

          errors.forEach((k, v) {
            v.forEach((msg) {
              message.add('$k : $msg');
            });
          });

          messages.add(message.first);
        } catch (error) {
          messages.add(body['message']);
        } finally {
          messages.add('Terjadi kesalahan');
        }
      }

      messages.add('No Data');
      throw Exception(messages.first);
    }
    return response;
  }
}
