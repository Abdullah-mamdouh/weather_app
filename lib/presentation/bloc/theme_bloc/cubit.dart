

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/presentation/bloc/theme_bloc/state.dart';

import '../../../core/constant_colors/constant_colors.dart';

class ThemeBloc extends Cubit<ThemeState> {
  ConstantColor constantColor = ConstantColor();
  static Color backgroundColor = ConstantColor().fristBackgroundColor;
  static Color cardColor = ConstantColor().fristcardColor;

  ThemeBloc() : super(InitialColorState());

  /// instance
  static ThemeBloc get(context) => BlocProvider.of<ThemeBloc>(context);

  /// initial state
  initialColor(){
    emit(ChangedBackgroundColorState(backgroundColor: ConstantColor().fristBackgroundColor));
    emit(ChangedCardColorState(cardColor: ConstantColor().fristcardColor));
  }

  /// change background color of location weather details
  changeBackgroundColor(Color _color){

    backgroundColor = _color;
    emit(ChangedBackgroundColorState(backgroundColor: _color));
  }

  ///change color of card at location weather details
  changeCardColor(Color _color){

    cardColor = _color;
    emit(ChangedCardColorState(cardColor: _color));

  }
}