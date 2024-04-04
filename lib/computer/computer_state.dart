

import 'package:flutter_computer/utils/computer_enum.dart';

class ComputerState {}

class Value1State extends ComputerState {
  final String value;

  Value1State({required this.value});
}

class Value2State extends ComputerState {
  final String value;

  Value2State({required this.value});
}

class CalculatorState extends ComputerState {}

class ResultState extends ComputerState {
  final String result;

  ResultState({required this.result});
}

class SelectedValue extends ComputerState {
  final bool selected;
  final CalculationEnum calculationEnum;

  SelectedValue({
    required this.selected,
    required this.calculationEnum,
  });
}
