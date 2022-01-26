import 'read_csv.dart';
List methodList = ['3x12 reps','20s isometria + 3x8 reps','3x8 reps','3x5 reps','drop-set +3x8 reps','rest-pause + 3x8 reps','3x15 reps'];
List newTrainList = [createTrainEmpity(),createTrainAB(),createTrainABCsuperior(),createTrainABCDsuperior(),createTrainABCDEsuperior()];

List trainEmpity(){
  //criar os mapas
  Map trainAMap=Map();
  // criar as listas de exercicios
  List trainA =  [];
  //adicionar exercicios

  //associar valores aos mapas
  trainAMap['name']='SubDivisão 1';
  trainAMap['exercises']=trainA;
  // retorna lista de mapas
  return [trainAMap,];

}

List createTrainEmpity() {
  Map mytrainMap = Map();
  mytrainMap['name'] = 'Treino Vazio';
  mytrainMap['train_division'] = trainEmpity();
  return [mytrainMap];
}




List trainAB(){
  //criar os mapas
  Map trainAMap=Map();
  Map trainBMap=Map();
  // criar as listas de exercicios
  List trainA =  [];
  List trainB =  [];
  //adicionar exercicios
  trainA.add(createExerciseFrom('Peitoral Medio'));
  trainA.add(createExerciseFrom('Peitoral Superior'));
  trainA.add(createExerciseFrom('Grande Dorsal 1'));
  trainA.add(createExerciseFrom('Grande Dorsal 2'));
  trainA.add(createExerciseFrom('Deltoide'));
  trainA.add(createExerciseFrom('Triceps'));
  trainA.add(createExerciseFrom('Biceps'));
  
  trainB.add(createExerciseFrom('Coxas'));
  trainB.add(createExerciseFrom('Coxas'));
  trainB.add(createExerciseFrom('Quadriceps'));
  trainB.add(createExerciseFrom('Posterior coxa'));
  trainB.add(createExerciseFrom('Adutores'));
  trainB.add(createExerciseFrom('Panturrilha'));
  //associar valores aos mapas
  trainAMap['name']='A: Membros Superiores';
  trainAMap['exercises']=trainA;
  trainBMap['name']='B: Membros Inferiores';
  trainBMap['exercises']=trainB;
  // retorna lista de mapas
  return [trainAMap,trainBMap];

}

List createTrainAB() {
  Map mytrainMap = Map();
  mytrainMap['name'] = 'Treino AB';
  mytrainMap['train_division'] = trainAB();
  return [mytrainMap];
}


List trainABCsuperior(){
  //criar os mapas
  Map trainAMap=Map();
  Map trainBMap=Map();
  Map trainCMap=Map();
  // criar as listas de exercicios
  List trainA =  [];
  List trainB =  [];
  List trainC =  [];
  //adicionar exercicios
  trainA.add(createExerciseFrom('Peitoral Medio'));
  trainA.add(createExerciseFrom('Peitoral Superior'));
  trainA.add(createExerciseFrom('Peitoral Medio'));
  trainA.add(createExerciseFrom('Deltoide Multiarticular'));
  trainA.add(createExerciseFrom('Deltoide'));
  trainA.add(createExerciseFrom('Triceps'));
  trainA.add(createExerciseFrom('Triceps'));
  
  trainB.add(createExerciseFrom('Grande Dorsal 1'));
  trainB.add(createExerciseFrom('Grande Dorsal 1'));
  trainB.add(createExerciseFrom('Grande Dorsal 2'));
  trainB.add(createExerciseFrom('Trapezio'));
  trainB.add(createExerciseFrom('Biceps'));
  trainB.add(createExerciseFrom('Biceps'));

  trainC.add(createExerciseFrom('Coxas'));
  trainC.add(createExerciseFrom('Coxas'));
  trainC.add(createExerciseFrom('Quadriceps'));
  trainC.add(createExerciseFrom('Posterior coxa'));
  trainC.add(createExerciseFrom('Adutores'));
  trainC.add(createExerciseFrom('Panturrilha'));
  //associar valores aos mapas
  trainAMap['name']='A: Peitoral, Deltóide e Triceps';
  trainAMap['exercises']=trainA;
  trainBMap['name']='B: Dorsal, Trapézio e Biceps';
  trainBMap['exercises']=trainB;
  trainCMap['name']='C: Membros Inferiores';
  trainCMap['exercises']=trainC;
  return [trainAMap,trainBMap,trainCMap];

}

List createTrainABCsuperior() {
  Map mytrainMap = Map();
  mytrainMap['name'] = 'Treino ABC Foco Superior';
  mytrainMap['train_division'] = trainABCsuperior();
  return [mytrainMap];
}


List trainABCDsuperior(){
  //criar os mapas
  Map trainAMap=Map();
  Map trainBMap=Map();
  Map trainCMap=Map();
  Map trainDMap=Map();
  // criar as listas de exercicios
  List trainA =  [];
  List trainB =  [];
  List trainC =  [];
  List trainD =  [];
  //adicionar exercicios
  trainA.add(createExerciseFrom('Peitoral Medio'));
  trainA.add(createExerciseFrom('Peitoral Superior'));
  trainA.add(createExerciseFrom('Peitoral Medio'));
  trainA.add(createExerciseFrom('Triceps'));
  trainA.add(createExerciseFrom('Triceps'));

  trainB.add(createExerciseFrom('Grande Dorsal 1'));
  trainB.add(createExerciseFrom('Grande Dorsal 1'));
  trainB.add(createExerciseFrom('Grande Dorsal 2'));
  trainB.add(createExerciseFrom('Biceps'));
  trainB.add(createExerciseFrom('Biceps'));
  trainB.add(createExerciseFrom('Antebracos'));

  trainC.add(createExerciseFrom('Coxas'));
  trainC.add(createExerciseFrom('Coxas'));
  trainC.add(createExerciseFrom('Quadriceps'));
  trainC.add(createExerciseFrom('Posterior coxa'));
  trainC.add(createExerciseFrom('Adutores'));
  trainC.add(createExerciseFrom('Panturrilha'));

  trainD.add(createExerciseFrom('Deltoide Multiarticular'));
  trainD.add(createExerciseFrom('Deltoide Multiarticular'));
  trainD.add(createExerciseFrom('Deltoide'));
  trainD.add(createExerciseFrom('Trapezio'));
  trainD.add(createExerciseFrom('Trapezio'));

  //associar valores aos mapas
  trainAMap['name']='A: Peitoral e Triceps';
  trainAMap['exercises']=trainA;
  trainBMap['name']='B: Dorsal e Biceps';
  trainBMap['exercises']=trainB;
  trainCMap['name']='C: Pernas';
  trainCMap['exercises']=trainC;
  trainDMap['name']='D: Deltóide e Trapézio';
  trainDMap['exercises']=trainD;
  return [trainAMap,trainBMap,trainCMap,trainDMap];

}

List createTrainABCDsuperior() {
  Map mytrainMap = Map();
  mytrainMap['name'] = 'Treino ABCD Foco Superior';
  mytrainMap['train_division'] = trainABCDsuperior();
  return [mytrainMap];
}



List trainABCDEsuperior(){
  //criar os mapas
  Map trainAMap=Map();
  Map trainBMap=Map();
  Map trainCMap=Map();
  Map trainDMap=Map();
  Map trainEMap=Map();
  // criar as listas de exercicios
  List trainA =  [];
  List trainB =  [];
  List trainC =  [];
  List trainD =  [];
  List trainE =  [];
  //adicionar exercicios
  trainA.add(createExerciseFrom('Peitoral Medio'));
  trainA.add(createExerciseFrom('Peitoral Superior'));
  trainA.add(createExerciseFrom('Peitoral Medio'));
  trainA.add(createExerciseFrom('Peitoral Inferior'));

  trainB.add(createExerciseFrom('Grande Dorsal 1'));
  trainB.add(createExerciseFrom('Grande Dorsal 1'));
  trainB.add(createExerciseFrom('Grande Dorsal 2'));
  trainB.add(createExerciseFrom('Grande Dorsal 2'));
  trainB.add(createExerciseFrom('Antebracos'));

  trainC.add(createExerciseFrom('Coxas'));
  trainC.add(createExerciseFrom('Coxas'));
  trainC.add(createExerciseFrom('Quadriceps'));
  trainC.add(createExerciseFrom('Posterior coxa'));
  trainC.add(createExerciseFrom('Adutores'));
  trainC.add(createExerciseFrom('Panturrilha'));

  trainD.add(createExerciseFrom('Deltoide Multiarticular'));
  trainD.add(createExerciseFrom('Deltoide Multiarticular'));
  trainD.add(createExerciseFrom('Deltoide'));
  trainD.add(createExerciseFrom('Trapezio'));
  trainD.add(createExerciseFrom('Trapezio'));

  trainE.add(createExerciseFrom('Triceps'));
  trainE.add(createExerciseFrom('Triceps'));
  trainE.add(createExerciseFrom('Triceps'));
  trainE.add(createExerciseFrom('Biceps'));
  trainE.add(createExerciseFrom('Biceps'));
  trainE.add(createExerciseFrom('Biceps'));

  //associar valores aos mapas
  trainAMap['name']='A: Peitoral';
  trainAMap['exercises']=trainA;
  trainBMap['name']='B: Dorsal e Antebraços';
  trainBMap['exercises']=trainB;
  trainCMap['name']='C: Pernas';
  trainCMap['exercises']=trainC;
  trainDMap['name']='D: Deltóide e Trapézio';
  trainDMap['exercises']=trainD;
  trainEMap['name']='E: Biceps e Triceps';
  trainEMap['exercises']=trainE;
  return [trainAMap,trainBMap,trainCMap,trainDMap,trainEMap];

}

List createTrainABCDEsuperior() {
  Map mytrainMap = Map();
  mytrainMap['name'] = 'Treino ABCDE Foco Superior';
  mytrainMap['train_division'] = trainABCDEsuperior();
  return [mytrainMap];
}
