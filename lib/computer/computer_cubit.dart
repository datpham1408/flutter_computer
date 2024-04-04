import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_computer/computer/computer_state.dart';
import 'package:flutter_computer/utils/computer_enum.dart';
import 'package:intl/intl.dart';

class ComputerCubit extends Cubit<ComputerState> {
  ComputerCubit() : super(ComputerState());
  String stringValue1 = '';
  String stringValue2 = '';
  double value1 = 0.0;
  double value2 = 0.0;
  String calculation = '';

  CalculationEnum calculationEnum = CalculationEnum.none;
  double result = 0.0;
  bool selected = false;

  bool commaSelected = false;

  String formatValue(double value) {
    String formattedValue = NumberFormat.decimalPattern().format(value);
    bool numberIsInt = value % 1 == 0;
    if (!numberIsInt || value > 1000) {
      String newValueFormat = formattedValue
          .split('')
          .map((e) {
            if (e == ',') {
              return '.';
            }
            if (e == '.') {
              return ',';
            }
            return e;
          })
          .toList()
          .join();

      return newValueFormat;
    }
    return formattedValue;
  }

  void clearValues() {
    stringValue1 = '';
    stringValue2 = '';
    calculation = '';
    result = 0.0;
    calculationEnum = CalculationEnum.none;
    selected = false;
    commaSelected = false;
    emit(ResultState(result: '0'));
  }

  double checkValue(String value) {
    if (value.contains(',')) {
      value = value.replaceAll(',', '.');
    }
    if (value.isNotEmpty) {
      return double.parse(value);
    } else {
      return 0.0;
    }
  }

  void updateValueWithEnum({
    String newValue = '',
    bool congDon = true,
  }) {
    if (congDon) {
      String commaValue = newValue;
      if (commaSelected) {
        if (calculationEnum == CalculationEnum.none) {
          stringValue1 += ',$commaValue';
          emit(Value1State(value: formatValue(parseDouble(stringValue1))));
        } else {
          stringValue2 += ',$commaValue';
          emit(Value2State(value: formatValue(parseDouble(stringValue2))));
        }
      } else {
        if (calculationEnum == CalculationEnum.none) {
          stringValue1 += newValue;
          emit(Value1State(value: formatValue(parseDouble(stringValue1))));
        } else {
          stringValue2 += newValue;
          emit(Value2State(value: formatValue(parseDouble(stringValue2))));
        }
      }
    } else {
      if (calculationEnum == CalculationEnum.none) {
        stringValue1 = newValue;
        emit(Value1State(value: formatValue(parseDouble(stringValue1))));
      } else {
        stringValue2 = newValue;
        emit(Value2State(value: formatValue(parseDouble(stringValue2))));
      }
    }
  }

  double parseDouble(String value) {
    final cleanedValue = value.replaceAll(',', '.');
    return double.parse(cleanedValue);
  }

  void calculatorWithEnum() {
    value1 = checkValue(stringValue1);
    value2 = checkValue(stringValue2);

    switch (calculationEnum) {
      case CalculationEnum.cong:
        result = value1 + value2;
        break;
      case CalculationEnum.tru:
        result = value1 - value2;
        break;
      case CalculationEnum.nhan:
        result = value1 * value2;
        break;
      case CalculationEnum.chia:
        result = value1 / value2;
        break;
      default:
        break;
    }

    emit(ResultState(result: formatValue(result)));


    stringValue1 = result.toString();
    stringValue2 = '';
    calculationEnum = CalculationEnum.none;
  }

  void handlePercent() {
    if (calculationEnum == CalculationEnum.none) {
      double convertValue1 = checkValue(stringValue1);
      updateValueWithEnum(
          newValue: (convertValue1 / 100).toString(), congDon: false);
    } else {
      double convertValue2 = checkValue(stringValue2);
      updateValueWithEnum(
          newValue: (convertValue2 / 100).toString(), congDon: false);
    }
  }

  void handleDaoNguoc() {
    if (calculationEnum == CalculationEnum.none) {
      double convertValue1 = checkValue(stringValue1);
      double newConvertValue1 = convertValue1 * (-1);
      updateValueWithEnum(
          newValue: newConvertValue1.toString(), congDon: false);
    } else {
      double convertValue2 = checkValue(stringValue2);
      updateValueWithEnum(
          newValue: (convertValue2 * (-1)).toString(), congDon: false);
    }
  }

  void selectedValue(CalculationEnum calculation) {
    if (calculationEnum != CalculationEnum.none) {
      calculatorWithEnum();
    }
    calculationEnum = calculation;
    selected = !selected;
    emit(SelectedValue(
      selected: selected,
      calculationEnum: calculation,
    ));
    commaSelected = false;
  }

  void handleComma() {
    commaSelected = true;
  }
}
