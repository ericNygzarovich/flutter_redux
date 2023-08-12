import 'package:flutter/material.dart';

import 'package:work_with_rest_api/redux/store.dart';

abstract class Action {}

class DecrementAction implements Action {}

class ResetTextAction implements Action {}

class Load implements Action {}

class LoadMessanges implements Action {}

class IncrementAction implements Action {
  int count;

  IncrementAction({required this.count});
}

class SetTextAction implements Action {
  final String text;

  SetTextAction({required this.text});
}

class LoadedImage implements Action {
  final Widget imagePath;

  LoadedImage({required this.imagePath});
}

class LoadedMessanges implements Action {
  final List<Messanges> messanges;

  LoadedMessanges({required this.messanges});
}
