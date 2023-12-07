import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_app/db/function/db_function.dart';
import 'package:student_app/screens/editstudent.dart';

class Details extends StatefulWidget {
  var details;
    Details({super.key,required this.details});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  @override
  void initState() {
    getAllStudents();
    setState(() {
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.details.name,style: TextStyle(fontWeight: FontWeight.w600),),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
         
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child:  Column(
              children: [
                 Card(
                  elevation: 10,              
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                         SizedBox(
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                CircleAvatar(
                                  radius: 80,
                                  backgroundImage: FileImage(File(widget.details.image)), 
                                ),
                                IconButton(onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){return EditStudent(student: widget.details,);}));                           
                                  }, icon: Icon(Icons.edit,color: Colors.green,)
                                )
                             ],
                           ),
                         ),
                        ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('NAME:${widget.details.name}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                              Text('AGE:${widget.details.age}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                              Text('ADDRESS:${widget.details.address}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                              Text('MOBILE:${widget.details.mobile}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}