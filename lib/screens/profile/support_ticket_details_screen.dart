import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_images.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'models/support_ticket.dart';
import 'widgets/profile_hero.dart';
import 'widgets/profile_subpage_hero.dart';

class SupportTicketDetailsScreen extends StatefulWidget {
  const SupportTicketDetailsScreen({required this.ticket, super.key});

  final SupportTicket ticket;

  @override
  State<SupportTicketDetailsScreen> createState() =>
      _SupportTicketDetailsScreenState();
}

class _SupportTicketDetailsScreenState
    extends State<SupportTicketDetailsScreen> {
  static const double _summaryHeight = 96;
  static const double _summaryOverlap =
       AppSpacing.tokenXl;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final heroHeight =
        ProfileHero.heightForWidth(MediaQuery.sizeOf(context).width);

    return AppScaffold(
      padding: EdgeInsets.zero,
      safeArea: false,
      dismissKeyboardOnTap: false,
      backgroundColor: AppColors.semantic.background.primary,
      bottomNavigationBar: _ReplyComposer(
        hint: l10n.supportTicketReplyHint,
        attachLabel: l10n.supportTicketAttachFile,
        sendLabel: l10n.supportTicketSendReply,
        onSend: () => _showReplyUnavailable(context, l10n),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.only(
          bottom: AppSpacing.token2Xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: heroHeight + _summaryHeight - _summaryOverlap,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  PositionedDirectional(
                    top: 0,
                    start: 0,
                    end: 0,
                    height: heroHeight,
                    child: ProfileSubpageHero(
                      title: widget.ticket.title,
                      subtitle: widget.ticket.subtitle,
                      backLabel: l10n.navigationBack,
                      onBack: () => _goBack(context),
                    ),
                  ),
                  PositionedDirectional(
                    top: heroHeight - _summaryOverlap,
                    start: AppSpacing.tokenXl,
                    end: AppSpacing.tokenXl,
                    child: _TicketSummaryCard(ticket: widget.ticket),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.tokenXl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: AppSpacing.token2Xl),
                  Row(
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      AppText(
                        l10n.supportTicketMessageCount(
                          widget.ticket.messages.length,
                        ),
                        variant: AppTextVariant.bodySmall,
                        textDirection: TextDirection.rtl,
                        style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                          color: AppColors.primitives.neutral.shade600,
                        ),
                      ),
                      const Spacer(),
                      AppText(
                        l10n.supportTicketConversationTitle,
                        variant: AppTextVariant.titleMedium,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: AppTypography.buyerMobile.h6
                            .toTextStyle(
                              color: AppColors.primitives.neutral.shade900,
                            )
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  if (widget.ticket.messages.isNotEmpty) ...<Widget>[
                    const SizedBox(height: AppSpacing.tokenM),
                    Center(
                      child: AppText(
                        widget.ticket.conversationDate,
                        variant: AppTextVariant.labelSmall,
                        textDirection: TextDirection.rtl,
                        style: AppTypography.buyerMobile.labelSmall
                            .toTextStyle(
                              color: AppColors.primitives.neutral.shade600,
                            )
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenL),
                    for (var index = 0;
                        index < widget.ticket.messages.length;
                        index++) ...<Widget>[
                      if (widget.ticket.messages[index].author ==
                          SupportTicketMessageAuthor.customer)
                        Align(
                          alignment: Alignment.centerRight,
                          child: _CustomerMessageBubble(
                            message: widget.ticket.messages[index],
                          ),
                        )
                      else
                        _TeamMessageRow(
                          message: widget.ticket.messages[index],
                          teamName: l10n.supportTicketTeamName,
                        ),
                      if (index < widget.ticket.messages.length - 1)
                        const SizedBox(height: AppSpacing.tokenL),
                    ],
                    const SizedBox(height: AppSpacing.tokenL),
                  ],
                  Center(
                    child: _ReplyTimeBadge(
                      text: l10n.supportTicketReplySla,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReplyUnavailable(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(l10n.supportTicketReplyUnavailable)),
      );
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.supportTickets);
    }
  }
}

class _TicketSummaryCard extends StatelessWidget {
  const _TicketSummaryCard({required this.ticket});

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
            height: _SupportTicketDetailsScreenState._summaryHeight,
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
                          _TicketStatusBadge(label: ticket.statusLabel),
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

class _TicketStatusBadge extends StatelessWidget {
  const _TicketStatusBadge({required this.label});

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

class _CustomerMessageBubble extends StatelessWidget {
  const _CustomerMessageBubble({required this.message});

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

class _TeamMessageRow extends StatelessWidget {
  const _TeamMessageRow({required this.message, required this.teamName});

  final SupportTicketMessage message;
  final String teamName;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _TeamAvatar(),
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

class _TeamAvatar extends StatelessWidget {
  const _TeamAvatar();

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

class _ReplyTimeBadge extends StatelessWidget {
  const _ReplyTimeBadge({required this.text});

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

class _ReplyComposer extends StatefulWidget {
  const _ReplyComposer({
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
  State<_ReplyComposer> createState() => _ReplyComposerState();
}

class _ReplyComposerState extends State<_ReplyComposer> {
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
            _SelectedAttachment(
              file: attachment,
              onRemove: () => setState(() => _attachment = null),
            ),
            const SizedBox(height: AppSpacing.tokenS),
          ],
          Row(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              _SendReplyButton(
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

class _SelectedAttachment extends StatelessWidget {
  const _SelectedAttachment({required this.file, required this.onRemove});

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

class _SendReplyButton extends StatelessWidget {
  const _SendReplyButton({required this.label, required this.onPressed});

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
