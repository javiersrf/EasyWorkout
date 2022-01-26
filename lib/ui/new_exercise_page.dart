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


class NewExercisePage extends StatefulWidget {

  List currentTrain=[];
  NewExercisePage(this.currentTrain);


  @override
  _NewExercisePageState createState() => _NewExercisePageState();
}



class _NewExercisePageState extends State<NewExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Novo Exercício'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,

      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: exerciseList.length,
          itemBuilder: (context,index){
            return newexerciseCard(context, index);
          }),
    );
  }


Widget newexerciseCard(BuildContext context,int index){
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
                      Text(exerciseList[index][1],
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text(exerciseList[index][2],
                        style: TextStyle(fontSize: 14),),


                    ],
                  )
              ),
            ],
          ),
        )
    ),
    onTap: (){
      addNewExercise(index);
    },
  );
}

  void addNewExercise(index){
    setState(() {

      Map newEx=Map();
      newEx['id']=exerciseList[index][0];
      newEx['name']=exerciseList[index][1];
      newEx['pMuscle']=exerciseList[index][2];
      newEx['sMuscle']=exerciseList[index][3];
      newEx['URL']=exerciseList[index][4];
      newEx['priority']=exerciseList[index][5];
      newEx['method']='3x12 reps';
      newEx['weight']='0 kg';
      widget.currentTrain.add(newEx);
      saveTrainsList();
      Navigator.pop(context);
      Navigator.pop(context);
      _showTrainPage(widget.currentTrain);


    });


  }

  void _showTrainPage(List selectedTrain) async{

    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TrainPage(selectedTrain)));
  }




}

