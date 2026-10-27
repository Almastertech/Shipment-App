import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/profile/models/support_ticket.dart';
import 'package:shipments/screens/profile/widgets/support_ticket_chat_widgets.dart';

Widget _wrapWidget({required Widget child, Locale locale = const Locale('ar')}) {
  return MaterialApp(
    locale: locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: Scaffold(
      body: SingleChildScrollView(child: child),
    ),
  );
}

void main() {
  const dummyTicket = SupportTicket(
    category: SupportTicketCategory.shipment,
    status: SupportTicketStatus.inProgress,
    statusLabel: 'قيد المتابعة',
    title: 'تذكرة شحنة #1092',
    subtitle: 'تأخر في استلام الشحنة',
    lastUpdate: 'منذ ساعتين',
    categoryLabel: 'مشكلة شحن',
    actionLabel: 'عرض التذكرة',
    conversationDate: '24 أكتوبر 2026',
    messages: <SupportTicketMessage>[
      SupportTicketMessage(
        author: SupportTicketMessageAuthor.customer,
        body: 'مرحبا، أود الاستفسار عن الشحنة',
        metadata: '10:30 ص',
      ),
      SupportTicketMessage(
        author: SupportTicketMessageAuthor.team,
        body: 'أهلاً بك، نحن نتابع الشحنة مع الناقل وسيتم التوصيل غداً',
        metadata: '10:45 ص',
      ),
    ],
  );

  group('TicketSummaryCard Tests', () {
    testWidgets('renders category label, status, and last update', (tester) async {
      await tester.pumpWidget(_wrapWidget(child: const TicketSummaryCard(ticket: dummyTicket)));
      await tester.pumpAndSettle();

      expect(find.text('مشكلة شحن'), findsOneWidget);
      expect(find.text('قيد المتابعة'), findsOneWidget);
      expect(find.textContaining('منذ ساعتين'), findsOneWidget);
    });
  });

  group('CustomerMessageBubble Tests', () {
    testWidgets('renders customer message body and metadata', (tester) async {
      final message = dummyTicket.messages.first;
      await tester.pumpWidget(_wrapWidget(child: CustomerMessageBubble(message: message)));
      await tester.pumpAndSettle();

      expect(find.text('مرحبا، أود الاستفسار عن الشحنة'), findsOneWidget);
      expect(find.text('10:30 ص'), findsOneWidget);
    });
  });

  group('TeamMessageRow Tests', () {
    testWidgets('renders team name, avatar, message body, and metadata', (tester) async {
      final message = dummyTicket.messages[1];
      await tester.pumpWidget(
        _wrapWidget(
          child: TeamMessageRow(
            message: message,
            teamName: 'فريق الدعم',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('فريق الدعم'), findsOneWidget);
      expect(find.text('ح'), findsOneWidget);
      expect(find.textContaining('نحن نتابع الشحنة'), findsOneWidget);
      expect(find.text('10:45 ص'), findsOneWidget);
    });
  });

  group('ReplyComposer Tests', () {
    testWidgets('allows typing text and triggers onSend callback', (tester) async {
      var sendCalled = false;
      await tester.pumpWidget(
        _wrapWidget(
          child: ReplyComposer(
            hint: 'اكتب ردك...',
            attachLabel: 'إرفاق ملف',
            sendLabel: 'إرسال',
            onSend: () => sendCalled = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('اكتب ردك...'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'تم الاستلام بنجاح');
      expect(find.text('تم الاستلام بنجاح'), findsOneWidget);

      await tester.tap(find.byType(SendReplyButton));
      await tester.pump();

      expect(sendCalled, isTrue);
    });
  });
}
