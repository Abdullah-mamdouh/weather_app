
class ConditionModel {
  String? text;
  String? icon;
  int? code;

  ConditionModel({this.text, this.icon, this.code});

  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return ConditionModel(
        text: json['text'], icon: json['icon'], code: json['code']);
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'icon': icon,
      'code': code,
    };
  }
}
