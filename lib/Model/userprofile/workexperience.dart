

class WorkExperience {
  String id;
  String jobRole;
  String office;
  String address;
  String startdate;
  String endDate;
  String jobFunction;
  String achievement;

  WorkExperience({this.id,this.jobRole, this.office, this.address, this.startdate, this.endDate, this.jobFunction, this.achievement});

  factory  WorkExperience.fromJson(Map<String, dynamic> json){
    var work = WorkExperience(
      id: json['0'] as String,
       jobRole: json['1'] as String,
        address: json['2'] as String,
      startdate: json['3'] as String,
      endDate: json['4'] as String,
      jobFunction: json['5'] as String,
      achievement: json['6'] as String,
    );
    return work;
  }
}