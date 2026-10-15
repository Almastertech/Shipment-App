import 'package:flutter/material.dart';

class AppDropDownField<T> extends StatelessWidget {
  const AppDropDownField({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.validator,
    this.isExpanded = true,
    this.enabled = true,
    this.menuMaxHeight,
  });

  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? labelText;
  final String? hintText;
  final FormFieldValidator<T>? validator;
  final bool isExpanded;
  final bool enabled;
  final double? menuMaxHeight;

  @override
  Widget build(BuildContext context) {
    final effectiveOnChanged = enabled ? onChanged : null;
    return DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: isExpanded,
      menuMaxHeight: menuMaxHeight,
      onChanged: effectiveOnChanged,
      validator: validator,
      items: items,
      disabledHint: enabled
          ? null
          : Text(
              value?.toString() ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
