import 'package:easy_train/main_functions/read_csv.dart';
import 'package:easy_train/main_functions/training_types.dart';
import 'package:easy_train/ui/train_division_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'train_page.dart';
import 'my_trains_page.dart';
import 'dart:convert';



class NewTrainPage extends StatefulWidget {
  @override
  _NewTrainPageState createState() => _NewTrainPageState();
}

class _NewTrainPageState extends State<NewTrainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Novo Treino'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,

      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: newTrainList.length,
          itemBuilder: (context,index){
            return newTrainCard(context, index);
          }),
    );
  }


  Widget newTrainCard(BuildContext context,int index){
    return GestureDetector(

        child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[

                  Padding(
                      padding: EdgeInsets.only(left:10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(newTrainList[index][0]['name'],
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),


                        ],
                      )
                  ),
                ],
              ),
            )
        ),
        onTap:()async{addNewTrain(index);},

    );


  }

  void addNewTrain(index){
     setState(() {

      myTrainsList.add(newTrainList[index][0]);
      saveTrainsList();
      Navigator.pop(context);
      Navigator.pop(context);
      _showMyTrainsPage();


    });


  }

  void _showMyTrainsPage() async{

    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyTrainsPage()));
  }






}

