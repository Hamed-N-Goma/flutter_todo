
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/modules/archived.dart';
import 'package:flutter_todo/modules/done_tasks.dart';
import 'package:flutter_todo/modules/tasks.dart';
import 'package:flutter_todo/sheard/cubit/status.dart';
import 'package:sqflite/sqflite.dart';

class AppTodoCubit extends Cubit<AppStatus> {
  AppTodoCubit() : super(AppInitState());

  static AppTodoCubit get(context)=>BlocProvider.of(context);
  int curruntindex=0;
  List<Widget>Screens=[
    tasks(),
    done_tasks(),
    archived()

  ];
  List<String> titles=[
    "new Tasks",
    "Done Tasks",
    "Archived Tasks"
  ];
//switch:secreens Index
  void Chaneindex(int Index){
    curruntindex=Index;
    emit(AppChangeBottmNavBarStatus());
  }

  //DataBase sqflite

  late Database db;
  bool isopen=false;
  IconData fabIcon=Icons.edit;
  //map list to recive data form db
  List<Map> taskslist=[];


  void createdb() {
     openDatabase (
        'todo.db',version: 1,
        onCreate:(db,version){
          print("database created");

          db.execute("CREATE TABLE tasks( id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT,status TEXT )").then((value) {
            print(' table created');
          }).catchError((error){
            print("this is error ${error.toString()}" );
          });
        },

        onOpen: (db){
          getDataFromdb(db).then((value){
            taskslist=value;
            emit(GetDataFromDatabase());
          });
          print("Database opend");
        }

    ).then((value) {
      db=value;
      emit(CreateDatabaseState());
    });
  }

   insrtDatabase ({required String title,required String time,required String date}) async{

    return await db.transaction((txn) async {
      txn.rawInsert('INSERT INTO tasks(title,date,time,status)VALUES("$title","$date","$time","new")').then
        ((value) {
        print("insert sucsessfuly");
        emit(AppInsertDatabase());

        getDataFromdb(db).then((value){
          taskslist=value;
          emit(GetDataFromDatabase());

        });

      }).catchError((error){
        print("this is error ${error}");
      });

    }
    );


  }

  Future<List<Map>> getDataFromdb(db)
  async{

    emit(GetDatabaseloading());
    return await db.rawQuery("SELECT *FROM  tasks");

  }

  void ChageBottomSheet(
      {required bool  isShow,
        required IconData icon
      })
  {
      isopen=isShow;
      fabIcon=icon;
      emit(ChangeBottomSheetState());
  }








}