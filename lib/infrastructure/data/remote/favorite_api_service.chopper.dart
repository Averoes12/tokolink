// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$FavoriteApiService extends FavoriteApiService {
  _$FavoriteApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = FavoriteApiService;

  @override
  Future<Response<dynamic>> favorites() {
    final $url = 'favorite';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addFavorite(Map<String, dynamic> body) {
    final $url = 'favorite';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
