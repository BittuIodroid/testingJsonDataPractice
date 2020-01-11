import 'package:flutter/material.dart';


class PostModel {
  List<Post> posts;

  PostModel({this.posts});

  PostModel.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = new List<Post>();
      json['posts'].forEach((v) {
        posts.add(new Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.posts != null) {
      data['posts'] = this.posts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Post {
  int postId;
  String post;
  String image;
  String name;
  String date;
  int like;
  int dislike;
  List<Comment> comments;

  Post(
      {this.postId,
        this.post,
        this.image,
        this.name,
        this.date,
        this.like,
        this.dislike,
        this.comments});

  Post.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    post = json['post'];
    image = json['image'];
    name = json['name'];
    date = json['date'];
    like = json['like'];
    dislike = json['dislike'];
    if (json['comments'] != null) {
      comments = new List<Comment>();
      json['comments'].forEach((v) {
        comments.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['post'] = this.post;
    data['image'] = this.image;
    data['name'] = this.name;
    data['date'] = this.date;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  int commentId;
  String comment;
  String image;
  String name;
  String date;
  int like;
  int dislike;
  List<Reply> replies;

  Comment(
      {this.commentId,
        this.comment,
        this.image,
        this.name,
        this.date,
        this.like,
        this.dislike,
        this.replies});

  Comment.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    comment = json['comment'];
    image = json['image'];
    name = json['name'];
    date = json['date'];
    like = json['like'];
    dislike = json['dislike'];
    if (json['replies'] != null) {
      replies = new List<Reply>();
      json['replies'].forEach((v) {
        replies.add(new Reply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentId'] = this.commentId;
    data['comment'] = this.comment;
    data['image'] = this.image;
    data['name'] = this.name;
    data['date'] = this.date;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reply {
  int replyId;
  String reply;
  String image;
  String name;
  String date;
  int like;
  int dislike;

  Reply(
      {this.replyId,
        this.reply,
        this.image,
        this.name,
        this.date,
        this.like,
        this.dislike});

  Reply.fromJson(Map<String, dynamic> json) {
    replyId = json['replyId'];
    reply = json['reply'];
    image = json['image'];
    name = json['name'];
    date = json['date'];
    like = json['like'];
    dislike = json['dislike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replyId'] = this.replyId;
    data['reply'] = this.reply;
    data['image'] = this.image;
    data['name'] = this.name;
    data['date'] = this.date;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    return data;
  }
}