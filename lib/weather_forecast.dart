import 'package:flutter/material.dart';
import 'package:weather/model/Post_model.dart';

//import 'package:weather/model/weather_forecast_model.dart';
import 'package:weather/network/network.dart';
import 'package:weather/ui/midView.dart';
//import 'package:weather/ui/midView.dart';

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  Future<PostModel> forecastObject;
  var postLength;
 // List<Post> posts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forecastObject = Network().getWeatherForecast();
//    forecastObject.then((weather) {
//      posts = weather.posts;
//      postLength = posts.length;
//      for (var i = 0; i < postLength; i++) {
//        print("NAME: ${posts[i].name}");
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather Forecast"),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        backgroundColor: Colors.blueGrey.shade400,
        body: FutureBuilder(
          future: forecastObject,
          builder: (BuildContext context, AsyncSnapshot<PostModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start.');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Text('Awaiting result...');
              case ConnectionState.done:
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                return createPostList(context,
                    snapshot); // Returning Post Data if no error is found
            }
            return null;
          },
        ));
  }
}




















//New route or Second Page
class PostListViewDetail extends StatelessWidget {
  final Post postDetail;

  //sList comment = postDetail.comments;
  const PostListViewDetail({Key key, this.postDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text("Post Detail"),
      ),
      backgroundColor: Colors.blueGrey.shade400,
      body: Column(
        children: <Widget>[
          Container(
            //height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.width,
            height: 170,
            child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 90.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //For data inside the Column
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(postDetail.name,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                          Text(postDetail.date),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: Text(
                            postDetail.post,
                            style: TextStyle(fontSize: 15.0),
                          ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Icon(Icons.arrow_upward, color: Colors.red),
                              Text("${postDetail.like}")
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(Icons.arrow_downward, color: Colors.black87),
                              Text("${postDetail.dislike}"),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

          ),


          //Comments List
          Expanded(
            child: ListView.builder(
              itemCount: postDetail.comments.length,
              itemBuilder: (BuildContext context, int commentIndex) {
                return Row(
                  children: <Widget>[

                    Stack(
                      children: <Widget>[
                        commentListCard(postDetail.comments[commentIndex], context),
                        Positioned(
                            top: 20.0,
                            left: 10.0,
                            child: profileImage(
                                postDetail.comments[commentIndex].image))


                      ],
                    ),

//                    ListView.builder(
//                        itemCount: postDetail.comments[commentIndex].replies.length,
//                        itemBuilder: (BuildContext context, int replyIndex) {
//                          return Row(
//                            children: <Widget>[
//                              Stack(
//                                children: <Widget>[
//                                  replyListCard(postDetail.comments[commentIndex].replies[replyIndex], context),
//                                  Positioned(
//                                      top: 20.0,
//                                      left: 10.0,
//                                      child: profileImage(
//                                          postDetail.comments[commentIndex].image))
//
//
//                                ],
//                              ),
//
//
//                            ],
//                          );
//                        },
//
//
//                      ),


                  ],
                );
              },


            ),
          ),



































//          Column(
//            children: <Widget>[
          //Comment Data
//              ListView.builder(
//                itemCount: postDetail.comments.length,
//                itemBuilder: (BuildContext context, int commentIndex) {
//                  return Text("Hello");
////                  return Stack(
////                    children: <Widget>[
////                      commentListCard(
////                          postDetail.comments[commentIndex], context),
//////            Positioned(
//////              top: 20.0,left: 10.0,
//////              child:profileImage(postDetail.comments[commentIndex].image))
////                    ],
////                  );
//                },
//              )
//            ],
//          ),
        ],
      ),
    );
  }
}

//Displaying Post List
Widget createPostList(BuildContext context, AsyncSnapshot<PostModel> snapshot) {
  return ListView.builder(
    itemCount: snapshot.data.posts.length,
    itemBuilder: (BuildContext context, int postIndex) {
      return Stack(
        children: <Widget>[
          postListCard(snapshot.data.posts[postIndex], context),
          Positioned(
              top: 20.0,
              left: 10.0,
              child: profileImage(snapshot.data.posts[postIndex].image))
        ],
      );

      //            return Card(
//                  child: ListTile(
//                    leading: CircleAvatar(
//                      child: Container(
//                        decoration: BoxDecoration(
//                          image: DecorationImage(
//                            image: NetworkImage(snapshot.data.posts[postIndex].image),
//                            fit: BoxFit.cover
//                          ) ,
//                          //color: Colors.blue,
//                          borderRadius: BorderRadius.circular(13.9),
//                        ),
//                        //child: Text("${snapshot.data.posts[postIndex].postId}"),
//                      ),
//                    ),
//                    title: Text(snapshot.data.posts[postIndex].name),
//                    subtitle: Text("${snapshot.data.posts[postIndex].post}"),
//                    trailing: Text("${snapshot.data.posts[postIndex].date}"),
//                    onTap: () {
//
//                      //Going to the second page
//                      Navigator.push(context, MaterialPageRoute(
//                        builder: (context) => PostData(postDetail: snapshot.data.posts[postIndex].name,
//                          postDetailChecking: snapshot.data.posts[postIndex])
//                      ));
//                    },
//
//                    //onTap: ()=> debugPrint("${snapshot.data.posts[postIndex].dislike}"),
//                  )
//                );
      //Divider(color:Colors.white,height: 5.0,)
    },
  );
}

//List of posts
Widget postListCard(Post postAllData, BuildContext context) {
  return InkWell(
    child: Container(
      //height: MediaQuery.of(context).size.height/4,
      width: MediaQuery.of(context).size.width,
      height: 170,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 90.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            //For data inside the Column
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(postAllData.name,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  Text(postAllData.date),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                      child: Text(
                    postAllData.post,
                    style: TextStyle(fontSize: 15.0),
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(Icons.arrow_upward, color: Colors.red),
                      Text("${postAllData.like}")
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.arrow_downward, color: Colors.black87),
                      Text("${postAllData.dislike}")
                    ],
                  )
                ],
              ),
              Row(
                children: <Widget>[

                ],
              ),
            ],
          ),
        ),
      ),
    ),
    onTap: () {
      // Going to the second page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PostListViewDetail(postDetail: postAllData)));
    },
  );
}

//List of comments
Widget commentListCard(Comment commentAllData, BuildContext context) {
  return Container(
    //height: MediaQuery.of(context).size.height/4,
    width: MediaQuery.of(context).size.width,
    height: 170,
    child: Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 90.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          //For data inside the Column
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(commentAllData.name,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                Text(commentAllData.date),
              ],
            ),
            Row(
              children: <Widget>[
                Flexible(
                    child: Text(
                      commentAllData.comment,
                  style: TextStyle(fontSize: 15.0),
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(Icons.arrow_upward, color: Colors.red),
                    Text("${commentAllData.like}")
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(Icons.arrow_downward, color: Colors.black87),
                    Text("${commentAllData.dislike}")
                  ],
                )
              ],
            ),

          ],
        ),

      ),
    ),
  );

  /*onTap: () {
      // Going to the second page
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => PostListViewDetail(postDetail: postAllData)
      ));
    },*/
}

//List of replies
Widget replyListCard(Reply replyAllData, BuildContext context) {
  return Container(
    //height: MediaQuery.of(context).size.height/4,
    width: MediaQuery.of(context).size.width,
    height: 170,
    child: Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 90.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          //For data inside the Column
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(replyAllData.name,
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                Text(replyAllData.date),
              ],
            ),
            Row(
              children: <Widget>[
                Flexible(
                    child: Text(
                      replyAllData.reply,
                      style: TextStyle(fontSize: 15.0),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(Icons.arrow_upward, color: Colors.red),
                    Text("${replyAllData.like}")
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(Icons.arrow_downward, color: Colors.black87),
                    Text("${replyAllData.dislike}")
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ),
  );

  /*onTap: () {
      // Going to the second page
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => PostListViewDetail(postDetail: postAllData)
      ));
    },*/
}


//Profile Image
Widget profileImage(String profileUrl) {
  return Container(
    width: 70.0,
    height: 70.0,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage(profileUrl), fit: BoxFit.cover)),
  );
}


