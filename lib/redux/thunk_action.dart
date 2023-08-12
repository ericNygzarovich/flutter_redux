import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'action.dart';
import 'store.dart';

ThunkAction getFakeMessanges = (Store store) async {
  store.dispatch(LoadMessanges());

  _getListOfMessanges().then(
    (value) => store.dispatch(
      LoadedMessanges(messanges: value),
    ),
  );
};

Future<List<Messanges>> _getListOfMessanges() async {
  await Future.delayed(const Duration(seconds: 2));

  final cliet = HttpClient();
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  try {
    final request = await cliet.getUrl(url);
    final response = await request.close();

    final jsonstring = await response.transform(utf8.decoder).toList();
    final result = jsonDecode(jsonstring.join()) as List<dynamic>;

    return result
        .map((dynamic element) => Messanges.fromJson(element))
        .toList();
  } catch (error) {
    throw 'an error occured $error';
  }
}

ThunkAction calcCountThunckAction = (Store store) async {
  compute(calc, 20000000)
      .then((result) => store.dispatch(IncrementAction(count: result)));
};

Future<int> calc(int count) async {
  int result = 0;
  for (int i = 0; i < count; i++) {
    result++;
  }

  return result;
}

ThunkAction loadImageThunkAction = (Store store) async {
  store.dispatch(Load());

  _getImage('assets/avatar.jpeg')
      .then((image) => store.dispatch(LoadedImage(imagePath: image)));
};

Future<Widget> _getImage(String path) async {
  await Future.delayed(const Duration(seconds: 5));

  return Image.asset(path);
}
