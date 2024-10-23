import 'package:flutter_test/flutter_test.dart';
import 'package:golden_variant/golden_variant.dart';

Future<void> expectMatchesGoldenFile<T>(
  GoldenFilePathBuilder pathBuilder, {
  Finder? finder,
  String? reason,
  dynamic skip,
  int? version,
}) async {
  Finder? finderByTType;
  if (T != dynamic) {
    finderByTType = find.byType(T);
  }
  await expectLater(
    finder ?? finderByTType ?? find.byType(DeviceFrameWrapper),
    matchesGoldenFile(pathBuilder(), version: version),
    reason: reason,
    skip: skip,
  );
}

abstract interface class GoldenFilePathBuilder {
  String call();
}

class DefaultPath implements GoldenFilePathBuilder {
  const DefaultPath({
    required this.variant,
    this.path,
    this.suffix,
    this.prefix,
  });

  final ValueVariantComposite variant;
  final String? path;
  final String? suffix;
  final String? prefix;

  @override
  String call() {
    final variantStr = variant.currentValue.join('-').replaceAll(' ', '_');
    final suffixStr = suffix ?? '';
    final prefixStr = prefix == null ? '' : '$prefix-';
    final pathStr = path == null ? (prefix == null ? '' : '$prefix/') : '$path/';
    return 'preview/$pathStr$prefixStr[$variantStr]$suffixStr.png';
  }
}
