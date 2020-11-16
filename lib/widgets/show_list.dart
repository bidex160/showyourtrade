import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showyourtrade/Model/comment_model.dart';
import 'package:showyourtrade/Model/index_post.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:intl/intl.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';
import 'package:showyourtrade/showprofile/profilescreen.dart';
import 'package:showyourtrade/stackscreen/stories_Screen.dart';

class ShowListItems extends StatefulWidget {
// Function handler;
// ShowListItems(this.handler);
  @override
  _ShowListItemsState createState() => _ShowListItemsState();
}

class _ShowListItemsState extends State<ShowListItems> {
  bool flag =true;
  List<CommentModel> comm = [];
  void showPicker(BuildContext context, IndexPostModel indexPostModel){
    indexPostModel.commentM().then((value) {
      setState(() {
        comm = value;
        print(comm.length);
      });

    });

    showModalBottomSheet(

        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
                shape:BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white),
                color: Colors.white
            ),
            height: Config.yMargin(context, 70),
            child: Scaffold(


                  resizeToAvoidBottomInset: true,

             body: Container(
                // color: Colors.black,
                height: Config.yMargin(context,90),
                child: Stack(

                  children: [
                    new  Container(
                        alignment: Alignment.topCenter,
                        padding: new EdgeInsets.only(
                            top: 10,
                            right: 10.0,
                            left: 10.0),
                        child: Text('${indexPostModel.comment} comments',style: appThemeDark.textTheme.display2,)),


                    new  Container(
                      alignment: Alignment.topCenter,
                      padding: new EdgeInsets.only(
                          top: 35,
                          right: 10.0,
                          left: 10.0),
                      child: Divider(color: Colors.black45,),

                    ),


                    new  Container(
                        alignment: Alignment.topRight,
                        padding: new EdgeInsets.only(
                            top: 1,

                            right: 10.0),
                        child: IconButton(icon: Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.red,

                        ),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },)),


                   new  Container(
                      height: Config.yMargin(context, 50),
                      alignment: Alignment.center,
                      margin: new EdgeInsets.only(
                          top: Config.yMargin(context, 6),
                          bottom: Config.yMargin(context, 10),
                          left: 10.0,
                          right: 10.0),
                      // color: Colors.red,
                      child:  StreamBuilder(
                        stream: indexPostModel.commentM().asStream(),
                      builder: (ctx, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        }else {

                           comm = snapshot.data;
                           print(comm.length);
                          return Container(
                            child: ListView.builder(
                              itemCount:snapshot.data.length,
                              //    itemExtent: 1000,
                              // shrinkWrap: true,
                              itemBuilder: (context, index){
                                return Container(

                                  width: Config.xMargin(context, 80),

                                  child: Column(
                                    children: [
                                      SizedBox(height: Config.yMargin(context, 0.5),),
                                      Row(
                                        children: [
                                          Container(

                                            child: CircleAvatar(radius: 12,
                                              backgroundColor: Colors.white,
                                              backgroundImage:indexPostModel.avatar != null ? NetworkImage('https://showyourtrade.com/user/${indexPostModel.account_name}/${indexPostModel.avatar}'):
                                              Container(color: Colors.white,),


                                            ),
                                            margin: const EdgeInsets.only(right: 7),
                                            //  width: Config.xMargin(context, 15),
                                          ),
                                          Container(
                                            width: Config.xMargin(context, 70),
                                            child: Text('${comm[index].author}  ${comm[index].data}'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Config.yMargin(context, 0.5),),
                                      Divider(
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                );
                              },

                            ),
                          );
                        }



                      },
                      ),

                ),

                    new  Container(
                        alignment: Alignment.bottomCenter,

                        padding: new EdgeInsets.only(
                            bottom:  10.0,
                            right: 10.0,
                            left: 10.0),
                        child: Container(

                          height: Config.yMargin(context, 6),
                          child: TextFormField(

                            decoration: InputDecoration(
                                hintText: 'Comment..',
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      Icons.send
                                  ),
                                )
                            ),


                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        }
    );



  }


  Widget _datePosted(String date){

    final postedDate = DateTime.parse(date);
    //final da = DateTime(postedDate);
    final _current =  DateTime.now();
    return  FittedBox(
      child: Text(' ${_current.difference(postedDate).inDays >30 ? '${_current.difference(postedDate).inDays ~/ 30} months ago': ' ${_current.difference(postedDate).inDays} days ago' }  ',style: TextStyle(
        color: Colors.white,
      ),),
    );
  }
  @override
  Widget build(BuildContext context) {
    final  indexPost = Provider.of<IndexPostModel>(context);
    return  Container(

      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft:Radius.circular(15),
            topRight:Radius.circular(15),
            bottomLeft:Radius.circular(15),
            bottomRight:Radius.circular(15)),


      ),
      child: Column(

        children: [
          Expanded(

            child: Stack(

              children: [

                if(indexPost.statusphoto.isNotEmpty) new Container(

                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(

                        fit: BoxFit.contain,

                        //    image:AssetImage('${posts[index].url}')
                     image: NetworkImage('https://showyourtrade.com/user/${indexPost.account_name}/status/${indexPost.statusphoto}')

                      )
                  ),

                ),
                new Container(
                  alignment: Alignment.bottomRight,
                  padding: new EdgeInsets.only(
                      bottom:Config.yMargin(context, 3),
                      right: 15.0,
                      left: 10.0),
                  child: Container(
                    height: Config.yMargin(context, 30),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [


                        Container(
                          width: Config.xMargin(context, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              indexPost.likerName == 'bidex160' ? IconButton(icon: Icon(
                                       Icons.favorite,
                                       color: Colors.red,
                                          size: 25,
                             ), onPressed: (){
                                      indexPost.unlikeM();

                                    })  :IconButton(icon: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 25,
                              ), onPressed: (){
                               indexPost.likeM();
                              }),
                              Text('${indexPost.likes}',style: appThemeDark.textTheme.display1),

                            ],
                          ),
                        ),

                        Container(
                          width: Config.xMargin(context, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              IconButton(icon: Icon(
                                Icons.mode_comment_outlined,
                                color: Colors.white,
                                size: 25,
                              ), onPressed: (){
                               // widget.handler();
                               //  indexPost.commentM().then((value) {
                               //    setState(() {
                               //      comm = value;
                               //    });
                               //
                               //  });
                                //indexPost.commentM();
                                showPicker(context, indexPost);
                                print(comm.length);
                              }),
                              Text('${indexPost.comment}',textAlign: TextAlign.center,style: appThemeDark.textTheme.display1),

                            ],
                          ),
                        ),
                        Container(
                          width: Config.xMargin(context, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(icon: Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 25,
                              ), onPressed: null),
                              FittedBox(
                                child: Text('10',style: appThemeDark.textTheme.display1),
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                new Container(
                  width: Config.xMargin(context, 85),

                  alignment: Alignment.bottomLeft,

                  padding: new EdgeInsets.only(

                      bottom:Config.yMargin(context, 3),
                      right: 10.0,
                      left: 20.0),

                  child:  Container(
                    // height: Config.yMargin(context, 35),

                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height:  Config.yMargin(context, 5),
                            child: FittedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(

                                    child: CircleAvatar(radius: 12,
                                      backgroundColor: Colors.white,
                                      backgroundImage:indexPost.avatar != null ? NetworkImage('https://showyourtrade.com/user/${indexPost.account_name}/${indexPost.avatar}'):
                                      null,


                                    ),
                                    margin: const EdgeInsets.only(right: 7),
                                    //  width: Config.xMargin(context, 15),
                                  ),
                                  InkWell(
                                    child: FittedBox(
                                      child: Text('${indexPost.account_name}',style: appThemeDark.textTheme.display1),
                                    ),
                                    onTap: (){
                                     Navigator.of(context).pushNamed(ShowProfileScreen.routeName, arguments: {'currentPost':indexPost});

                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8, right: 8),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 2,
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text('follow',style: TextStyle(

                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold

                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8, right: 8),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 2,
                                    ),
                                  ),
                                  _datePosted(indexPost.postdate)
                                  // FittedBox(
                                  //   child: Text(' ${DateFormat.yMMMMd("en_US").format(DateTime.parse(indexPost.postdate))} ',style: appThemeDark.textTheme.display1),
                                  // ),
                                ],

                              ),
                            ),
                          ),


                          Container(
                            margin: const EdgeInsets.only(top:5),
                            width: Config.xMargin(context, 80),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,

                              children: [
                                Container(

                                  width: Config.xMargin(context, 80),
                                  child: indexPost.flag?Text('${indexPost.data }',style: appThemeDark.textTheme.display1,
                                  overflow: TextOverflow.ellipsis,)
                                  :Text('${indexPost.data }',style: appThemeDark.textTheme.display1),
                                ),
                                new InkWell(
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      new Text(
                                        indexPost.flag?"show more":"Show less", style: appThemeDark.textTheme.display1),

                                    ],
                                  ),
                                  onTap: (){setState(() {
                                   indexPost.checkText();
                                  //  flag =!flag;
                                  });},
                                )
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              height: 25),
          Divider(color: Colors.white,)
        ],
      ),
    );
  }
}

