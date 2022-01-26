import 'package:easy_train/main_functions/read_csv.dart';
import 'package:easy_train/main_functions/training_types.dart';
import 'package:easy_train/ui/new_train_page.dart';
import 'package:easy_train/ui/train_division_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'train_page.dart';
import "package:path_provider/path_provider.dart";
import 'dart:convert';





class MyTrainsPage extends StatefulWidget {

  @override
  _MyTrainsPageState createState() => _MyTrainsPageState();
}

class _MyTrainsPageState extends State<MyTrainsPage> {







  @override
  void initState() {
    super.initState();
    readTrainsList().then((data) {
      setState(() {
        myTrainsList = json.decode(data);
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Meus Treinos Salvos'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          showNewTrainPage();},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: myTrainsList.length,
          itemBuilder: (context,index){
            return mytrainsCard(context, index);
          }),
    );
  }

  Widget mytrainsCard(BuildContext context,int index){
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
                          Text(myTrainsList[index]['name'],
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),


                        ],
                      )
                  ),
                ],
              ),
            )
        ),
        onTap:() async{
          showTrainDivisionPage(myTrainsList[index]['train_division']);
        },
      onLongPress: (){showTrainOptions(context,index);},
    );
  }








  void showTrainDivisionPage(List selectedTrain) async{

    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TrainDivisionPage(selectedTrain)));
  }

  void showNewTrainPage() async{

    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NewTrainPage()));
  }

  void showTrainOptions(BuildContext context,int index){
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
                        OptionsContainer(index,'Excluir',deleteSelectedTrain),
                        OptionsContainer(index,'Renomear',showRenameSelectedTrain),

                      ],
                    )
                );
              }
          );
        });
  }

  Widget OptionsContainer(index,String text,Function func){
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




  void deleteSelectedTrain(index) {
    setState(() {
      myTrainsList.removeAt(index);
      Navigator.pop(context);
      saveTrainsList();
    });
  }

  String rename="";
  TextEditingController renameText = TextEditingController();



  void showRenameSelectedTrain (index) {
    renameTrainField(context,index);

  }

  void renameTrainField(BuildContext context,int index){
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
                      controller: renameText,
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
                          onPressed: (){renameSelectedTrain(index);},

                      ),
                      ]
              )
            )
          );
       }
     );

  });
  }




  void renameSelectedTrain(index) {

    setState(() {
      rename=renameText.text;
      Navigator.pop(context);
      if(rename!=""){
      myTrainsList[index]['name']=rename;};
      renameText.text="";
      Navigator.pop(context);
      saveTrainsList();
    });
  }







}




