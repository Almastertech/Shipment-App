import 'package:flutter/material.dart';

import 'app_text_field.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.enabled = true,
    this.clearTooltip,
  });

  final TextEditingController controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool enabled;
  final String? clearTooltip;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return AppTextField(
          controller: controller,
          hintText: hintText,
          enabled: enabled,
          textInputAction: TextInputAction.search,
          textCapitalization: TextCapitalization.sentences,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: value.text.isEmpty
              ? null
              : IconButton(
                  tooltip: clearTooltip ?? 'Clear search',
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                    onChanged?.call('');
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
        );
      },
    );
  }
}
