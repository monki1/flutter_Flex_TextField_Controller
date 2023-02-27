import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'flex_textfield_factory.dart';

class FlexTextFieldController {
  /// streams: [onChange], [onSubmit]
  /// functions: [addTextToField]
  /// get: [widget], [textEditingController], [focusNode]
  /// set: [keyboardType] (default: TextInputType.text)
  /// get [newWidget] (rebuilds widget)
  /// set [textStyle] (default: null) textStyle is applied to the TextField
  final BehaviorSubject<String> onChange;
  final BehaviorSubject<String> onSubmit;
  Widget? _widget;
  InputDecoration? inputDecoration;
  TextEditingController textEditingController;
  TextStyle? textStyle;
  final FocusNode focusNode;
  TextInputType _keyboardType = TextInputType.text;

  set keyboardType(TextInputType type) {

    _keyboardType = type;
  }

  FlexTextFieldController({this.inputDecoration})
      : onChange = BehaviorSubject<String>(),
        onSubmit = BehaviorSubject<String>(),
        textEditingController = TextEditingController(),
        focusNode = FocusNode();

  void addTextToField(String s) {
    textEditingController.text = s;
    moveCursorTo(textEditingController.text.length);
  }

  void moveCursorTo(int i) {
    textEditingController.selection =
        TextSelection.fromPosition(TextPosition(offset: i));
  }

  Widget get widget {
    if (_widget == null) {
      return newWidget;
    }
    return _widget!;
  }

  Widget get newWidget {
    _widget = flexTextFieldFactory(
        onChange, onSubmit, textEditingController, focusNode, _keyboardType,
        textStyle: textStyle, decoration: inputDecoration);
    // }
    return _widget!;
  }
}

