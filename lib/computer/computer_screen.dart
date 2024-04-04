import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_computer/computer/computer_cubit.dart';
import 'package:flutter_computer/computer/computer_state.dart';
import 'package:flutter_computer/main.dart';
import 'package:flutter_computer/utils/computer_enum.dart';

class ComputerScreen extends StatefulWidget {
  const ComputerScreen({Key? key}) : super(key: key);

  @override
  State<ComputerScreen> createState() => _ComputerScreenState();
}

class _ComputerScreenState extends State<ComputerScreen> {
  final ComputerCubit _computerCubit = getIt.get<ComputerCubit>();
  String result = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: BlocProvider<ComputerCubit>(
            create: (_) => _computerCubit,
            child: BlocConsumer<ComputerCubit, ComputerState>(
              listener: (_, ComputerState state) {
                _handleListener(state);
              },
              builder: (_, ComputerState state) {
                //context
                return Container(
                  child: itemBody(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget itemBody() {
    return Column(
      children: [
        Expanded(flex: 3, child: itemCalculator()),
        Expanded(
            flex: 7,
            child: Container(
                margin: const EdgeInsets.all(16), child: itemButton())),
      ],
    );
  }

  Widget itemCalculator() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.bottomRight,
        child: BlocBuilder<ComputerCubit, ComputerState>(
          builder: (_, ComputerState state) {
            return Text(
              result,
              style: const TextStyle(fontSize: 32, color: Colors.white),
            );
          },
        ),
      ),
    );
  }

  Widget itemButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        itemRow1(),
        itemRow2(),
        itemRow3(),
        itemRow4(),
        itemRow5(),
      ],
    );
  }

  Widget itemRow1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        itemDetailNumberlButton(
          colorButton: Colors.white.withOpacity(0.7),
          text: 'AC',
          colorText: Colors.black,
          selected: () {
            _computerCubit.clearValues();
          },
        ),
        itemDetailNumberlButton(
          colorButton: Colors.white.withOpacity(0.7),
          text: '+/-',
          colorText: Colors.black,
          selected: () {
            _computerCubit.handleDaoNguoc();
          },
        ),
        itemDetailNumberlButton(
          colorButton: Colors.white.withOpacity(0.7),
          text: '%',
          colorText: Colors.black,
          selected: () {
            _computerCubit.handlePercent();
          },
        ),
        itemDetailButton(
          colorButton: Colors.orange,
          text: '/',
          colorText: Colors.white,
          calculation: CalculationEnum.chia,
          selected: () {
            _computerCubit.selectedValue(CalculationEnum.chia);
          },
        ),
      ],
    );
  }

  Widget itemRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        itemDetailNumberlButton(
          colorButton: Colors.grey.withOpacity(0.6),
          text: '7',
          colorText: Colors.white,
          selected: () {
            _computerCubit.updateValueWithEnum(newValue: '7');
          },
        ),
        itemDetailNumberlButton(
          colorButton: Colors.grey.withOpacity(0.6),
          text: '8',
          colorText: Colors.white,
          selected: () {
            _computerCubit.updateValueWithEnum(newValue: '8');
          },
        ),
        itemDetailNumberlButton(
          colorButton: Colors.grey.withOpacity(0.6),
          text: '9',
          colorText: Colors.white,
          selected: () {
            _computerCubit.updateValueWithEnum(newValue: '9');
          },
        ),
        itemDetailButton(
          colorButton: Colors.orange,
          text: 'x',
          colorText: Colors.white,
          calculation: CalculationEnum.nhan,
          selected: () {
            _computerCubit.selectedValue(CalculationEnum.nhan);
          },
        ),
      ],
    );
  }

  Widget itemRow3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        itemDetailNumberlButton(
          colorButton: Colors.grey.withOpacity(0.6),
          text: '4',
          colorText: Colors.white,
          selected: () {
            _computerCubit.updateValueWithEnum(newValue: '4');
          },
        ),
        itemDetailNumberlButton(
          colorButton: Colors.grey.withOpacity(0.6),
          text: '5',
          colorText: Colors.white,
          selected: () {
            _computerCubit.updateValueWithEnum(newValue: '5');
          },
        ),
        itemDetailNumberlButton(
          colorButton: Colors.grey.withOpacity(0.6),
          text: '6',
          colorText: Colors.white,
          selected: () {
            _computerCubit.updateValueWithEnum(newValue: '6');
          },
        ),
        itemDetailButton(
          colorButton: Colors.orange,
          text: '-',
          colorText: Colors.white,
          calculation: CalculationEnum.tru,
          selected: () {
            _computerCubit.selectedValue(CalculationEnum.tru);
          },
        ),
      ],
    );
  }

  Widget itemRow4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        itemDetailNumberlButton(
          colorButton: Colors.grey.withOpacity(0.6),
          text: '1',
          colorText: Colors.white,
          selected: () {
            _computerCubit.updateValueWithEnum(newValue: '1');
          },
        ),
        itemDetailNumberlButton(
          colorButton: Colors.grey.withOpacity(0.6),
          text: '2',
          colorText: Colors.white,
          selected: () {
            _computerCubit.updateValueWithEnum(newValue: '2');
          },
        ),
        itemDetailNumberlButton(
          colorButton: Colors.grey.withOpacity(0.6),
          text: '3',
          colorText: Colors.white,
          selected: () {
            _computerCubit.updateValueWithEnum(newValue: '3');
          },
        ),
        itemDetailButton(
          colorButton: Colors.orange,
          text: '+',
          colorText: Colors.white,
          calculation: CalculationEnum.cong,
          selected: () {
            _computerCubit.selectedValue(CalculationEnum.cong);
          },
        ),
      ],
    );
  }

  Widget itemRow5() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        itemZero(),
        itemDetailNumberlButton(
          colorButton: Colors.grey.withOpacity(0.6),
          text: ',',
          colorText: Colors.white,
          selected: () {
            _computerCubit.handleComma();
          },
        ),
        itemDetailNumberlButton(
          colorButton: Colors.orange,
          text: '=',
          colorText: Colors.white,
          selected: () {
            _computerCubit.calculatorWithEnum();
          },
        ),
      ],
    );
  }

  Widget itemZero() {
    return GestureDetector(
      onTap: () {
        _computerCubit.updateValueWithEnum(newValue: '0');
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(360),
              color: Colors.grey.withOpacity(0.6)),
          child: Row(
            children: [
              itemDetailNumberlButton(
                text: '0',
                colorText: Colors.white,
              ),
              const SizedBox(
                width: 16,
              ),
              itemDetailNumberlButton(),
            ],
          )),
    );
  }
  Widget itemDetailButton(
      {Color? colorButton,
      String? text,
      Color? colorText,
      CalculationEnum calculation = CalculationEnum.none,
      VoidCallback? selected}) {
    return BlocBuilder<ComputerCubit, ComputerState>(
      builder: (_, ComputerState state) {
        if (state is SelectedValue) {
          bool isSelected = calculation == state.calculationEnum;
          return GestureDetector(
            onTap: selected,
            child: Container(
              padding: const EdgeInsets.all(16),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(360),
                  color: isSelected ? Colors.white : colorButton),
              child: Center(
                  child: Text(
                text ?? '',
                style: TextStyle(
                    color: isSelected ? Colors.orange : colorText,
                    fontSize: 24),
              )),
            ),
          );
        }
        return GestureDetector(
          onTap: selected,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360), color: colorButton),
            child: Center(
                child: Text(
              text ?? '',
              style: TextStyle(color: colorText, fontSize: 24),
            )),
          ),
        );
      },
    );
  }

  Widget itemDetailNumberlButton(
      {Color? colorButton,
      String? text,
      Color? colorText,
      VoidCallback? selected}) {
    return GestureDetector(
      onTap: selected,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(360), color: colorButton),
        child: Center(
            child: Text(
          text ?? '',
          style: TextStyle(color: colorText, fontSize: 24),
        )),
      ),
    );
  }

  void _handleListener(ComputerState state) {
    if (state is Value1State) {
      result = state.value;
      return;
    }
    if (state is Value2State) {
      result = state.value;
      return;
    }
    if (state is ResultState) {
      result = state.result;
      return;
    }
  }
}
