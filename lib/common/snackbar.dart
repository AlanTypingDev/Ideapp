import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
  BuildContext context,
  String content, {
  bool? error = false,
}) {
  final messenger = ScaffoldMessenger.of(context);

  // 🚿 Mata cualquier snackbar anterior
  messenger.hideCurrentSnackBar();

  return messenger.showSnackBar(
    SnackBar(
      content: Text(content),
      backgroundColor: error == true
          ? Colors.red.shade700
          : Colors.green.shade700,
    ),
  );
}
