import 'dart:async';

import 'package:flutter/material.dart';
import 'package:golden_variant/golden_variant.dart';

/// Configure default variants
final variant = ValueVariantComposite([
  DeviceVariant({
    Devices.ios.iPhone13,
    Devices.ios.iPad,
    Devices.windows.laptop,
  }),
  ThemeVariant({ThemeMode.light, ThemeMode.dark}),
  ShowKeyboardVariant(),
]);

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadFonts();
  await testMain();
}
