import 'package:flutter/material.dart';
import 'package:test_task/provider.dart';
import 'package:test_task/widgets/main_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider(
        child: MainWidget(),
      ),
    );
  }
}
