import 'package:flutter_test/flutter_test.dart';

import 'test_variant_composite.dart';

class ValueVariantComposite extends TestVariantComposite<ValueVariant<Object>> {
  ValueVariantComposite(super.variants);

  CombinationTestVariants<ValueVariant<Object>>? _currentValue;
  CombinationTestVariants<ValueVariant<Object>> get currentValue {
    final currentValue = _currentValue;
    if (currentValue == null) {
      throw StateError(
          'currentValue is not initiated. Didn\'t set "variant" parameter to "testWidgets"?');
    }
    return currentValue;
  }

  R get<R>() => currentValue.get<R>();

  @override
  Future<CombinationTestVariants<ValueVariant<Object>>> setUp(
      CombinationTestVariants<ValueVariant<Object>> value) async {
    _currentValue = value;
    return super.setUp(value);
  }

  @override
  Future<void> tearDown(CombinationTestVariants<ValueVariant<Object>> value,
      CombinationTestVariants<ValueVariant<Object>>? memento) async {
    await super.tearDown(value, memento);
  }
}
