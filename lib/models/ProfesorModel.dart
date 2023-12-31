class ProfesorModel {
  int? IdProfesor;
  String? NameProfesor;
  String? NameSubject;
  int? IdCareer;
  String? User;
  String? Contra;

  ProfesorModel({
    this.IdProfesor,
    this.NameProfesor,
    this.NameSubject,
    this.IdCareer,
  });
  factory ProfesorModel.fromMap(Map<String, dynamic> map) {
    return ProfesorModel(
      IdProfesor: map['IdProfesor'],
      NameSubject: map['NameSubject'],
      NameProfesor: map['NameProfesor'],
      IdCareer: map['IdCareer'],
    );
  }
}
