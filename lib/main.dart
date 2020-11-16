import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:showyourtrade/PeopleCategoryWidget/peopleList.dart';
import 'package:showyourtrade/Provider/PeopleSubCategoryListProvider.dart';
import 'package:showyourtrade/Provider/peopleprovider.dart';
import 'package:showyourtrade/Provider/userprofile.dart';
import 'package:showyourtrade/screen/Product_Descrption.dart';
import 'package:showyourtrade/screen/usersposts.dart';
import 'package:showyourtrade/showprofile/profilescreen.dart';
import 'package:showyourtrade/stackscreen/show_people_category.dart';
import 'package:showyourtrade/stackscreen/show_productRad.dart';
import 'package:showyourtrade/stackscreen/show_product_category.dart';
import 'package:showyourtrade/stackscreen/showpeoplerand.dart';
import './Model/Upload_Post.dart';
import 'stackscreen/PostScreen.dart';
import './apptheme/app_theme.dart';
import 'tabs/People_Screen.dart';
import 'stackscreen/upload.dart';
import 'stackscreen/stories_Screen.dart';
import 'tabs/Products_Screen.dart';
import './Provider/PostProvider.dart';
import './Search.dart';
import 'tabs/Tab_bar_screen.dart';
import './account/login.dart';
import 'Provider/products.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create :(ctx) =>  PostProvider()
    ),
        ChangeNotifierProvider(
            create :(ctx) =>  ProductProvider()
        ),
        ChangeNotifierProvider(
            create :(ctx) =>  PeopleProvider()
        ),
        ChangeNotifierProvider(
            create :(ctx) => PeopleSubCategoryListProvider()
        ),
        ChangeNotifierProvider(
            create :(ctx) => UserProfileProvider()
        )


      ],
      child: MaterialApp(
        title: 'Show Your Trade',
        theme: appThemeDark,
      initialRoute: '/',
        routes: {
          '/':(ctx) => TabScreen(),
          StoriesScreen.routeName:(ctx)=> StoriesScreen(),
          PostScreen.routeName:(ctx)=>PostScreen(),
          PeopleScreen.routeName : (ctx) => PeopleScreen(),
          ProductsScreen.routeName :(ctx) => ProductsScreen(),
          UploadScreen.routeName:(ctx)=> UploadScreen(),
          SearchScreen.routeName:(ctx) => SearchScreen(),
          LoginScreen.routeName:(ctx) => LoginScreen(),
          TabScreen.routeName:(ctx) => TabScreen(),
          ShowProductCatogory.routeName:(ctx)=>ShowProductCatogory(),
          ShowPeopleCategory.routeName:(ctx)=>ShowPeopleCategory(),
          ShowProductRand.routeName:(ctx)=>ShowProductRand(),
          ShowPeopleRad.routeName:(ctx)=>ShowProductRand(),
          PeopleSubCatList.routeName:(ctx)=>PeopleSubCatList(),
          ProductDetails.routeName:(ctx)=>ProductDetails(),
          ShowProfileScreen.routeName:(ctx)=>ShowProfileScreen(),
          UsersPostScreen.routeName:(ctx)=>UsersPostScreen()


        },


      ),
    );
  }
}


