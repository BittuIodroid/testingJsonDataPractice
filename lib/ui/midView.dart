import 'package:flutter/material.dart';
import 'package:weather/model/Post_model.dart';


Widget midView(AsyncSnapshot<PostModel> snapshot){
  var forecastPostList = snapshot.data.posts;
  Container midView = Container(
    child: ListView.builder(
        itemCount: forecastPostList.length,
        itemBuilder: (BuildContext context, int postIndex){
          return Card(
            child: Text("${snapshot.data.posts[postIndex].name}"),
          );
        })

        //Text("${snapshot.data.posts[0].image}")
  );
  return midView;
}