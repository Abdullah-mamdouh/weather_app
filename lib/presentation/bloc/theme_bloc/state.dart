

import 'package:flutter/cupertino.dart';

abstract class ThemeState {
  const ThemeState();
}

class InitialColorState extends ThemeState {
}

class ChangedBackgroundColorState extends ThemeState {
  Color backgroundColor;
  ChangedBackgroundColorState({required this.backgroundColor});
}

class ChangedCardColorState extends ThemeState {
  Color cardColor;
  ChangedCardColorState({required this.cardColor});
}