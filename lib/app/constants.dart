import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/nums.dart';

bool? userIsPremium;

//"https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80";

const String photoGuy =
    "https://images.unsplash.com/photo-1497316730643-415fac54a2af?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2400&q=80";
const String edp445Image =
    "https://img.itch.zone/aW1nLzgxMzEyOTguanBn/315x250%23c/9yD9hv.jpg";
const String suitGuy =
    "https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80";

const String girl1 =
    "https://media.istockphoto.com/photos/beautiful-nanny-and-young-boy-picture-id1297879919?k=20&m=1297879919&s=612x612&w=0&h=JXErrBe7MzXZARG4-CmMtE63z3vb_X1IHPqCqkvco58=";

const String girl2 =
    "https://media.istockphoto.com/id/179277735/photo/babysitter-piggyback.jpg?s=612x612&w=0&k=20&c=Wp9BKC3ZbTFDwPdBmZWUyOd4Q6pOhNXemjxBZpc-UwE=";

const String girl3 =
    "https://www.nationwidechildrens.org/-/media/nch/700childrens/2021/10/blog-safe-babysitter.jpg";

const String boy1 =
    "https://cloudfront-us-east-1.images.arcpublishing.com/archive.tronc/EEGAZC3OLRGYZICJTY3FCVNJ3M.jpg";

const String boy2 =
    "http://www.amusingmaralee.com/wp-content/uploads/2017/11/Untitled.png";

Container imageBlur(BoxConstraints constraints) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(AppSizes.searchBarBorderRadius),
            bottomRight: Radius.circular(AppSizes.searchBarBorderRadius)),
        gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95])),
  );
}
