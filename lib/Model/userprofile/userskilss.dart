

class Skills {

  String id;
  String name;
  int percentage;

  Skills ({this.id,this.name,this.percentage});

  factory  Skills.fromJson(Map<String, dynamic> json){
    var skill = Skills(
      id: json['0'] as String,
      name: json['1'] as String,
      percentage:  int.parse(json['2'])
    );
    return skill;
  }
}