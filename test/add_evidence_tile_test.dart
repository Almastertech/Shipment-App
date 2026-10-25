import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipments/screens/demands/widgets/add_evidence_tile.dart';

void main() {
  testWidgets('rebuilds reuse the same photo byte read', (tester) async {
    final photo = _CountingXFile();
    final rebuilds = ValueNotifier<int>(0);

    await tester.pumpWidget(
      MaterialApp(
        home: ValueListenableBuilder<int>(
          valueListenable: rebuilds,
          builder: (context, value, child) => AddEvidenceTile(
            semanticLabel: 'Evidence photo',
            photo: photo,
            onTap: () {},
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(photo.readCount, 1);

    rebuilds.value++;
    await tester.pump();
    await tester.pump();

    expect(photo.readCount, 1);
  });
}

class _CountingXFile extends XFile {
  _CountingXFile() : super('/virtual/evidence.png');

  static final Uint8List _png = Uint8List.fromList(
    base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+a3ioAAAAASUVORK5CYII=',
    ),
  );

  int readCount = 0;

  @override
  Future<Uint8List> readAsBytes() async {
    readCount++;
    return _png;
  }
}
