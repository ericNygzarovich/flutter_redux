import 'package:flutter/cupertino.dart';

class AppStorage {
  int counter;
  String textField;
  Widget image;
  List<Messanges> fakeMessanges;

  AppStorage({
    required this.counter,
    required this.textField,
    required this.image,
    this.fakeMessanges = const [],
  });
}

class Messanges {
  final int userID;
  final int id;
  final String title;
  final String body;

  Messanges(
      {required this.body,
      required this.id,
      required this.title,
      required this.userID});

  factory Messanges.fromJson(Map<String, dynamic> json) => Messanges(
        userID: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );
}
