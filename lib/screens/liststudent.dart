import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_app/db/function/db_function.dart';
import 'package:student_app/db/model/db_model.dart';
import 'package:student_app/screens/details.dart';
import 'package:student_app/screens/editstudent.dart';



class ListStudent extends StatefulWidget {
  const ListStudent({super.key});

  @override
  State<ListStudent> createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  @override
  Widget build(BuildContext context) {
    return Container(      
      decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Color.fromARGB(255, 232, 227, 227),),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ValueListenableBuilder(
          valueListenable: studentlistNotifier, 
          builder: (BuildContext ctx,List<Studentmodel>studentList,Widget? child){
            if(studentList.isEmpty){ 
              return const Center( 
                child: Text('No Student Data Availabe',style: TextStyle(color: Colors.black),),
              );
            }
            return GridView.builder( 
              itemCount: studentList.length,
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                mainAxisExtent: 210,
                crossAxisSpacing:5
                ),
              itemBuilder: (ctx,index){
                final data=studentList[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){ return Details(details: data,);}));
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Color.fromARGB(255, 51, 40, 73)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: FileImage(File(data.image)),
                                    ),
                                    IconButton(onPressed: (){
                                     Navigator.of(context).push(MaterialPageRoute(builder: (context){return EditStudent(student: data,);}));
                                    }, 
                                    icon: Icon(Icons.edit,color: Colors.green,)
                                    ),
                                    IconButton(onPressed: (){deletebuttonclicked(data.id);}, icon: Icon(Icons.delete,color: Colors.red,)) 
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name:${data.name}',style:const TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                                    Text('Age:${data.age}',style:const TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                                    Text('Address:${data.address}',style:const TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                                    Text('Mobile:+91 ${data.mobile}',style:const TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),  
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            );
          }
        ),
      ),
    );
  }


  Future<void> deletebuttonclicked(id) async{ 
    showDialog(
      context: context, 
      builder: (ctx){
        return AlertDialog(
          content:const Text('Do You Want To Delete Details?'),
          actions: [
            TextButton(
              onPressed: (){
                deleteStudent(id);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor:  Color.fromARGB(255, 219, 14, 14),
                    margin: EdgeInsets.all(75),
                    content: Text(
                      'Student Details Deleted',
                      textAlign: TextAlign.center,
 
                    ),
                  ),
                );                
              }, 
              child:const Text('YES'),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child:const Text('NO')
            )
          ],
        );
      }
    );
  }

}

