
import 'package:flutter/foundation.dart';
import 'package:showyourtrade/Model/products_model.dart';
import 'package:showyourtrade/Model/userprofile/userIndividialModel.dart';
import 'package:showyourtrade/Model/userprofile/userposts.dart';
import 'package:showyourtrade/Model/userprofile/userprofile.dart';
import 'package:showyourtrade/Model/userprofile/usersServiceModel.dart';

class UserProfileModel{
 UserProfile userProfile;
 List<ProductsModel> productsModel;
 List<IndividualModel> individual;
 List<ServiceModel> serviceModel;

 UserProfileModel(this.userProfile,this.productsModel,this.individual, this.serviceModel);


}