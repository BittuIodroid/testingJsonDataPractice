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
  List<Post> posts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forecastObject = Network().getWeatherForecast();
    forecastObject.then((weather){
      posts = weather.posts;
      postLength = posts.length;
      for(var i = 0; i < postLength; i++) {
        print("NAME: ${posts[i].name}");
      }
    });
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
          builder: (BuildContext context,AsyncSnapshot<PostModel> snapshot){
            switch (snapshot.connectionState) {
               case ConnectionState.none:
                return Text('Press button to start.');
               case ConnectionState.active:
               case ConnectionState.waiting:
                 return Text('Awaiting result...');
               case ConnectionState.done:
                 if (snapshot.hasError)
                   return Text('Error: ${snapshot.error}');
                 return createPostList(context,snapshot);
             }
             return null;
              },
        ));
  }

  Widget createPostList(BuildContext context, AsyncSnapshot<PostModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.posts.length,
        itemBuilder: (BuildContext context,int postIndex){
            return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.circular(13.9),
                        ),
                        child: Text("${snapshot.data.posts[postIndex].postId}"),
                      ),
                    ),
                    title: Text(snapshot.data.posts[postIndex].name),
                    subtitle: Text("${snapshot.data.posts[postIndex].post}"),
                    trailing: Text("${snapshot.data.posts[postIndex].date}"),
                    onTap: () {

                      //Going to the second page
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => PostData(postDetail: snapshot.data.posts[postIndex].name,
                          postDetailChecking: snapshot.data.posts[postIndex])
                      ));
                    },

                    //onTap: ()=> debugPrint("${snapshot.data.posts[postIndex].dislike}"),
                  )
                );
                //Divider(color:Colors.white,height: 5.0,)

        },);
  }
}



//New route or Second Page
class PostData extends StatelessWidget {
  final String postDetail;
  final Post postDetailChecking;

  const PostData({Key key, this.postDetail,this.postDetailChecking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Detail"),
      ),
      body: Container(
        child: ListTile(
          title: Text("${this.postDetail}"),
          subtitle: Text("${this.postDetailChecking.post}"),

        ),



//        child: FlatButton(
//          color: Colors.blue,
//          child: Text("Second Page"),
//          onPressed: (){
//            Navigator.pop(context);
//          },
//        ),
      ),
    );
  }
}
