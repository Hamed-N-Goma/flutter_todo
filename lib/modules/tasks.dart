import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/sheard/component/components.dart';
import 'package:flutter_todo/sheard/component/constans.dart';
import 'package:flutter_todo/sheard/cubit/cubit.dart';
import 'package:flutter_todo/sheard/cubit/status.dart';

class tasks extends StatelessWidget {
  const tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTodoCubit cubit=BlocProvider.of(context);
    return BlocConsumer<AppTodoCubit,AppStatus>(
      builder:(BuildContext context,AppStatus state){
      return ListView.separated(
          itemBuilder: (context,Index)=>buildTaskItem(cubit.taskslist[Index]),
          separatorBuilder: (context,index)=>Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ), itemCount: cubit.taskslist.length);
    }
      ,listener:(BuildContext context,AppStatus state){

    } ,

    );
}
}
