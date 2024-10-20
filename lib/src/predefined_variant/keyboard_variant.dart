import 'package:flutter_test/flutter_test.dart';

class ShowKeyboardVariant extends ValueVariant<ShowKeyboard> {
  ShowKeyboardVariant() : super(ShowKeyboard.values.toSet());
}

enum ShowKeyboard {
  doShow(true),
  dontShow(false);

  const ShowKeyboard(this.show);
  final bool show;
}
