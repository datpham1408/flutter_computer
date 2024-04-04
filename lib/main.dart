import 'package:flutter/material.dart';
import 'package:flutter_computer/computer/computer_cubit.dart';
import 'package:flutter_computer/my_application.dart';
import 'package:get_it/get_it.dart';
final GetIt getIt = GetIt.instance;

void main() async {
  await initGetIt();
  await initCubit();
  runApp(const Application());
}


Future<void> initGetIt() async {}

Future<void> initCubit() async {
  getIt.registerLazySingleton<ComputerCubit>(() => ComputerCubit());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyApplication(),
    );
  }
}
