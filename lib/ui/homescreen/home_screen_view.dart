// ignore_for_file: use_build_context_synchronously

import 'package:dictionary_app/ui/homescreen/home_screen_viewmodel.dart';
import 'package:dictionary_app/core/constants/constants.dart';
import 'package:dictionary_app/ui/word_definition_screen/word_definition_screen_view.dart';
import 'package:dictionary_app/utils/ui_helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController searchWord = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: loading
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Online Dictionary App',
                        style: TextStyle(
                            color: AppColors.orangeColor,
                            fontSize: 34,
                            fontWeight: FontWeight.bold),
                      ),
                      ymargin(5),
                      Text(
                        'Search any word you want quickly',
                        style: TextStyle(
                            color: AppColors.whiteColor, fontSize: 14),
                      ),
                      ymargin(30),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: TextField(
                          controller: searchWord,
                          decoration: InputDecoration(
                            hintText: 'Enter keyword',
                            hintStyle: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 14,
                            ),
                            fillColor: Colors.grey[100],
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.search,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            final dc = ref.watch(dictionaryProvider);
                            final dc2 = ref.watch(dictionaryProvider.notifier);
                            await dc2.getWords(searchWord.text.trim());
                            switch (dc) {
                              case SearchState.searchSuccess:
                                setState(() {
                                  loading = false;
                                });
                                print("Data received is: ${dc2.list}");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        WordDefinitionScreen(data: dc2.list),
                                  ),
                                );
                                break;
                              case SearchState.loading:
                                setState(() {
                                  loading = true;
                                });
                                break;
                              case SearchState.hasError:
                                setState(() {
                                  loading = false;
                                });
                                UIHelpers.showAlertDialog(context,
                                    error: dc2.error, query: searchWord.text);
                                break;
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                              backgroundColor: AppColors.orangeColor),
                          child: Text(
                            'Search',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 18,
                            ),
                          ))
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
