import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/profile/widgets/create_support_ticket_widgets.dart';

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
  group('TicketRequiredFieldsNote Tests', () {
    testWidgets('renders required fields note text', (tester) async {
      await tester.pumpWidget(
        _wrapWidget(
          child: const TicketRequiredFieldsNote(text: 'الحقول المشار إليها إلزامية'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('الحقول المشار إليها إلزامية'), findsOneWidget);
    });
  });

  group('TicketSectionLabel Tests', () {
    testWidgets('renders section label text', (tester) async {
      await tester.pumpWidget(
        _wrapWidget(
          child: const TicketSectionLabel(text: 'فئة التذكرة'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('فئة التذكرة'), findsOneWidget);
    });
  });

  group('TicketCategoryOptions Tests', () {
    testWidgets('renders category options and invokes onChanged', (tester) async {
      TicketCategory selectedCategory = TicketCategory.claim;
      final labels = <TicketCategory, String>{
        TicketCategory.claim: 'مطالبة',
        TicketCategory.shipment: 'شحنة',
        TicketCategory.account: 'حساب',
      };

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return _wrapWidget(
              child: TicketCategoryOptions(
                selected: selectedCategory,
                labels: labels,
                onChanged: (cat) => setState(() => selectedCategory = cat),
              ),
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('مطالبة'), findsOneWidget);
      expect(find.text('شحنة'), findsOneWidget);
      expect(find.text('حساب'), findsOneWidget);

      await tester.tap(find.text('شحنة'));
      await tester.pumpAndSettle();

      expect(selectedCategory, equals(TicketCategory.shipment));
    });
  });

  group('TicketAttachmentPicker Tests', () {
    testWidgets('renders picker with attachments and triggers remove callback', (tester) async {
      PlatformFile? removedFile;
      final dummyFiles = <PlatformFile>[
        PlatformFile(name: 'invoice.pdf', size: 1024),
        PlatformFile(name: 'receipt.png', size: 2048),
      ];

      await tester.pumpWidget(
        _wrapWidget(
          child: TicketAttachmentPicker(
            attachments: dummyFiles,
            onTap: () {},
            onRemove: (file) => removedFile = file,
            title: 'إرفاق ملفات',
            description: 'الحد الأقصى 5 ملفات',
            removeLabel: 'حذف',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('إرفاق ملفات'), findsOneWidget);
      expect(find.text('الحد الأقصى 5 ملفات'), findsOneWidget);
      expect(find.text('invoice.pdf'), findsOneWidget);
      expect(find.text('receipt.png'), findsOneWidget);

      await tester.tap(find.byType(IconButton).first);
      await tester.pump();

      expect(removedFile?.name, equals('invoice.pdf'));
    });
  });
}
