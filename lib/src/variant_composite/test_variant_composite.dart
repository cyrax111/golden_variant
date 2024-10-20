import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

typedef CombinationTestVariants<T extends TestVariant<Object>> = ListTypeAware<T>;

class TestVariantComposite<T extends TestVariant<Object>>
    implements TestVariant<CombinationTestVariants<T>> {
  TestVariantComposite(Iterable<T> variants) {
    final combinations = variants
        .map((variant) =>
            variant.values.map((e) => CombinationValue(valueVariant: variant, value: e)).toList())
        .toList();
    values = _multiplyLists(combinations).map((e) => ListTypeAware(e));
  }

  List<Iterable<R>> _multiplyLists<R>(List<Iterable<R>> list) {
    final List<Iterable<R>> result = [];

    // Base case: if no sets, return a set with an empty list
    if (list.isEmpty) {
      result.add([]);
      return result;
    }

    // Recursive case
    final firstSet = list.first;
    final remainingSets = list.sublist(1);
    final subProducts = _multiplyLists(remainingSets);

    for (final item in firstSet) {
      for (final subProduct in subProducts) {
        // Create a new list that includes the current item from the first set
        result.add([item, ...subProduct]);
      }
    }

    return result;
  }

  @override
  late final Iterable<CombinationTestVariants<T>> values;

  @override
  String describeValue(CombinationTestVariants<T> value) {
    final stringBuffer = StringBuffer();
    for (final variantValue in value) {
      stringBuffer.write(variantValue.valueVariant.describeValue(variantValue.value));
      stringBuffer.write(' ');
    }
    return stringBuffer.toString();
  }

  @mustCallSuper
  @override
  Future<CombinationTestVariants<T>> setUp(CombinationTestVariants<T> value) async {
    for (final currentCombinationValue in value) {
      await currentCombinationValue.valueVariant.setUp(currentCombinationValue.value);
    }
    return value;
  }

  @mustCallSuper
  @override
  Future<void> tearDown(
      CombinationTestVariants<T> value, covariant CombinationTestVariants<T>? memento) async {
    for (final currentCombinationValue in value) {
      await currentCombinationValue.valueVariant.tearDown(
        currentCombinationValue.value,
        currentCombinationValue.value,
      );
    }
  }
}

class CombinationValue<T, VARIANT extends TestVariant<T>> {
  CombinationValue({
    required this.valueVariant,
    required this.value,
  });
  final VARIANT valueVariant;
  final T value;

  @override
  String toString() => valueVariant.describeValue(value);
}

class ListTypeAware<T extends TestVariant<Object>>
    extends UnmodifiableListView<CombinationValue<Object, T>> {
  ListTypeAware(this._source) : super(_source);

  final Iterable<CombinationValue<Object, T>> _source;

  R get<R>() {
    return _source
        .firstWhere(
          (e) => e.value is R,
          orElse: () => throw StateError('Variant with type $R not found'),
        )
        .value as R;
  }
}
