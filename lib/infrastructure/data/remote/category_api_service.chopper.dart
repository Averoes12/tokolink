// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CategoryApiService extends CategoryApiService {
  _$CategoryApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CategoryApiService;

  @override
  Future<Response<dynamic>> categories() {
    final $url = 'category';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> subCategories(String categoryId) {
    final $url = 'category/index/$categoryId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
