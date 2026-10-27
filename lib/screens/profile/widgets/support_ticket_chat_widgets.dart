import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../models/support_ticket.dart';

class TicketSummaryCard extends StatelessWidget {
  static const double height = 96;
  static const double overlap = AppSpacing.tokenXl;

  const TicketSummaryCard({super.key, required this.ticket});

  final SupportTicket ticket;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final radius = BorderRadius.circular(AppRadius.token2Xl);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: ColoredBox(
          color: colors.primary.shade700,
          child: SizedBox(
            height: height,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                PositionedDirectional(
                  top: -100,
                  end: -80,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.primary.shade500.withValues(alpha: .45),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.tokenXl,
                    vertical: AppSpacing.tokenL,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          Expanded(
                            child: AppText(
                              ticket.categoryLabel,
                              variant: AppTextVariant.labelSmall,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.buyerMobile.labelSmall
                                  .toTextStyle(color: colors.neutral.shade100)
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.tokenS),
                          TicketStatusBadge(label: ticket.statusLabel),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.tokenM),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppText(
                          '${l10n.supportTicketsLastUpdate}: ${ticket.lastUpdate}',
                          variant: AppTextVariant.bodySmall,
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                            color: colors.neutral.shade100.withValues(
                              alpha: .75,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TicketStatusBadge extends StatelessWidget {
  const TicketStatusBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(AppRadius.tokenFull),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenS,
          vertical: AppSpacing.token3Xs,
        ),
        child: AppText(
          label,
          variant: AppTextVariant.labelSmall,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          maxLines: 1,
          style: AppTypography.buyerMobile.labelSmall
              .toTextStyle(color: colors.accent01.shade300)
              .copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class CustomerMessageBubble extends StatelessWidget {
  const CustomerMessageBubble({super.key, required this.message});

  final SupportTicketMessage message;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 324),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.tokenL),
        decoration: const BoxDecoration(
          color: Color(0xFF6E56F0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadius.tokenXl),
            topRight: Radius.circular(AppRadius.tokenXs),
            bottomRight: Radius.circular(AppRadius.tokenXl),
            bottomLeft: Radius.circular(AppRadius.tokenXl),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppText(
              message.body,
              variant: AppTextVariant.bodyMedium,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: AppTypography.buyerMobile.bodyMedium
                  .toTextStyle(color: colors.neutral.shade100)
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: AppSpacing.tokenXs),
            AppText(
              message.metadata,
              variant: AppTextVariant.labelSmall,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: AppTypography.buyerMobile.caption.toTextStyle(
                color: colors.neutral.shade100.withValues(alpha: .75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamMessageRow extends StatelessWidget {
  const TeamMessageRow({
    super.key,
    required this.message,
    required this.teamName,
  });

  final SupportTicketMessage message;
  final String teamName;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const TeamAvatar(),
        const SizedBox(width: AppSpacing.tokenS),
        Expanded(
          child: Container(
            height: 140,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.tokenL,
              vertical: AppSpacing.tokenM,
            ),
            decoration: BoxDecoration(
              color: AppColors.semantic.surface.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.tokenXs),
                topRight: Radius.circular(AppRadius.tokenXl),
                bottomRight: Radius.circular(AppRadius.tokenXl),
                bottomLeft: Radius.circular(AppRadius.tokenXl),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: colors.neutral.shade900.withValues(alpha: .08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AppText(
                  teamName,
                  variant: AppTextVariant.labelSmall,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: AppTypography.buyerMobile.labelSmall
                      .toTextStyle(color: colors.primary.shade500)
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSpacing.tokenS),
                Expanded(
                  child: AppText(
                    message.body,
                    variant: AppTextVariant.bodySmall,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                      color: colors.neutral.shade900,
                    ),
                  ),
                ),
                AppText(
                  message.metadata,
                  variant: AppTextVariant.labelSmall,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: AppTypography.buyerMobile.caption.toTextStyle(
                    color: colors.neutral.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TeamAvatar extends StatelessWidget {
  const TeamAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        color: Color(0xFFFFD34D),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: AppText(
        'ح',
        variant: AppTextVariant.bodyMedium,
        textAlign: TextAlign.center,
        style: AppTypography.buyerMobile.bodyMedium
            .toTextStyle(
              color: AppColors.primitives.neutral.shade900,
            )
            .copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class ReplyTimeBadge extends StatelessWidget {
  const ReplyTimeBadge({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.primitives.neutral.shade700;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primitives.neutral.shade200,
        borderRadius: BorderRadius.circular(AppRadius.tokenFull),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenM,
          vertical: AppSpacing.tokenS,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            AppText(
              text,
              variant: AppTextVariant.labelSmall,
              textDirection: TextDirection.rtl,
              maxLines: 1,
              style: AppTypography.buyerMobile.labelSmall
                  .toTextStyle(
                    color: color,
                  )
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: AppSpacing.tokenXs),
            SvgPicture.asset(
              AppImages.timeQuarterTo,
              width: 14,
              height: 14,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}

class ReplyComposer extends StatefulWidget {
  const ReplyComposer({
    super.key,
    required this.hint,
    required this.attachLabel,
    required this.sendLabel,
    required this.onSend,
  });

  final String hint;
  final String attachLabel;
  final String sendLabel;
  final VoidCallback onSend;

  @override
  State<ReplyComposer> createState() => _ReplyComposerState();
}

class _ReplyComposerState extends State<ReplyComposer> {
  final _controller = TextEditingController();
  PlatformFile? _attachment;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final safeAreaBottom = MediaQuery.paddingOf(context).bottom;
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      decoration: BoxDecoration(
        color: AppColors.semantic.surface.primary,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .12),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.tokenXl,
        AppSpacing.tokenL,
        AppSpacing.tokenXl,
        safeAreaBottom > AppSpacing.tokenXl
            ? safeAreaBottom
            : AppSpacing.tokenXl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (_attachment case final attachment?) ...<Widget>[
            SelectedAttachment(
              file: attachment,
              onRemove: () => setState(() => _attachment = null),
            ),
            const SizedBox(height: AppSpacing.tokenS),
          ],
          Row(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              SendReplyButton(
                label: widget.sendLabel,
                onPressed: widget.onSend,
              ),
              const SizedBox(width: AppSpacing.tokenS),
              Expanded(
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.tokenL,
                  ),
                  decoration: BoxDecoration(
                    color: colors.neutral.shade200,
                    borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                  ),
                  child: Row(
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Semantics(
                        button: true,
                        label: widget.attachLabel,
                        child: InkWell(
                          onTap: _pickAttachment,
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.token2Xs),
                            child: SvgPicture.asset(
                              AppImages.document,
                              width: 14,
                              height: 14,
                              colorFilter: ColorFilter.mode(
                                colors.neutral.shade700,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.tokenM),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => widget.onSend(),
                          style:
                              AppTypography.buyerMobile.bodySmall.toTextStyle(
                            color: colors.neutral.shade900,
                          ),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            filled: false,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: widget.hint,
                            hintStyle: AppTypography.buyerMobile.bodySmall
                                .toTextStyle(color: colors.neutral.shade600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickAttachment() async {
    final result = await FilePicker.pickFiles();
    if (result == null || !mounted || result.files.isEmpty) return;
    setState(() => _attachment = result.files.first);
  }
}

class SelectedAttachment extends StatelessWidget {
  const SelectedAttachment({
    super.key,
    required this.file,
    required this.onRemove,
  });

  final PlatformFile file;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.primitives.neutral.shade700;
    return Row(
      textDirection: TextDirection.rtl,
      children: <Widget>[
        Expanded(
          child: AppText(
            file.name,
            variant: AppTextVariant.labelSmall,
            textDirection: TextDirection.rtl,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.caption.toTextStyle(color: color),
          ),
        ),
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: onRemove,
          icon: Icon(Icons.close_rounded, size: 18, color: color),
        ),
      ],
    );
  }
}

class SendReplyButton extends StatelessWidget {
  const SendReplyButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: AppColors.primitives.primary.shade500,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 52,
            height: 52,
            child: Center(
              child: SvgPicture.asset(
                AppImages.send,
                width: 22,
                height: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
