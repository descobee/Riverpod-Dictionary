import 'package:dictionary_app/ui/homescreen/home_screen_viewmodel.dart';
import 'package:dictionary_app/core/constants/constants.dart';
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
    final dictController = ref.read(dictionaryController(searchWord.text));
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
                        'Dictionary App',
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
                        height: 40,
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
                          onPressed: () {
                            dictController.when(
                                data: (data) {},
                                error: (error, _) {
                                  loading = false;
                                  UIHelpers.showAlertDialog(context, error: error, query: searchWord.text);
                                },
                                loading: () {
                                  loading = true;
                                });
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
