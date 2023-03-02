import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'flex_textfield_factory.dart';

class FlexTextFieldController {
  /// streams: [onChange], [onSubmit]
  /// functions: [addTextToField]
  /// get: [widget], [textEditingController], [focusNode]
  /// set: [keyboardType] (default: TextInputType.text)
  /// get [buildWidget] (rebuilds widget)
  /// set [textStyle] (default: null) textStyle is applied to the TextField
  /// set [inputDecoration] (default: null) inputDecoration is applied to the TextField
  /// set [textEditingController] (default: TextEditingController())
  final BehaviorSubject<String> onChange;
  final BehaviorSubject<String> onSubmit;
  final BehaviorSubject<TextField> widgetStream;
  TextField? _widget;
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
        focusNode = FocusNode(),
        widgetStream = BehaviorSubject<TextField>();

  void addTextToField(String s) {
    textEditingController.text = s;
    moveCursorTo(textEditingController.text.length);
  }

  void moveCursorTo(int i) {
    textEditingController.selection =
        TextSelection.fromPosition(TextPosition(offset: i));
  }

  Widget get widget {
    return StreamBuilder(
      stream: widgetStream,
        builder: (context, snapshot) {
      if (snapshot.hasData) {
        return snapshot.data as Widget;
      } else {
        return buildWidget;
      }
    });
  }

  TextField get buildWidget {
    _widget = flexTextFieldFactory(
        onChange, onSubmit, textEditingController, focusNode, _keyboardType,
        textStyle: textStyle, decoration: inputDecoration);
    // }
    widgetStream.value = _widget!;
    return _widget!;
  }
}

