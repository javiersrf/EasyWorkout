import 'package:easy_train/main_functions/read_csv.dart';
import 'package:easy_train/main_functions/training_types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'new_exercise_page.dart';
import 'new_train_page.dart';


class TrainPage extends StatefulWidget {

  final List newtrain;
  TrainPage(this.newtrain );


  @override
  _TrainPageState createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {



  @override
  void initState() {
    super.initState();
  }




//tela principal
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercicios'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          showNewExercisePage();},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: widget.newtrain.length,
          itemBuilder: (context,index){
            return exerciseCard(context, index);
          }),
    );
  }

  //cards de exercicios
  Widget exerciseCard(BuildContext context,int index){
    return GestureDetector(

      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
          child:
      Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[

                Padding(
                    padding: EdgeInsets.only(left:10),
                    child:
                    Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left:0),
                            child:
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.newtrain[index]['name'],
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                Row(
                              children: <Widget>[
                                    Text(widget.newtrain[index]['pMuscle'],
                                  style: TextStyle(fontSize: 14),),
                                     Text(' // '+widget.newtrain[index]['method'],
                                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                ])


                      ],
                    )
                    )
              ]
      )
                ),
              ],
            ),
          )
      ),),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Card(
              child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.newtrain[index]['weight'],
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ])))])
                ]
              ),
      onLongPress: (){showExerciseOptions(context,index);},
    );
  }


  List ExerciseSubs=[];
  int oldExerciseIndex;


//tela de opçao ao clicar e segurar
  void showExerciseOptions(BuildContext context,int index){
    showModalBottomSheet(context: context,
        builder: (context){
          return BottomSheet(
              onClosing: (){},
              builder: (context){
                return Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ExOptionsContainer(index,'Excluir',deleteSelectedExercise),
                        ExOptionsContainer(index,'Substituir equivalente',showChangeSelectedExercise),
                        ExOptionsContainer(index,'Modificar método',showChangeMethod),
                        ExOptionsContainer(index,'Alterar peso',showChangeWeight),
                      ],
                    )
                );
              }
          );
        });
  }

//cada opção, com o texto e a função associada
  Widget ExOptionsContainer(index,String text,Function func){
    return Padding(
      padding: EdgeInsets.all(10),
      child:FlatButton(
        child: Text(text,
          style: TextStyle(color: Colors.red,fontSize: 20),
        ),
        onPressed: (){
          func(index);
        },
      ),
    );
  }

  //função de deletar exercicio, é chamada pelo container
  void deleteSelectedExercise(index) {
    setState(() {
      widget.newtrain.removeAt(index);
      Navigator.pop(context);
      saveTrainsList();
    });
  }

  //função que chama a tela de exercicios substitutos
  void showChangeSelectedExercise (index)  {
    //criar lista de exercicios personalizada
    oldExerciseIndex=index;
    ExerciseSubs=[];
    ExerciseSubs=  secondaryFilterList(widget.newtrain[index]['pMuscle'],widget.newtrain[index]['sMuscle']);
    changeExerciseField(context,index);

  }

  //função que mostra a tela de exercicios substitutos
  void changeExerciseField(BuildContext context,int index){
    showModalBottomSheet(context: context,
        builder: (context){
          return BottomSheet(
              onClosing: (){},
              builder: (context){return
                Scaffold(
                  appBar: AppBar(
                    title: Text('Substitutos(Clique e segure)'),
                    backgroundColor: Colors.red,
                    centerTitle: true,
                  ),
                  backgroundColor: Colors.white,
                  body: ListView.builder(

                      padding: EdgeInsets.all(10),
                      itemCount: ExerciseSubs.length,
                      itemBuilder: (context,index){
                        return subexerciseCard(context, index);
                      }),
                );
              }
          );

        });
  }

  //card de exercicios substitutos
  Widget subexerciseCard(BuildContext context,int index){
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
                        Text(ExerciseSubs[index][1],
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Text(ExerciseSubs[index][2],
                          style: TextStyle(fontSize: 14),),


                      ],
                    )
                ),
              ],
            ),
          )
      ),
      onLongPress: (){
        changeExercise(index,oldExerciseIndex);
        },
    );
  }




//função que troca um exercicio
  void changeExercise(index,oldIndex) {

    setState(() {
      //escrever valores no mapa do exercicio
      widget.newtrain[oldIndex]['id']=ExerciseSubs[index][0];
      widget.newtrain[oldIndex]['name']=ExerciseSubs[index][1];
      widget.newtrain[oldIndex]['pMuscle']=ExerciseSubs[index][2];
      widget.newtrain[oldIndex]['sMuscle']=ExerciseSubs[index][3];
      widget.newtrain[oldIndex]['URL']=ExerciseSubs[index][4];
      widget.newtrain[oldIndex]['priority']=ExerciseSubs[index][5];
      Navigator.pop(context);
      saveTrainsList();
    });
  }

  //tela de adicionar novo exercicio
  void showNewExercisePage() async{

    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NewExercisePage(widget.newtrain)));
  }


  String weightrename="";
  TextEditingController weightrenameText = TextEditingController();

  void showChangeWeight (index) {
    changeWeightField(context,index);

  }

  void changeWeightField(BuildContext context,int index){
    showModalBottomSheet(context: context,
        builder: (context){
          return BottomSheet(
              onClosing: (){},
              builder: (context){return
                Scaffold(
                    resizeToAvoidBottomInset: true,
                    body:Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,

                            children: <Widget>[
                              Expanded(
                                child:TextField(
                                  controller: weightrenameText,
                                  decoration: InputDecoration(
                                    labelText: "Novo peso",
                                    labelStyle: TextStyle(color: Colors.black),

                                  ),
                                    maxLength: 8
                                ),
                              ),
                              RaisedButton(
                                color: Colors.red,
                                child: Text("Modificar"),
                                textColor: Colors.white,
                                onPressed: (){reweightSelectedExercise(index);},

                              ),
                            ]
                        )
                    )
                );
              }
          );

        });
  }




  void reweightSelectedExercise(index) {

    setState(() {
      weightrename=weightrenameText.text;
      Navigator.pop(context);
      if(weightrename!=""){
        widget.newtrain[index]['weight']=weightrename;};
      weightrenameText.text="";
      Navigator.pop(context);
      saveTrainsList();
    });
  }


  //função que chama a tela de métodos
  void showChangeMethod (index)  {
    oldExerciseIndex=index;
    changeMethodField(context,index);

  }

  //função que mostra a tela de métodos substitutos
  void changeMethodField(BuildContext context,int index){
    showModalBottomSheet(context: context,
        builder: (context){
          return BottomSheet(
              onClosing: (){},
              builder: (context){return
                Scaffold(
                  appBar: AppBar(
                    title: Text('Modificar método'),
                    backgroundColor: Colors.red,
                    centerTitle: true,
                  ),
                  backgroundColor: Colors.white,
                  body: ListView.builder(

                      padding: EdgeInsets.all(10),
                      itemCount: methodList.length,
                      itemBuilder: (context,index){
                        return subMethodCard(context, index);
                      }),
                );
              }
          );

        });
  }

  //card de métodos
  Widget subMethodCard(BuildContext context,int index){
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
                        Text(methodList[index],
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),



                      ],
                    )
                ),
              ],
            ),
          )
      ),
      onTap: (){
        changeMethod(index,oldExerciseIndex);
      },
    );
  }




//função que troca método
  void changeMethod(index,oldIndex) {

    setState(() {
      //escrever valores no mapa do exercicio
      widget.newtrain[oldIndex]['method']=methodList[index];
      Navigator.pop(context);
      saveTrainsList();
    });
  }






}

