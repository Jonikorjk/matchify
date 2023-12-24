import 'package:matchify/managers/app_manager.dart';
import 'package:matchify/screens/launch_screen.dart';
import 'package:flutter/material.dart';

var appManager = AppManager();
final routeObserver = RouteObserver<ModalRoute<void>>();

void main() {
  runApp(
    MaterialApp(
      title: "App",
      theme: ThemeData.dark(useMaterial3: false),
      navigatorObservers: [routeObserver],
      home: const LaunchScreen(),
    ),
  );
}
