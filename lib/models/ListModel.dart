class ListModel {
  int? value;
  String? text;

  ListModel({this.value, this.text});
  factory ListModel.fromMap(Map<String, dynamic> map) {
    return ListModel(
      value: map['IdCareer'],
      text: map['NameCareer'],
    );
  }
}
