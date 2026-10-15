import 'package:flutter/material.dart';

import 'app_text_field.dart';

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    this.controller,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.showPasswordLabel,
    this.hidePasswordLabel,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final String? showPasswordLabel;
  final String? hidePasswordLabel;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      labelText: widget.labelText,
      hintText: widget.hintText,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      validator: widget.validator,
      enabled: widget.enabled,
      autofillHints: const <String>[AutofillHints.password],
      obscureText: _obscureText,
      prefixIcon: const Icon(Icons.lock_outline_rounded),
      suffixIcon: IconButton(
        tooltip: _obscureText
            ? widget.showPasswordLabel ?? 'Show password'
            : widget.hidePasswordLabel ?? 'Hide password',
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: Icon(
          _obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
        ),
      ),
    );
  }
}
