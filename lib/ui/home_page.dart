import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:easy_train/ui/train_division_page.dart';
import "package:path_provider/path_provider.dart";
import 'package:easy_train/main_functions/read_csv.dart';
import 'package:easy_train/main_functions/training_types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

import 'my_trains_page.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    extractList().then((exerciseList){
      exerciseList=exerciseList;});


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easy Workout'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            HomeScreenCards(context, 'Meus Treinos', showMyTrainsPage),


          ],),
    );
  }



  // criar lista de exercicios a partir do csv
   Future<List<dynamic>> extractList() async {

    final myData = await rootBundle.loadString("assets/videos_and_exercicios.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

    for (int i = 1; i < csvTable.length-1; i++) {
      exerciseList.add(csvTable[i][0].split(";"));

    }
    return exerciseList;

  }

  void showMyTrainsPage() async{

    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyTrainsPage()));
  }



  Widget HomeScreenCards(BuildContext context,String text,Function func ){
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
                        Text(text,
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),


                      ],
                    )
                ),
              ],
            ),
          )
      ),
      onTap:()async{func();},

    );


  }

}
