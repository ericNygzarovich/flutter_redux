import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:work_with_rest_api/redux/store.dart';

import 'action.dart';

AppStorage reducer(AppStorage state, dynamic action) => AppStorage(
      counter: _counterReducer(state.counter, action),
      textField: _textReducer(state.textField, action),
      image: _imageReduser(state.image, action),
      fakeMessanges:
          state.fakeMessanges + _listMessanges(state.fakeMessanges, action),
    );

List<Messanges> _listMessanges(List<Messanges> messanges, dynamic action) {
  return (action is LoadedMessanges) ? action.messanges : messanges;
}

Reducer<Widget> _imageReduser = combineReducers([
  TypedReducer<Widget, LoadedImage>(_image),
  TypedReducer<Widget, Load>(_loadind),
]);

Reducer<int> _counterReducer = combineReducers([
  TypedReducer<int, IncrementAction>(_increment),
  TypedReducer<int, DecrementAction>(_decrement),
]);

Reducer<String> _textReducer = combineReducers([
  TypedReducer<String, SetTextAction>(_setText),
  TypedReducer<String, ResetTextAction>(_resetText),
]);

Widget _image(Widget image, dynamic action) {
  return action.imagePath;
}

Widget _loadind(Widget image, dynamic action) =>
    const CircularProgressIndicator.adaptive();

String _setText(String text, dynamic action) => action.text;
String _resetText(String text, dynamic action) => 'reset text';

int _increment(int counter, dynamic action) {
  if (action is IncrementAction) {
    return counter += action.count;
  }

  return counter;
}

int _decrement(int counter, dynamic action) => counter - 1;
