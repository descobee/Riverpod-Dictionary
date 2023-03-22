import 'package:dictionary_app/model/dictionary_response.dart';
import 'package:dictionary_app/services/dictionary_service/dictionary_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dictionaryController =
    FutureProvider.autoDispose.family<List<WordsModel>, String>(
  (ref, query) async {
    final list = await ref.watch(repoProvider).getWords(query);
    print("From viewmodel: $list");
    return list;
  },
);

enum SearchState { loading, hasError, searchSuccess }

class HomeScreenViewModel extends StateNotifier<SearchState> {
  HomeScreenViewModel(this.ref) : super(SearchState.searchSuccess);
  final Ref ref;
  String error = '';
  List<WordsModel> list = [];

  Future<void> getWords(String query) async {
    state = SearchState.loading;
    try {
      list = await ref.read(repoProvider).getWords(query);
      state = SearchState.searchSuccess;
      print("Success");
    } catch (e) {
      state = SearchState.hasError;
      error = e.toString();
      print(error);
    }
    print(state == SearchState.loading);
    print(state == SearchState.searchSuccess);
  }
}

final dictionaryProvider =
    StateNotifierProvider<HomeScreenViewModel, SearchState>(
  (ref) => HomeScreenViewModel(ref),
);
