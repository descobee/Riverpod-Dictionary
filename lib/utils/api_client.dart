import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient._();
  static final ApiClient instance = ApiClient._();

  http.Client client = http.Client();
  String baseURL = 'https://api.dictionaryapi.dev/api/v2/entries/en/';

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
