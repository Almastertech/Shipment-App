import 'package:flutter/material.dart';

class TextLinkButton extends StatelessWidget {
  const TextLinkButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.underlined = false,
    this.semanticLabel,
    this.icon,
    this.iconOnTrailing = false,
    this.foregroundColor,
    this.textStyle,
    this.buttonStyle,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool underlined;
  final String? semanticLabel;
  final Widget? icon;
  final bool iconOnTrailing;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelLarge?.merge(textStyle).copyWith(
          decoration: underlined ? TextDecoration.underline : null,
          color: foregroundColor,
        );

    Widget button = TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
      ).merge(buttonStyle),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null && !iconOnTrailing) ...<Widget>[
            icon!,
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              label,
              style: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
          if (icon != null && iconOnTrailing) ...<Widget>[
            const SizedBox(width: 6),
            icon!,
          ],
        ],
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
