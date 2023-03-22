import 'package:dictionary_app/model/dictionary_response.dart';
import 'package:dictionary_app/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordDefinitionScreen extends ConsumerStatefulWidget {
  final List<WordsModel> data;
  const WordDefinitionScreen({super.key, required this.data});

  @override
  ConsumerState<WordDefinitionScreen> createState() =>
      _WordDefinitionScreenState();
}

class _WordDefinitionScreenState extends ConsumerState<WordDefinitionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Word Definition",
            style: TextStyle(
                color: AppColors.orangeColor,
                fontSize: 20,
                fontWeight: FontWeight.normal),
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            children: [
              ...List.generate(widget.data.length, (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.data[index].word ?? "",
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 34,
                          fontWeight: FontWeight.bold),
                    ),
                    ymargin(5),
                    if (widget.data[index].meanings != null &&
                        widget.data[index].meanings!.isNotEmpty)
                      ...List.generate(widget.data[index].meanings!.length,
                          (index1) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.data[index].meanings![index1]
                                        .definitions !=
                                    null &&
                                widget.data[index].meanings![index1]
                                    .definitions!.isNotEmpty)
                              ...List.generate(
                                widget.data[index].meanings![index1]
                                    .definitions!.length,
                                (index2) {
                                  final definition = widget.data[index]
                                      .meanings![index1].definitions;
                                  return Wrap(spacing: 1, children: [
                                    Text(
                                      "Definition: ",
                                      style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      definition![index2].definition ?? "",
                                      style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ]);
                                },
                              ),
                          ],
                        );
                      })
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
