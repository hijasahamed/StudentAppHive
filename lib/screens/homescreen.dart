 

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:student_app/db/function/db_function.dart';
import 'package:student_app/db/model/db_model.dart';

import 'package:student_app/screens/addstudent.dart';
import 'package:student_app/screens/details.dart';

import 'package:student_app/screens/liststudent.dart';


class Homescreen extends StatelessWidget {
  const Homescreen({super.key});


  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [           
            PopupMenuButton( 
              elevation: 20,
              shadowColor: Colors.grey,
              iconSize: 35,
              icon: Icon(Icons.list),
              itemBuilder: (context) => [
                PopupMenuItem(
                onTap: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (ctx){return ListStudent();}));
                },
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.person_search,color: Colors.green,),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Students')
                    ],
                  ),
                ),
                const PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.star,color: Color.fromARGB(255, 247, 223, 3),),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Get The App')
                    ],
                  ),
                ),
                const PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.chrome_reader_mode,color: Colors.blue,),
                      SizedBox(
                        width: 10,
                      ),
                      Text('About')
                    ],
                  ),
                ),
                const PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.settings,color: Colors.grey,),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Settings')
                    ],
                  ),
                ),
              ]
            ),
            Text('STUDENT APP', style: TextStyle(fontWeight: FontWeight.w900),),
            IconButton(onPressed: () {
              showSearch(context: context, delegate: Search()); 
             }, icon: Icon(Icons.search)
            ),
          ],
        ),
      ),


      
      body: Column( 
        children: [
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration:const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(image: AssetImage('images/donbosco.png'),fit: BoxFit.fill) 
                ),
              ),
            ),
          ), 
          const Flexible(
            flex: 12 ,
            child: SizedBox(           
              child: Padding(
                padding: EdgeInsets.all(5),
                child: ListStudent(),
              ),
            ),
          ),
          Flexible(
              flex: 2,
              child: Container(
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return AddStudent();
                        }));
                      },                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 11, 11, 11),
                        minimumSize:const Size(200,60 )
                      ),
                      child:const Text('Add Student',style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w600,letterSpacing: 1),),
                    ),
                ),
              )
            ),
        ],
      ),
    );
  }
}


class Search extends SearchDelegate {
  List data = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear_rounded))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<Box<Studentmodel>>(
        future: Hive.openBox<Studentmodel>('student_db'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final stdbox = snapshot.data!.values.toList();
            final filteredData =stdbox
                .where((data) =>
                    data.name.toLowerCase().contains(query.toLowerCase()))
                .toList();
            if (query.isEmpty) {
              return const SizedBox();
            }
            else if(filteredData.isEmpty){
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('No Result',style: TextStyle(fontWeight: FontWeight.w500),)),
              ],
              );  
            }
            return ListView.builder(
              itemBuilder: (ctx, index) {
                final data = filteredData[index];
                String namevalue = data.name;
                if (namevalue.toLowerCase().contains(query.toLowerCase())) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {                       
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => Details(details: data) 
                          ));
                        },
                        leading: CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(File(data.image)),
                        ),
                        title: Text(
                          data.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                      ),
                      const SizedBox(height: 12,),
                    ],
                  );
                } 
                else {
                  return const SizedBox();
                }
              },
              itemCount: filteredData.length,
            );
          } 
          else {
            return const SizedBox();
          }
        });
  }

  @override
  Widget buildResults(BuildContext context) {
     return FutureBuilder<Box<Studentmodel>>(
        future: Hive.openBox<Studentmodel>('student_db'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final stdbox = snapshot.data!.values.toList();
            final filteredData =stdbox
                .where((data) =>
                    data.name.toLowerCase().contains(query.toLowerCase()))
                .toList();
            if (query.isEmpty) {
              return SizedBox();
            }
            else if(filteredData.isEmpty){
              return const  Column(
                mainAxisAlignment: MainAxisAlignment.center ,
              children: [
                Center(child: Text('Sorry Searched Result Not Found',style: TextStyle(fontWeight: FontWeight.w500),)),
              ],
              );  
            }
            return ListView.builder(
              itemBuilder: (ctx, index) {
                final data = filteredData[index];
                String namevalue = data.name;
                if (namevalue.toLowerCase().contains(query.toLowerCase())) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {                       
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => Details(details: data) 
                          ));
                        },
                        leading: CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(File(data.image)),
                        ),
                        title: Text(
                          data.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                      ),
                      const SizedBox(height: 12,),
                    ],
                  );
                } 
                else {
                  return const SizedBox();
                }
              },
              itemCount: filteredData.length,
            );
          } 
          else {
            return const SizedBox();
          }
        });
  }
}

