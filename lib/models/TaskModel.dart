class TaskModel {
  int? IdTask;
  String? NameTask;
  String? DscTask;
  String? SttTask;
  String? FECRECORDATORIO;
  int? IdProfesor;

  TaskModel({
    this.IdTask,
    this.NameTask,
    this.DscTask,
    this.SttTask,
    this.FECRECORDATORIO,
    this.IdProfesor,
  });
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      IdTask: map['IdTask'],
      DscTask: map['DscTask'],
      NameTask: map['NameTask'],
      SttTask: map['SttTask'],
      FECRECORDATORIO: map['FECRECORDATORIO'],
      IdProfesor: map['IdProfesor'],
    );
  }
}
