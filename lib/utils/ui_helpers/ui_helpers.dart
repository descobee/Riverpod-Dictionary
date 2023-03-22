import 'package:dictionary_app/core/constants/constants.dart';
import 'package:dictionary_app/ui/homescreen/home_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UIHelpers {
  static Future<dynamic> showAlertDialog(BuildContext context,
      {required Object error, String? query, VoidCallback? function}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          buttonPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SizedBox(
            width: screenWidth(context, percent: 0.9),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: screenHeight(context, percent: 0.02)),
                const Text(
                  'Notice',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight(context, percent: 0.03)),
              ],
            ),
          ),
          actions: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.transparent),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer(builder: (context, ref, __) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            backgroundColor: AppColors.orangeColor),
                        onPressed: function,
                        child: Text(
                          'Try Again',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

double screenWidth(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.width * percent;

double screenHeight(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.height * percent;
