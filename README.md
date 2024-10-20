A convenient golden test package that allows you to perform multi-variant test.

## Features

Let's say you have golden tests and want to create golden files for different types of variants:
- different device screen sizes;
- dark and light themes;
- LTR and RTL fonts;
- with and without keyboard;
- ...

just set variants you need and pass them to composed variant:
```
final variant = ValueVariantComposite([
  DeviceVariant({
    Devices.ios.iPhone13,
    Devices.ios.iPad,
  }),
  ThemeVariant({ThemeMode.light, ThemeMode.dark}),
  ShowKeyboardVariant(),
]);
```

then use regular `testWidgets`:

```
  testWidgets(
    'MyHomePage golden test',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getThemeData(variant.get<ThemeMode>()),
          home: DeviceFrameWrapper(
            device: variant.get<DeviceInfo>(),
            showVirtualKeyboard: variant.get<ShowKeyboard>().show,
            child: MyApp(),
        ...
    }
    variant: variant,
  );
```

![](https://github.com/cyrax111/golden_variant/blob/master/assets/variants_preview.png?raw=true)

Check out the [example](https://github.com/cyrax111/golden_variant/tree/master/example).

## Getting started

1. Add `golden_variant` to your dev dependencies.

2. Create a `flutter_test_config.dart` file at the root of your `test` folder with a `testExecutable` function:

```dart
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await testMain();
}
```

For more information, see the [official Flutter documentation](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html).

## Ideas

If you have any ideas on how to enhance this package or have any concern, feel free to make an [issue](https://github.com/cyrax111/golden_variant/issues).