import 'package:flutter/material.dart';

enum ErrorUiType {
  offline,
  unauthorized,
  forbidden,
  notFound,
  validation,
  server,
  generic,
}

class ErrorUiModel {
  const ErrorUiModel({
    required this.type,
    required this.title,
    required this.message,
    required this.icon,
    this.actionLabel,
  });

  final ErrorUiType type;
  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
}
