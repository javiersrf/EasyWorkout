import 'package:easy_train/main_functions/read_csv.dart';
import 'package:easy_train/main_functions/training_types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'train_page.dart';



class TrainDivisionPage extends StatefulWidget {
  final List trainDivision;
  TrainDivisionPage(this.trainDivision );


  @override
  _TrainDivisionPageState createState() => _TrainDivisionPageState();
}

class _TrainDivisionPageState extends State<TrainDivisionPage> {


  @override
  void initState() {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subdivisão Treino'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addNewSub();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: widget.trainDivision.length,
          itemBuilder: (context,index){
            return trainCard(context, index);
          }),
    );
  }









  Widget trainCard(BuildContext context,int index){
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
                        Text(widget.trainDivision[index]['name'],
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),


                      ],
                    )
                ),
              ],
            ),
          )
      ),
      onTap:() async{
        showTrainPage(widget.trainDivision[index]['exercises']);
      },
      onLongPress: ()async{
        showSubDivOptions(context,index);
      },
    );
  }

  void showTrainPage(List selectedTrain) async{

    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TrainPage(selectedTrain)));
  }


  void showSubDivOptions(BuildContext context,int index){
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
                        SubDivOptionsContainer(index,'Excluir',deleteSelectedSubDiv),
                        SubDivOptionsContainer(index,'Renomear',showRenameSelectedSub),
                        SubDivOptionsContainer(index,'Modificar todos os métodos',showChangeMethod),
                      ],
                    )
                );
              }
          );
        });
  }





  //cada opção, com o texto e a função associada
  Widget SubDivOptionsContainer(index,String text,Function func){
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

  void deleteSelectedSubDiv(index) {
    setState(() {
      widget.trainDivision.removeAt(index);
      Navigator.pop(context);
      saveTrainsList();
    });
  }

  String subrename="";
  TextEditingController subrenameText = TextEditingController();

  void showRenameSelectedSub (index) {
    renameSubField(context,index);

  }

  void renameSubField(BuildContext context,int index){
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
                                  controller: subrenameText,
                                  decoration: InputDecoration(
                                    labelText: "Novo Nome",
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              RaisedButton(
                                color: Colors.red,
                                child: Text("Renomear"),
                                textColor: Colors.white,
                                onPressed: (){renameSelectedSub(index);},

                              ),
                            ]
                        )
                    )
                );
              }
          );

        });
  }




  void renameSelectedSub(index) {

    setState(() {
      subrename=subrenameText.text;
      Navigator.pop(context);
      if(subrename!=""){
        widget.trainDivision[index]['name']=subrename;};
      subrenameText.text="";
      Navigator.pop(context);
      saveTrainsList();
    });
  }


  void addNewSub(){
    setState(() {
      Map newSubdivision=Map();
      newSubdivision['name']='Nova Subdivisão';
      newSubdivision['exercises']=[];
      widget.trainDivision.add(newSubdivision);
      saveTrainsList();
      Navigator.pop(context);
      _showTrainDivisionPage(widget.trainDivision);

    });


  }


  void _showTrainDivisionPage(List selectedTrain) async{

    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TrainDivisionPage(selectedTrain)));
  }

  int oldExerciseIndex;
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
  void changeMethod(index,oldExerciseIndex) {
  int exerciseIndex=0;
    setState(() {
      //escrever valores no mapa do exercicio

      do{widget.trainDivision[oldExerciseIndex]['exercises'][exerciseIndex]['method']=methodList[index];
        exerciseIndex=exerciseIndex+1;
      }
      while(exerciseIndex<widget.trainDivision[oldExerciseIndex]['exercises'].length);
      Navigator.pop(context) ;
      saveTrainsList();
    });
  }



}
