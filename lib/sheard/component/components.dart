
//textformfield

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultformfeild(
    { IconData? suffixicon,
      bool ispassword=false,
      required IconData pre,
      required String labeltext,
      required TextInputType inputType,
      required FormFieldValidator<String>?validator  ,
      bool? isClickable,
      VoidCallback? ontap,

      TextEditingController? control,
      VoidCallback?iconbuttonPressd
    }
    )=>
    TextFormField(
      decoration: InputDecoration(
        suffixIcon: IconButton(onPressed:iconbuttonPressd,icon:Icon(suffixicon)),
        prefixIcon: Icon(pre),

        border: OutlineInputBorder(),
        labelText: labeltext,
      ),
//controller: ,
    enabled: isClickable,
      obscureText:ispassword,
      controller: control,
      onTap: ontap,
      keyboardType:inputType ,
      validator:validator ,
    );

Widget buildTaskItem(Map model)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40.0,
        child: Text('${model['time']}'),
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${model['title']}',

              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18
              ),),
            Text('${model['date']}',
              style: TextStyle(color:Colors.grey),
            )
          ],
        ),
      ),
      IconButton(onPressed: (){}, icon:Icon(Icons.check_box),color: Colors.green,),
      IconButton(onPressed: (){}, icon: Icon(Icons.archive),color: Colors.grey,)
    ],
  ),
);