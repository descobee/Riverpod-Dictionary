import 'dart:convert';
import 'dart:io';

import 'package:dictionary_app/services/network_service/i_network_service.dart';
import 'package:http/http.dart' as http;

class NetworkService implements INetworkService {

  http.Client client = http.Client();
  String baseURL = 'https://api.dictionaryapi.dev/api/v2/entries/en/';

  @override
  Future<dynamic> get(String query) async {
    final sentURL = Uri.parse(baseURL + query);

    http.Response response;

    try {
      response = await client.get(sentURL);
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        return decodedResponse;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } on SocketException {
      rethrow;
    } on HttpException {
      rethrow;
    } on FormatException {
      rethrow;
    }
  }
}
