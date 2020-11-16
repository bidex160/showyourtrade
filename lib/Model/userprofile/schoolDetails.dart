

class Education {
  String id;
  String schoolNam;
  String location;
  String startdate;
  String endDate;
  String department;
  String award;
  String degree;
  String result;

  Education ({this.id,this.schoolNam, this.location, this.startdate, this.endDate, this.department, this.award, this.degree, this.result});

  factory  Education.fromJson(Map<String, dynamic> json){
    var education = Education(
      id: json['0'] as String,
      schoolNam: json['1'] as String,
      location: json['2'] as String,
      startdate: json['3'] as String,
      endDate: json['4'] as String,
      department: json['5'] as String,
      award: json['6'] as String,
      degree: json['7'] as String,
      result: json['8'] as String,
    );
    return education;
  }
}