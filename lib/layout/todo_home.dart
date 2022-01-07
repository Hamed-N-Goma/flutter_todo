import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/modules/archived.dart';
import 'package:flutter_todo/modules/done_tasks.dart';
import 'package:flutter_todo/modules/tasks.dart';
import 'package:flutter_todo/sheard/component/components.dart';
import 'package:flutter_todo/sheard/component/constans.dart';
import 'package:flutter_todo/sheard/cubit/cubit.dart';
import 'package:flutter_todo/sheard/cubit/status.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
class todo_home extends StatelessWidget {

  var titlecontoller=TextEditingController();
  var timecontoller=TextEditingController();
  var datecontroller=TextEditingController();


  var Scaffoldkey=GlobalKey<ScaffoldState>();
  var formkey=GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
  return BlocProvider(create: (BuildContext context)=>AppTodoCubit()..createdb(),

    child: BlocConsumer<AppTodoCubit,AppStatus>(
        builder: (BuildContext context,AppStatus state){
          AppTodoCubit Cubit=AppTodoCubit.get(context);
          return Scaffold(
            key:Scaffoldkey,
            appBar: AppBar(
              title: Text(

                Cubit.titles[Cubit.curruntindex],
                style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold
                ),
              ),
            ),
            ////Fab
            floatingActionButton:FloatingActionButton(
              onPressed: ()  {
                if(Cubit.isopen){

                  if(formkey.currentState!.validate()){
                    Cubit.insrtDatabase(title: titlecontoller.text, time: timecontoller.text, date: datecontroller.text);

                  }


                }else{
                  Scaffoldkey.currentState?.showBottomSheet((context)=>Container(

                    color: Colors.white,
                    padding: EdgeInsets.all(20.0),
                    child: Form(

                      key: formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultformfeild(pre: Icons.title,
                              control: titlecontoller,
                              labeltext: "title",
                              inputType: TextInputType.text,
                              validator: ( value){
                                if(value!.isEmpty){
                                  return "title must not be empty";
                                }
                                return null;

                              }),
                          SizedBox(
                            height: 15,
                          ),


                          //
                          defaultformfeild(
                              pre: Icons.watch_later_outlined,
                              control: timecontoller,
                              labeltext: " task time",
                              inputType: TextInputType.datetime,
                              ontap: (){
                                showTimePicker(context: context,
                                    initialTime: TimeOfDay.now()).then((value) {
                                  timecontoller.text=value!.format(context).toString();
                                });
                              },
                              validator: ( value){
                                if(value!.isEmpty){
                                  return " time must not be empty";
                                }
                                return null;

                              }),
                          SizedBox(
                            height: 15,
                          )
                          ,//date picker
                          defaultformfeild(
                              pre: Icons.calendar_today_outlined,
                              control: datecontroller,
                              labeltext: " date time",
                              inputType: TextInputType.datetime,
                              ontap: (){
                                showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(),lastDate:DateTime.parse('2022-05-03'), )
                                    .then((value) {
                                  datecontroller.text=DateFormat.yMMMd().format(value!);
                                });
                              },
                              validator: ( value){
                                if(value!.isEmpty){
                                  return " date time must not be empty";
                                }
                                return null;

                              })
                        ],

                      ),
                    ),
                  ),
                    elevation: 20.0,).closed.then((value)  {
                      Cubit.ChageBottomSheet(isShow: false, icon: Icons.edit);

                  });

                      Cubit.ChageBottomSheet(isShow: true, icon: Icons.add);

                }

              }

              , child: Icon(Cubit.fabIcon),),
            bottomNavigationBar: BottomNavigationBar(
              type:BottomNavigationBarType.fixed ,
              currentIndex:Cubit.curruntindex ,
              onTap: (index){

                Cubit.Chaneindex(index);
                /*setState(() {
    curruntindex=index;
    });*/

              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu ,),
                    label: 'Tasks'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline_outlined,),
                    label:'Done'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive ,),
                    label: 'Archived'
                ),

              ],),

            body: ConditionalBuilder(
              condition:State is! GetDatabaseloading ,
              builder: (context)=> Cubit.Screens[Cubit.curruntindex],
              fallback: (context)=>Center(child: CircularProgressIndicator()),

            ),
          );
        },
        listener: (BuildContext context,AppStatus state){
          if(state is AppInsertDatabase){

            Navigator.pop(context);
            titlecontoller.clear();
            timecontoller.clear();
            datecontroller.clear();
                    }

        }),
  );
  }



}



