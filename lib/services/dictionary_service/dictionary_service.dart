import 'package:dictionary_app/core/app/service_locator.dart';
import 'package:dictionary_app/model/dictionary_response.dart';
import 'package:dictionary_app/services/network_service/i_network_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repoProvider = Provider<DictionaryService>((ref) => DictionaryService());

class DictionaryService {
  Future<List<WordsModel>> getWords(String query) async {
    final client = locator.get<INetworkService>(instanceName: 'instance');
    print("Attempting to fetch word");
    final List response = await client.get(query);
    print("Response received for word: $query");
    try {
      print("Parsing data: ${response.toString()}");
      final result = response.map((e) => WordsModel.fromJson(e)).toList();
      print("Data parsed successfully!");
      return result;
    } on Exception {
      rethrow;
    }
  }
}
