class CareerModel {
  int? IdCareer;
  String? NameCareer;

  CareerModel({this.IdCareer, this.NameCareer});
  factory CareerModel.fromMap(Map<String, dynamic> map) {
    return CareerModel(
      IdCareer: map['IdCareer'],
      NameCareer: map['NameCareer'],
    );
  }
}
