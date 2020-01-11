

import 'package:flutter/material.dart';
import 'package:weather/model/Post_model.dart';
//import 'package:weather/model/weather_forecast_model.dart';
import 'package:weather/network/network.dart';

String postApi = "https://api.myjson.com/bins/z796m";

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
        body: ListView.builder(
            itemCount: postLength,
            itemBuilder: (BuildContext context, int postIndex){
              return Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Text(" ${postIndex} : Hello"),
                    Text("${posts[postIndex].name}"),
                    //Text("${posts[postIndex].image}"),
                    //Text("${posts[postIndex].name}"),


                    ListView.builder(
                      itemCount: posts[postIndex].comments.length,
                      itemBuilder: (BuildContext context,int commentIndex){
                        return Padding(
                            padding: EdgeInsets.only(left:20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(

                                    child: Text("${posts[postIndex].comments[commentIndex].name}")),

                                ListView.builder(
                                  itemCount: posts[postIndex].comments[commentIndex].replies.length,
                                  itemBuilder: (BuildContext context, int replyIndex){
                                    return Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("${posts[postIndex].comments[commentIndex].replies[replyIndex].name}")
                                        ],
                                      ),
                                    );
                                  },
                                  shrinkWrap: true,
                                )


                              ],
                            )

                        );

                      },
                      shrinkWrap: true,
                    )
                  ],
                ),

              );
            })

    );
  }
}

