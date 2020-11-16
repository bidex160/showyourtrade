
class Membership {

  String id;
  String member;
  String organization;
  String acronyms;
  String memDate;

  Membership({this.id, this.member, this.organization, this.acronyms, this.memDate});

  factory   Membership.fromJson(Map<String, dynamic> json){
    var member =  Membership(
      id: json['0'] as String,
      member: json['1'] as String,
      organization: json['2'] as String,
      acronyms: json['3'] as String,
     memDate: json['4'] as String,

    );
    return member;
  }

}