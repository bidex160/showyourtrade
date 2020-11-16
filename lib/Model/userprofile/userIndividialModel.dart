

import 'package:flutter/cupertino.dart';
import 'package:showyourtrade/Model/userprofile/awardModel.dart';
import 'package:showyourtrade/Model/userprofile/membershipModel.dart';
import 'package:showyourtrade/Model/userprofile/schoolDetails.dart';
import 'package:showyourtrade/Model/userprofile/userskilss.dart';
import 'package:showyourtrade/Model/userprofile/workexperience.dart';

class  IndividualModel with ChangeNotifier{
  String id;
  String about;
  String qoute;
  List<Skills> skills;
  List<Skills> language;
  List<Skills> interest;
  List<WorkExperience> workexperience;
  List<Education> education;
  List<Membership> membership;
  List<AwardModel>  award;

  IndividualModel(this.id, this.about, this.qoute,this.skills,this.language, this.interest,this.workexperience, this.education, this.membership, this.award);


}