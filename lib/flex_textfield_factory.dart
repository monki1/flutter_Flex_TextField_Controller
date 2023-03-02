import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

int maxLines = 2048;

TextField flexTextFieldFactory(
    BehaviorSubject<String> onChangeStream,
    BehaviorSubject<String> onSubmitStream,
    TextEditingController controller,
    FocusNode focusNode,
    TextInputType keyboardType,
    {TextStyle? textStyle,
    InputDecoration? decoration}) {
  TextField t = TextField(
    style: textStyle,
    onSubmitted: (String s) {
      controller.clear();
      onSubmitStream.add(s);
    },
    onChanged: (String s) {
      onChangeStream.add(s);
    },
    focusNode: focusNode,
    autofocus: true,
    controller: controller,
    decoration: decoration,
    textInputAction: TextInputAction.send,
    keyboardType: keyboardType,
    minLines: 1,
    maxLines: maxLines,
    onEditingComplete: () {

    },
  );
  return t;
}