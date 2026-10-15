import 'package:flutter/material.dart';

class TextLinkButton extends StatelessWidget {
  const TextLinkButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.underlined = false,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool underlined;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelLarge?.copyWith(
          decoration: underlined ? TextDecoration.underline : null,
        );

    Widget button = TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: style,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
    );

    if (semanticLabel != null && semanticLabel!.trim().isNotEmpty) {
      button = Semantics(
        button: true,
        label: semanticLabel,
        child: button,
      );
    }

    return button;
  }
}
