import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/db/function/db_function.dart';
import 'package:student_app/db/model/db_model.dart';

File? image1;
String? image;

class AddStudent extends StatefulWidget {
 const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  final GlobalKey<FormState> _validation = GlobalKey<FormState>();

  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _mobilecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Student Details'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Form(
                  key: _validation,
                  child: Column(
                    children: [
        
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage:image1 != null
                            ? FileImage(image1!)
                            :  AssetImage('images/circle avatar.png')
                            as ImageProvider,
                            radius: 70,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () {
                                    fromgallery();
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.deepPurple,
                                    size: 20,
                                  )),
                            ),
                          )
                        ],
                      ),
        
        
                      SizedBox(height: 25),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please eneter the name';
                          }
                        },
                        controller: _namecontroller,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.abc),
                            border: OutlineInputBorder(),
                            labelText: 'Name'),
                        textCapitalization: TextCapitalization.words,    
                      ),
        
        
                      SizedBox(height: 25),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please eneter the age';
                          }
                        },
                        controller: _agecontroller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(2)],
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.calendar_month),
                            border: OutlineInputBorder(),
                            labelText: 'Age'),
                      ),
       
        
                      SizedBox(height: 25),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please eneter the Place';
                          }
                        },
                        controller: _addresscontroller,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.place),
                            border: OutlineInputBorder(),
                            labelText: 'Place'
                          ),
                          textCapitalization: TextCapitalization.words,
                      ),
        
        
                      SizedBox(height: 25),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty||value.length!=10) { 
                            return 'Please eneter a valid phone number';
                          }
                        },
                        controller: _mobilecontroller,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '+91 ',
                          prefixStyle:
                              TextStyle(color: Colors.black, fontSize: 16),
                          suffixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                          labelText: 'Mobile',
                        ),
                      ),
        
        
                    ],
                  )
                ),
        
              SizedBox(height: 25),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: Size(360, 45 )),
                  onPressed: () {
                    onSubmitButtonClicked(context);
                  },                 
                  icon: Icon(Icons.check),
                  label: Text('Submit')
              ),

            ],
          ),
        ),
      )),
    );
  }



  Future<void> onSubmitButtonClicked(BuildContext context) async{
    final name=_namecontroller.text.trim();
    final age=_agecontroller.text.trim();
    final address=_addresscontroller.text.trim();
    final mobile=_mobilecontroller.text.trim();

    if(_validation.currentState!.validate()&&image1!=null){
      final student= Studentmodel(name: name, age: age, address: address, mobile: mobile, image: image!);
      await addStudent(student);
     
      Navigator.of(context).pop();
      clearStudentProfilephoto();
      submitbuttondetailsok();
    }
    else if(_validation.currentState!.validate()&&image1==null){
      submitbuttondetailnotok(); 
    }
  } 


  Future<void> fromgallery() async {
    final img1 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img1 != null) {
      setState(() {
        image1 = File(img1.path);
        image = image1!.path;
      });
    }
  }

  clearStudentProfilephoto() {
    _namecontroller.text = '';
    _agecontroller.text = '';
    _addresscontroller.text = '';
    _mobilecontroller.text = '';
    setState(() {
      image1 = null;
    });
  }

  submitbuttondetailsok(){
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor:  Color.fromARGB(255, 30, 189, 22),
          margin:  EdgeInsets.all(75),
          content: Text(
            'Student Details Submitted',
            textAlign: TextAlign.center,
            style:  TextStyle(color: Colors.black),
          ),
        ),
      );
  }

  submitbuttondetailnotok(){
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor:  Color.fromARGB(255, 244, 70, 70),
          margin:  EdgeInsets.all(75),
          content: Text(
            'Please Add Student Identity Photo',
            textAlign: TextAlign.center,
            style:  TextStyle(color: Colors.black),
          ),
        ),
      );
  }

}
