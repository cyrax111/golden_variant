import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';
import 'package:golden_variant/golden_variant.dart';

import 'flutter_test_config.dart';

void main() async {
  testWidgets(
    'MyHomePage golden test',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: getThemeData(variant.get<ThemeMode>()),
          home: DeviceFrameWrapper(
            device: variant.get<DeviceInfo>(),
            showVirtualKeyboard: variant.get<ShowKeyboard>().show,
            isFrameVisible: true,
            child: myHomePage,
          ),
        ),
      );

      await expectMatchesGoldenFile(variant: variant, path: 'init');

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      await expectMatchesGoldenFile(variant: variant, path: 'tapped-button');
    },
    variant: variant,
  );
}
