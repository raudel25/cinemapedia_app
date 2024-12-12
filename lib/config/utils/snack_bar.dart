import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GlobalSnackBar {
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showSnackBar(String message, {Duration? duration}) =>
      messengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration ?? const Duration(seconds: 2),
        ),
      );

  void showSnackBarResponse(DataResponse response, {Duration? duration}) =>
      showSnackBar(response.message ?? 'unexpectedError'.tr(),
          duration: duration);
}

final globalSnackBar = GlobalSnackBar();
