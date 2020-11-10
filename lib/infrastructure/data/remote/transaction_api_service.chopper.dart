// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$TransactionApiService extends TransactionApiService {
  _$TransactionApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TransactionApiService;

  @override
  Future<Response<dynamic>> createTransaction(Map<String, dynamic> body) {
    final $url = 'transaction';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> transactions() {
    final $url = 'transaction';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> transaction(String id) {
    final $url = 'transaction/index/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> tracking(String id) {
    final $url = 'transaction/tracking/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> shipping(double lat, double lng) {
    final $url = 'transaction/shipping/$lat/$lng';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> review(Map<String, dynamic> body) {
    final $url = 'review';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
