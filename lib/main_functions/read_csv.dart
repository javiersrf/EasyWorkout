import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:easy_train/main_functions/training_types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:path_provider/path_provider.dart";
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

List train=[];
List trainDivision=[];
List exerciseList=[];
List myTrainsList=[];


//ler e salvar arquivo dos treinos
Future<File> saveTrainsList() async {
  String data = json.encode(myTrainsList);
  final file = await getTrainsList();
  return file.writeAsString(data);
}




Future<File> getTrainsList() async {
  final directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/mytrainslist.json");
}



Future<String> readTrainsList() async {
  try {
    final file = await getTrainsList();
    return file.readAsString();
  } catch (e) {
    return null;
  }
}







//cria lista filtrada por PrimaryMuscle
List<dynamic> primaryFilterList(filter){
  List filteredList=[];
  for (int i = 1; i < exerciseList.length-1; i++) {
    if(exerciseList[i][2]==filter && exerciseList[i][5]=='1') {
      filteredList.add(exerciseList[i]);
    }

  }
  return filteredList;
}

//cria lista filtrada por Secondary
List<dynamic> secondaryFilterList(pfilter,sfilter){
  List filteredList=[];
  for (int i = 1; i < exerciseList.length-1; i++) {
    if(exerciseList[i][2]==pfilter && exerciseList[i][3]==sfilter) {
      filteredList.add(exerciseList[i]);
    }

  }
  return filteredList;
}


//criar um exercicio a partir de um item aleatorio da lista de exercicios selecionada
Map<String, dynamic>createExerciseFrom(filter){
  List list = primaryFilterList(filter);
  Random random = new Random();
  //sorteia um numero
  int i = random.nextInt(list.length);
  Map<String, dynamic> newExercise = Map();
  //verificar a prioridade do exercicio

    newExercise['id']=list[i][0];
    newExercise['name']=list[i][1];
    newExercise['pMuscle']=list[i][2];
    newExercise['sMuscle']=list[i][3];
    newExercise['URL']=list[i][4];
    newExercise['priority']=list[i][5];
    newExercise['method']='3x12 reps';
    newExercise['weight']='0 kg';
    return newExercise;

   //caso a prioridade seja 1, retorna o exercicio

}

