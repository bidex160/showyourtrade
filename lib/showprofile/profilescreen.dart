import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:showyourtrade/Drawer.dart';
import 'package:showyourtrade/Model/index_post.dart';
import 'package:showyourtrade/Model/post_model.dart';
import 'package:showyourtrade/Model/products_model.dart';
import 'package:showyourtrade/Model/userprofile/UserProfileModel.dart';
import 'package:showyourtrade/Model/userprofile/userposts.dart';
import 'package:showyourtrade/Model/userprofile/userprofile.dart';
import 'package:showyourtrade/Provider/PeopleSubCategoryListProvider.dart';
import 'package:showyourtrade/Provider/userprofile.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';
import 'package:showyourtrade/screen/usersposts.dart';
import 'package:showyourtrade/showprofile/showuserproducts.dart';
import 'package:showyourtrade/stackscreen/PostScreen.dart';
import 'package:showyourtrade/stackscreen/upload.dart';
import 'package:showyourtrade/tabs/Products_Screen.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../tabs/People_Screen.dart';
import '../stackscreen/stories_Screen.dart';


class ShowProfileScreen extends StatefulWidget {
  static const routeName = '/ShowProfileScreen';

  // IndexPostModel currentPost;
  // ShowProfileScreen(this.currentPost);
  @override
  _ShowProfileScreenState createState() => _ShowProfileScreenState();
}

class _ShowProfileScreenState extends State<ShowProfileScreen> {
  File pickedImage;
  int _selectnumber =0;

  final List<dynamic> _pages = [

    StoriesScreen(),
    PostScreen(),
    UploadScreen(),
    ProductsScreen(),
    PeopleScreen()
    //  PhotosScreen(),


  ];

  void _selectedPage(int index){
    print(index);
    setState(() {
      _selectnumber = index;

    });

  }
  Future<String> stream;

  void _showbottom(BuildContext context,ProductsModel productsModel,int index){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: ShowUserProducts(productsModel,_userProfile.userProfile.username,index)
      ),
    );

  }




  UserProfileModel _userProfile;
  List<UserPosts> userposts = [];
   String name = '';
  IndexPostModel  currentPost ;
 //  Future<String > fetchProducts() async {
 //    final response = await http.get('https://showyourtrade.com/onChangeProduct_user.php?u=Baby%20Sleeping%20Bags&p=Obiempire');
 // //   final jsonResponse = jsonDecode(response.body);
 //
 //    // List<User> users = [];
 //    print(response.body);
 //    return 'users';
 //  }

  @override
  void didChangeDependencies() {
    final routeArg = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    setState(() {
      currentPost = routeArg['currentPost'];
    });
 //  stream =  fetchProducts();
  print(currentPost.account_type);

    UserProfileProvider.fetchUserprofile('${currentPost.account_name}').then((value) {
      setState(() {
        print(value);
        _userProfile = value;
        print(value);
      });

    });
    Provider.of<UserProfileProvider>(context).fetchPosts('${currentPost.account_name}').then((value) {
      setState(() {
        userposts = value;
        print(userposts.length);
      });
    });




    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appThemeDark.backgroundColor,
      appBar: AppBar(
        title: Text('${currentPost.account_name}'),
      ),
      body: DefaultTabController(

        length: 3,

        child: SingleChildScrollView(

          child:  Column(


            children: [
              Container(
               margin: const EdgeInsets.all(8.0),
                height: Config.yMargin(context,20),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage('https://showyourtrade.com/user/${currentPost.account_name}/${currentPost.avatar}'),

                    ),
                    Expanded(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                               children: [

                                 Text(userposts.length>0 ? '${userposts.length}':'0',style: appThemeDark.textTheme.display1,),
                                 Text('Post',style: appThemeDark.textTheme.display1,),
                               ],
                              ),
                              Column(
                                children: [

                                  Text(_userProfile != null?'${_userProfile.userProfile.followers}':'0',style: appThemeDark.textTheme.display1,),
                                  Text('Followers',style: appThemeDark.textTheme.display1,),
                                ],
                              ),
                              Column(
                                children: [

                                  Text(_userProfile != null?'${_userProfile.userProfile.following}':'0',style: appThemeDark.textTheme.display1,),
                                  Text('Following',style: appThemeDark.textTheme.display1,),
                                ],
                              )

                            ],
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RaisedButton(onPressed: null,
                              child: Text('Follow',style: appThemeDark.textTheme.display1,),),
                              RaisedButton(onPressed: null,
                                child: Text('Message',style: appThemeDark.textTheme.display1,),)
                            ],
                          )

                        ],
                      ),
                    )
                  ],
                ),
              ),


              Container(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 Container(
                   width: Config.xMargin(context, 50),
                   margin: const EdgeInsets.all(5.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Icon(Icons.category,
                         size: 16,
                         color: Colors.white,),
                       SizedBox(width: 2,),
                       Expanded(child: Text(_userProfile != null?'${_userProfile.userProfile.category}':'Category',style: appThemeDark.textTheme.display1)),

//user_posts.php  u/
                     ],
                   ),
                 ),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      width: Config.xMargin(context, 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.phone,
                            color: Colors.white,
                            size: 16,),
                          SizedBox(width: 2,),
                          FittedBox(child: Text(_userProfile != null?'${_userProfile.userProfile.num}':'Phone',style: appThemeDark.textTheme.display1))

                        ],
                      ),
                    )


                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                 margin: const EdgeInsets.all(5.0),
                  width: Config.xMargin(context, 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.mail,
                        size: 16,
                        color: Colors.white,),
                      SizedBox(width: 2,),
                      Expanded(child: Text(_userProfile != null?'${_userProfile.userProfile.email}':'Mail',style: appThemeDark.textTheme.display1)),
                    ],
                  ),
                ),

                    Container(
                      width: Config.xMargin(context, 44),
                        margin: const EdgeInsets.all(5.0),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Icon(Icons.my_location,
                           color: Colors.white,
                           size: 16,),
                         SizedBox(width: 2,),
                   //     Container(child: Text(_userProfile != null?'${_userProfile.City} ${_userProfile.State}, ${_userProfile.Country}':'Location',overflow:TextOverflow.ellipsis,style: appThemeDark.textTheme.display1)),

                       ],
                      )
                    )


                  ],
                ),
              ),
              new StickyHeader(


                  header: Container(

                    child: TabBar(
                      indicatorColor: Colors.transparent,

                      isScrollable: false,
                      tabs: <Widget>[
                    if( currentPost.account_type== 'b' )  Tab(
                      icon: Icon(
                          Icons.store,
                          color: Colors.white,
                        ),
                    text: 'Products',),
                        if( currentPost.account_type== 'a' )  Tab(icon: Icon(
                          Icons.house,
                          color: Colors.white,
                        ),
                          text: 'Projects',
                        ),
                        if( currentPost.account_type== 'i' )  Tab(icon: Icon(
                          Icons.file_present,
                          color: Colors.white,
                        ),
                          text: 'Resume',),
                        Tab(icon: Icon(
                          Icons.store,
                          color: Colors.white,
                        ),
                          text: 'Shows',),

                        Tab(icon: Icon(
                          Icons.people,
                          color: Colors.white,
                        ),
                          text: 'Posts',),

                      ],
                    ),
                  ), content: SizedBox(
                height: Config.yMargin(context, 100),
                child: TabBarView(


                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[



           if(currentPost.account_type== 'b' )        _userProfile != null  ?


                         ListView.builder(


                           itemCount: _userProfile.productsModel.length,
                           itemBuilder: (BuildContext context, int index) {
                             return  Container(
                                 height: Config.yMargin(context, 30),
                                 margin: const EdgeInsets.only(left: 20.0),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text('${_userProfile.productsModel[index].name}',style: appThemeDark.textTheme.subhead,),
                                     Container(
                                       height: Config.yMargin(context, 25),
                                       width: double.infinity,
                                       child: ListView.builder(
                                         scrollDirection: Axis.horizontal,
                                         itemCount: _userProfile.productsModel[index].subheadLength,
                                         itemBuilder: (ctx, index2){

                                           return  Container(
                                               width: Config.xMargin(context, 35),
                                               margin: const EdgeInsets.only(right:8.0, top: 8.0),

                                               decoration: BoxDecoration(
                                                   shape:BoxShape.rectangle,
                                                   borderRadius: BorderRadius.circular(5),
                                                   border: Border.all(color: Colors.white),
                                                   color: Colors.white
                                               ),
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   InkWell(
                                                     child: Container(
                                                       height: Config.yMargin(context, 18),
                                                       decoration: BoxDecoration(
                                                         shape:BoxShape.rectangle,
                                                         borderRadius: BorderRadius.circular(5),
                                                         border: Border.all(color: Colors.white),

                                                         image: DecorationImage(
                                                             image:  AssetImage('images/coin1.jpg'),
                                                             fit: BoxFit.cover

                                                         ),
                                                       ),

                                                     ),
                                                     onTap: (){
                                                     _showbottom(context,_userProfile.productsModel[index],index2);
                                                     },
                                                   ),
                                                   Expanded(




                                                     child:Text(' ${_userProfile.productsModel[index].subheadNmae[index2]}',style: appThemeDark.textTheme.display2,),

                                                   )

                                                 ],
                                               )
                                           );
                                         },
                                       ),
                                     )
                                   ],
                                 )
                             );

                           }

                         )




                  :Center(child: CircularProgressIndicator()),

                    if(currentPost.account_type== 'a' )        _userProfile != null  ?


                    ListView.builder(


                        itemCount: _userProfile.productsModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return  Container(
                              height: Config.yMargin(context, 30),
                              margin: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${_userProfile.productsModel[index].name}',style: appThemeDark.textTheme.subhead,),
                                  Container(
                                    height: Config.yMargin(context, 25),
                                    width: double.infinity,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _userProfile.productsModel[index].subheadLength,
                                      itemBuilder: (ctx, index2){

                                        return  Container(
                                            width: Config.xMargin(context, 35),
                                            margin: const EdgeInsets.only(right:8.0, top: 8.0),

                                            decoration: BoxDecoration(
                                                shape:BoxShape.rectangle,
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(color: Colors.white),
                                                color: Colors.white
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    height: Config.yMargin(context, 18),
                                                    decoration: BoxDecoration(
                                                      shape:BoxShape.rectangle,
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(color: Colors.white),

                                                      image: DecorationImage(
                                                          image:  AssetImage('images/coin1.jpg'),
                                                          fit: BoxFit.cover

                                                      ),
                                                    ),

                                                  ),
                                                  onTap: (){
                                                    _showbottom(context,_userProfile.productsModel[index],index2);
                                                  },
                                                ),
                                                Expanded(




                                                  child:Text(' ${_userProfile.productsModel[index].subheadNmae[index2]}',style: appThemeDark.textTheme.display2,),

                                                )

                                              ],
                                            )
                                        );
                                      },
                                    ),
                                  )
                                ],
                              )
                          );

                        }

                    )




                        :Center(child: CircularProgressIndicator()),

                    if(currentPost.account_type== 'i' )        _userProfile != null  ?


                    ListView.builder(


                        itemCount: _userProfile.productsModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return  Container(
                              height: Config.yMargin(context, 30),
                              margin: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${_userProfile.productsModel[index].name}',style: appThemeDark.textTheme.subhead,),
                                  Container(
                                    height: Config.yMargin(context, 25),
                                    width: double.infinity,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _userProfile.productsModel[index].subheadLength,
                                      itemBuilder: (ctx, index2){

                                        return  Container(
                                            width: Config.xMargin(context, 35),
                                            margin: const EdgeInsets.only(right:8.0, top: 8.0),

                                            decoration: BoxDecoration(
                                                shape:BoxShape.rectangle,
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(color: Colors.white),
                                                color: Colors.white
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    height: Config.yMargin(context, 18),
                                                    decoration: BoxDecoration(
                                                      shape:BoxShape.rectangle,
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(color: Colors.white),

                                                      image: DecorationImage(
                                                          image:  AssetImage('images/coin1.jpg'),
                                                          fit: BoxFit.cover

                                                      ),
                                                    ),

                                                  ),
                                                  onTap: (){
                                                    _showbottom(context,_userProfile.productsModel[index],index2);
                                                  },
                                                ),
                                                Expanded(




                                                  child:Text(' ${_userProfile.productsModel[index].subheadNmae[index2]}',style: appThemeDark.textTheme.display2,),

                                                )

                                              ],
                                            )
                                        );
                                      },
                                    ),
                                  )
                                ],
                              )
                          );

                        }

                    )




                        :Center(child: CircularProgressIndicator()),


                  userposts != null   ?  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 1.5,
                          mainAxisSpacing: 2.0


                      ),

                      itemCount: userposts.length,
                      itemBuilder: (BuildContext context, int index) => userposts[index].status.isNotEmpty? InkWell(
                        child: Container(
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.only(topLeft:Radius.circular(15),
                                topRight:Radius.circular(15),
                                bottomLeft:Radius.circular(15),
                                bottomRight:Radius.circular(15)),
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image:NetworkImage('https://showyourtrade.com/user/${userposts[index].storename}/status/${userposts[index].status}')
                            ),



                          ),

                        ),
                        onTap: (){
                          Navigator.of(context).pushNamed(UsersPostScreen.routeName,arguments: {'list':userposts});
                        },
                      ):null,
                    ) :Center(child: CircularProgressIndicator()),


                    _userProfile != null ?  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 1.5,
                          mainAxisSpacing: 2.0


                      ),

                      itemCount: userposts.length,
                      itemBuilder: (BuildContext context, int index) => userposts[index].status.isNotEmpty? InkWell(
                        child: Container(
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.only(topLeft:Radius.circular(15),
                                topRight:Radius.circular(15),
                                bottomLeft:Radius.circular(15),
                                bottomRight:Radius.circular(15)),
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image:NetworkImage('https://showyourtrade.com/user/${userposts[index].storename}/status/${userposts[index].status}')
                            ),



                          ),

                        ),
                        onTap: (){
                          Navigator.of(context).pushNamed(UsersPostScreen.routeName,arguments: {'list':userposts});
                        },
                      ):null,
                    ) :Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),)




            ],
          ) ,
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.black,
      //
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //
      //       icon: Icon(Icons.amp_stories,
      //         size: 25,),
      //       title: Text('Shows'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.all_inclusive,
      //         size: 25,),
      //       title: Text('Posts'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add_box_rounded,
      //         size: 25,),
      //       title: Text('Upload'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.store,
      //         size: 25,
      //       ),
      //       title: Text('Products'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.people,
      //         size: 25,),
      //       title: Text('Services'),
      //     ),
      //   ],
      //   currentIndex: _selectnumber,
      //   selectedItemColor: Colors.blueAccent,
      //   unselectedItemColor: Colors.white,
      //   onTap:_selectedPage,
      // ),

    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}