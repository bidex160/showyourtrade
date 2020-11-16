import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:showyourtrade/Model/products_model.dart';
import 'package:showyourtrade/Model/sector_industry.dart';
import 'package:showyourtrade/Model/sub_category.dart';
import 'package:showyourtrade/Model/userprofile/UserProfileModel.dart';
import 'package:showyourtrade/Model/userprofile/awardModel.dart';
import 'package:showyourtrade/Model/userprofile/membershipModel.dart';
import 'package:showyourtrade/Model/userprofile/schoolDetails.dart';
import 'package:showyourtrade/Model/userprofile/userIndividialModel.dart';
import 'package:showyourtrade/Model/userprofile/userposts.dart';
import 'package:showyourtrade/Model/userprofile/userprofile.dart';
import 'package:showyourtrade/Model/userprofile/usersServiceModel.dart';
import 'package:showyourtrade/Model/userprofile/userskilss.dart';
import 'package:showyourtrade/Model/userprofile/workexperience.dart';

class UserProfileProvider with ChangeNotifier {
 static Future<UserProfileModel> fetchUserprofile(String name) async {
    List<UserProfileModel> userProfileModel=[];
    List<ProductsModel> productsModel =[];
    List<IndividualModel> individual =[];
    List<ServiceModel> serviceModel = [];
   UserProfile userProfile;

    var par = {'u':'$name'};
    print(name);
    var uri = Uri.https('www.showyourtrade.com', '/user_app',par);
    var res =
    await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (res.statusCode == 200) {
     String stringre = res.body.toString();
    var parsedJson = jsonDecode(stringre) as Map<String, dynamic>;
   // final parsed = jsonDecode(stringre).cast<Map<String, dynamic>>();
      parsedJson.forEach((key, value) {

        if(value['0']['0']['4']  == 'b'){
          print('yess products');
        var products = value['1'] as Map<String, dynamic>;
        products.forEach((key, value) {
          List<String> _subheadname = [];
          List<List<String>> all = [];

          List<SubCategory> _subhead = [];



          var subCatgory = value['1'] as Map<String, dynamic>;

          subCatgory.forEach((key, subcat) {

            _subheadname.add(subcat['0']);

            var p3 = subcat['1'] as Map<String, dynamic>;

            List<String> _items = [];
            p3.forEach((key, value) {
              //  print('items  ${value['0']}');
              _items.add(value['0']);
            });
            all.add(_items);
            //   print(_items.length);

          });




          _subhead.add(SubCategory(_subheadname, all));
          productsModel.add(ProductsModel(
              value['0'], _subheadname.length, _subhead, _subheadname, all));
        });
      }
        else if(value['0']['0']['4']  == 'i'){






         AwardModel awardModel;
          Skills skillModel;
          Skills languageNodel;
          Skills interestModel;
          WorkExperience workExperience;
          Education education;
          Membership membership;

          print('indiviual');







          var resume = value['3'] as Map<String, dynamic>;

          resume.forEach((key, value) {


            var skillM = value['1'] as Map<String, dynamic>;
            List<Skills> skillL = [];
            skillM.forEach((key, value) {
              skillModel =  Skills.fromJson(value);
              skillL.add(skillModel);

            });
            var language = value['2'] as Map<String, dynamic>;
            List<Skills> languageL =[];
            language.forEach((key, value) {
              languageNodel =  Skills.fromJson(value);
              languageL.add(languageNodel);


            });


            var interest = value['3'] as Map<String, dynamic>;
            List<Skills> interestL= [];
            interest.forEach((key, value) {
              interestModel =  Skills.fromJson(value);
              interestL.add(interestModel);

            });
           //
            var workx = value['4'] as Map<String, dynamic>;
            List<WorkExperience> workexperienceL = [];
            workx.forEach((key, value) {
             workExperience =  WorkExperience.fromJson(value);
              workexperienceL.add(workExperience);

            });
           //
            var edu = value['5'] as Map<String, dynamic>;
            List<Education> educationL = [];
           edu.forEach((key, value) {
              education =  Education.fromJson(value);
              educationL.add(education);
              print(value);

            });
           //
            List<Membership> membershipL =[];
          if(value['6'] != null){
            var mem = value['6'] as Map<String, dynamic>;

            mem.forEach((key, value) {
              membership =  Membership.fromJson(value);
              membershipL.add(membership);

            });
          }
            List<AwardModel>  awardL=[];
          if(value['7'] != null){
            var award = value['7'] as Map<String, dynamic>;

            award.forEach((key, value) {
              awardModel =  AwardModel.fromJson(value);
              awardL.add(awardModel);

            });
          }

        individual.add(IndividualModel(value['0']['0']['0'], value['0']['0']['1'], value['0']['0']['2'], skillL, languageL, interestL, workexperienceL, educationL, membershipL, awardL));
          });
        }

        userProfile =  UserProfile.fromJson(value['0']['0']);


    userProfileModel.add(UserProfileModel(userProfile,productsModel ,individual, serviceModel));



      });



      return userProfileModel[0];
    } else {
      return userProfileModel[0];
    }
  }

 Future<List<UserPosts>> fetchPosts(String name) async {
     List<UserPosts> userPostsList= [];
    UserPosts userPosts;
    var par = {'u':'Meks'};
    print(name);
    var uri = Uri.https('www.showyourtrade.com', '/user_posts.php',par);
    var res =
    await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (res.statusCode == 200) {
      var parsedJson = jsonDecode(res.body) as Map<String, dynamic>;

      parsedJson.forEach((key, value) {

        userPosts  = UserPosts.fromJson(value);
        userPostsList.add(userPosts);
        // var p2 = value['1'] as Map<String, dynamic>;
        // p2.forEach((key, value) {
        //   print(value);
        // });
      });
      return userPostsList;

    } else {
      return userPostsList;
    }
  }

}