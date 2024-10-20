import 'package:flutter_test/flutter_test.dart';
import 'package:golden_variant/golden_variant.dart';

Future<void> expectMatchesGoldenFile<T>({
  ValueVariantComposite? variant,
  String? path,
  Finder? finder,
  String? suffix,
  String? reason,
  dynamic skip,
  int? version,
}) async {
  final pathStr = path == null ? '' : '$path/';
  final variantStr = variant == null ? '' : '${variant.currentValue}';
  final suffixStr = suffix ?? '';

  Finder? finderByTType;
  if (T != dynamic) {
    finderByTType = find.byType(T);
  }
  await expectLater(
    finder ?? finderByTType ?? find.byType(DeviceFrameWrapper),
    matchesGoldenFile('preview/$pathStr$variantStr$suffixStr.png', version: version),
    reason: reason,
    skip: skip,
  );
}
