import 'package:flutter/material.dart';
import 'package:test_task/state_manager.dart';

class Provider extends InheritedWidget {
  final manager = StateManager();

  Provider({Key key, @required Widget child}) : super(key: key, child: child);

  static StateManager of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>().manager);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
