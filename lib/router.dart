import 'package:flutter/material.dart';
import 'package:flutter_computer/computer/computer_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter routerMyApp = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ComputerScreen();
      },
    ),

  ],
);
