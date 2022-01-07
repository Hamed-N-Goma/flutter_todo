import 'package:bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/sheard/bloc_observer.dart';
import 'package:flutter_todo/sheard/cubit/cubit.dart';

import 'layout/todo_home.dart';

void main() {

  BlocOverrides.runZoned(
        () {
AppTodoCubit().state;

},
    blocObserver: MyBlocObserver(),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   debugShowCheckedModeBanner: false,
      home:todo_home(),
    );
  }
}
