import 'package:chopper/chopper.dart';
import 'package:flutter/widgets.dart';

import '../../infrastructure/constants/global.dart';
import '../interseptors/auth_request_interceptor.dart';
import '../interseptors/response_error_interceptor.dart';

class ClientPreset {
  static ChopperClient authClient({@required ChopperService service}) {
    return ChopperClient(
      baseUrl: GlobalConstant.BASE_URL,
      services: [service],
      interceptors: [
        ResponseErrorInterceptor(),
        HttpLoggingInterceptor(),
        AuthRequestInterceptor(),
        HeadersInterceptor({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
      ],
      converter: JsonConverter(),
    );
  }

  static ChopperClient client({@required ChopperService service}) {
    return ChopperClient(
      baseUrl: GlobalConstant.BASE_URL,
      services: [service],
      interceptors: [
        ResponseErrorInterceptor(),
        HttpLoggingInterceptor(),
        HeadersInterceptor({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
      ],
      converter: JsonConverter(),
    );
  }
}
