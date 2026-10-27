import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'models/support_ticket.dart';
import 'widgets/profile_hero.dart';
import 'widgets/profile_subpage_hero.dart';
import 'widgets/support_ticket_chat_widgets.dart';

class SupportTicketDetailsScreen extends StatefulWidget {
  const SupportTicketDetailsScreen({required this.ticket, super.key});

  final SupportTicket ticket;

  @override
  State<SupportTicketDetailsScreen> createState() =>
      _SupportTicketDetailsScreenState();
}

class _SupportTicketDetailsScreenState
    extends State<SupportTicketDetailsScreen> {
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
      bottomNavigationBar: ReplyComposer(
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
              height: heroHeight + TicketSummaryCard.height - TicketSummaryCard.overlap,
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
                    top: heroHeight - TicketSummaryCard.overlap,
                    start: AppSpacing.tokenXl,
                    end: AppSpacing.tokenXl,
                    child: TicketSummaryCard(ticket: widget.ticket),
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
                          child: CustomerMessageBubble(
                            message: widget.ticket.messages[index],
                          ),
                        )
                      else
                        TeamMessageRow(
                          message: widget.ticket.messages[index],
                          teamName: l10n.supportTicketTeamName,
                        ),
                      if (index < widget.ticket.messages.length - 1)
                        const SizedBox(height: AppSpacing.tokenL),
                    ],
                    const SizedBox(height: AppSpacing.tokenL),
                  ],
                  Center(
                    child: ReplyTimeBadge(
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
