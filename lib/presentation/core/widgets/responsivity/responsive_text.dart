import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../style/color_palette.dart';

import '../../helpers/ui_helper.dart';
import 'device_detector_widget.dart';

enum TextType {
  Headline1,
  Headline2,
  Headline3,
  Headline4,
  Headline5,
  Headline6,
  Subtitle1,
  Subtitle2,
  Body1,
  Body2,
  Caption,
  ElevatedButton,
  OutlinedButton,
  InputFieldHint,
  InputFieldError,
  InputFieldLabel,
}

double calculateFontSize(SizingInformation size, int fontSize) {
  final _verticalUnit = size.blockUnit.height;
  final _factor = (fontSize + 1) / 10;
  final _resizedFontSize = _factor * _verticalUnit;
  return _resizedFontSize;
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextType textType;
  final TextAlign textAlign;
  final Color color;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final int maxLines;
  final int fontSize;
  final TextStyle textStyle;
  final List<TextSpan> textSpans;

  const ResponsiveText(
    this.text, {
    Key key,
    this.textType = TextType.Body1,
    this.fontSize = 20,
    this.textAlign,
    this.color,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    this.textSpans,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      safeAreaActive: false,
      builder: (buildContext, size) {
        return Text(
          text,
          style: calculateTextStyle(
            context,
            textType,
          ).copyWith(
            fontSize: calculateFontSize(size, fontSize),
            color: color,
            fontWeight: fontWeight,
          ),
          overflow: overflow,
          maxLines: maxLines,
          textAlign: textAlign,
        );
      },
    );
  }
}

class ResponsiveInput extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String initialValue;
  final TextEditingController controller;
  final bool obscureText;
  final bool isDense;
  final bool enabled;
  final TextInputType keyboardType;
  final AutovalidateMode autoValidateMode;
  final List<TextInputFormatter> inputFormatter;
  final int maxLength;
  final int fontSize;
  final void Function(String) onSaved;
  final void Function(String) onChanged;
  final String Function(String) validator;
  final bool readOnly;
  final IconData suffixIconData;
  final IconData prefixIconData;
  final Color iconColor;
  final Color prefixIconColor;
  final void Function() onIconPressed;
  final void Function() onTap;

  ResponsiveInput({
    Key key,
    this.labelText,
    this.hintText,
    this.fontSize = 28,
    this.initialValue,
    this.controller,
    this.enabled = true,
    this.obscureText = false,
    this.autoValidateMode,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLength,
    this.inputFormatter,
    this.onSaved,
    this.onChanged,
    this.isDense = true,
    this.suffixIconData,
    this.prefixIconData,
    this.iconColor = ColorPalette.primaryColorDark,
    this.prefixIconColor = ColorPalette.primaryColor,
    this.onIconPressed,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  _ResponsiveInputState createState() => _ResponsiveInputState();
}

class _ResponsiveInputState extends State<ResponsiveInput> {
  final _focus = FocusNode();
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    // for styling
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      safeAreaActive: false,
      builder: (context, size) {
        final _verticalUnit = size.blockUnit.height;
        final _horizontalUnit = size.blockUnit.width;
        final _iconsContraints = BoxConstraints(
          minHeight: _verticalUnit * UIHelper.iconFieldSize,
          maxHeight: _verticalUnit * UIHelper.iconFieldSize * 2,
          minWidth: _verticalUnit * UIHelper.iconFieldSize,
          maxWidth: _verticalUnit * UIHelper.iconFieldSize * 1.35,
        );
        return TextFormField(
          initialValue: widget.initialValue,
          controller: widget.controller,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          autovalidateMode: widget.autoValidateMode,
          showCursor: true,
          readOnly: widget.readOnly,
          cursorColor: ColorPalette.red,
          inputFormatters: widget.inputFormatter,
          focusNode: _focus,
          onTap: widget.onTap,
          obscureText: widget.obscureText,
          style: calculateTextStyle(
            context,
            TextType.Headline6,
          ).copyWith(
            fontSize: calculateFontSize(size, widget.fontSize),
            color: ColorPalette.greyText,
            decoration: _focus.hasFocus
                ? TextDecoration.underline
                : TextDecoration.none,
          ),
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            isDense: widget.isDense,
            contentPadding: EdgeInsets.only(
              left: _horizontalUnit / 2,
              bottom: _verticalUnit,
            ),
            hintText: widget.hintText,
            labelText: widget.labelText,
            hintStyle: calculateTextStyle(
              context,
              TextType.InputFieldHint,
            ).copyWith(
              fontSize: calculateFontSize(size, widget.fontSize),
            ),
            errorStyle: calculateTextStyle(
              context,
              TextType.InputFieldError,
            ).copyWith(
              fontSize: calculateFontSize(size, widget.fontSize - 4),
            ),
            counter: SizedBox.shrink(),
            labelStyle: calculateTextStyle(
              context,
              TextType.InputFieldLabel,
            ).copyWith(
              fontSize: calculateFontSize(size, widget.fontSize),
            ),
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
            suffixIconConstraints: _iconsContraints,
            prefixIconConstraints: BoxConstraints(
              minHeight: _verticalUnit * UIHelper.iconFieldSize,
              maxHeight: _verticalUnit * UIHelper.iconFieldSize * 2,
              minWidth: _verticalUnit * (UIHelper.iconFieldSize + 1),
              maxWidth: _verticalUnit * (UIHelper.iconFieldSize + 1),
            ),
            prefixIcon: widget.prefixIconData != null
                ? Icon(
                    widget.prefixIconData,
                    color: widget.prefixIconColor,
                    size: _verticalUnit * UIHelper.iconFieldSize,
                  )
                : null,
            suffixIcon: widget.suffixIconData != null
                ? Container(
                    margin: EdgeInsets.only(
                      right: _horizontalUnit / 4,
                      top: _verticalUnit * 2,
                    ),
                    child: InkWell(
                      onTap: () {
                        if (widget.onIconPressed != null) {
                          widget.onIconPressed();
                        }
                      },
                      child: Icon(
                        widget.suffixIconData,
                        color: widget.iconColor,
                        size: _verticalUnit * UIHelper.iconFieldSize,
                      ),
                    ),
                  )
                : null,
          ),
          validator: widget.validator,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
        );
      },
    );
  }
}

class ResponsiveFormFieldButton<T> extends StatefulWidget {
  const ResponsiveFormFieldButton({
    Key key,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.fontSize = 28,
    this.value,
    this.icon = Icons.arrow_drop_down,
    this.onIconTap,
    @required this.items,
  }) : super(key: key);

  final Function(T) onSaved;
  final String Function(T) validator;
  final Function(T) onChanged;
  final String labelText;
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final int fontSize;
  final T value;
  final IconData icon;
  final Function onIconTap;
  @override
  _ResponsiveFormFieldButtonState<T> createState() =>
      _ResponsiveFormFieldButtonState<T>();
}

class _ResponsiveFormFieldButtonState<T>
    extends State<ResponsiveFormFieldButton<T>> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        final _verticalUnit = size.blockUnit.height;
        final _horizontalUnit = size.blockUnit.width;
        return DropdownButtonFormField<T>(
          decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.hintText,
            isDense: true,
            contentPadding: EdgeInsets.only(
              left: _horizontalUnit / 2,
              bottom: _verticalUnit,
            ),
            hintStyle: calculateTextStyle(
              context,
              TextType.InputFieldHint,
            ).copyWith(
              fontSize: calculateFontSize(size, widget.fontSize),
            ),
            errorStyle: calculateTextStyle(
              context,
              TextType.InputFieldError,
            ).copyWith(
              fontSize: calculateFontSize(size, widget.fontSize - 4),
            ),
            labelStyle: calculateTextStyle(
              context,
              TextType.InputFieldLabel,
            ).copyWith(
              fontSize: calculateFontSize(size, widget.fontSize),
            ),
          ),
          iconEnabledColor: ColorPalette.primaryColorDark,
          icon: Padding(
            padding: EdgeInsets.only(right: _horizontalUnit / 4),
            child: InkWell(
              onTap: widget.onIconTap,
              child: Icon(
                widget.icon,
                color: ColorPalette.primaryColorDark,
                size: _verticalUnit * UIHelper.iconFieldSize,
              ),
            ),
          ),
          isDense: true,
          value: widget.value,
          items: widget.items,
          onChanged: (T newValue) {
            setState(() {
              if (widget.onChanged != null) {
                widget.onChanged(newValue);
              }
            });
          },
          validator: (T newValue) {
            if (widget.validator != null) {
              return widget.validator(newValue);
            }
            return null;
          },
          onSaved: (T newValue) {
            setState(() {
              if (widget.onSaved != null) {
                widget.onSaved(newValue);
              }
            });
          },
          isExpanded: true,
          elevation: 2,
          style: const TextStyle(color: Colors.black),
        );
      },
    );
  }
}

TextStyle calculateTextStyle(
  BuildContext context,
  TextType textType,
) {
  final _textTheme = Theme.of(context).primaryTextTheme;
  final _inputTheme = Theme.of(context).inputDecorationTheme;
  final _outlinedButtonTheme = Theme.of(context).outlinedButtonTheme;
  final _elevatedButtonTheme = Theme.of(context).elevatedButtonTheme;
  TextStyle _textStyle;
  switch (textType) {
    case TextType.Subtitle1:
      _textStyle = _textTheme.subtitle1;
      break;
    case TextType.Subtitle2:
      _textStyle = _textTheme.subtitle2;
      break;

      break;
    case TextType.Headline1:
      _textStyle = _textTheme.headline1;
      break;
    case TextType.Headline2:
      _textStyle = _textTheme.headline2;
      break;
    case TextType.Headline3:
      _textStyle = _textTheme.headline3;
      break;
    case TextType.Headline4:
      _textStyle = _textTheme.headline4;
      break;
    case TextType.Headline5:
      _textStyle = _textTheme.headline5;
      break;
    case TextType.Headline6:
      _textStyle = _textTheme.headline6;
      break;
    case TextType.Body1:
      _textStyle = _textTheme.bodyText1;

      break;
    case TextType.Body2:
      _textStyle = _textTheme.bodyText2;
      break;
    case TextType.Caption:
      _textStyle = _textTheme.caption;
      break;
    case TextType.ElevatedButton:
      _textStyle = _elevatedButtonTheme.style.textStyle.resolve({
        MaterialState.focused,
      });
      break;

    case TextType.OutlinedButton:
      _textStyle = _outlinedButtonTheme.style.textStyle.resolve({
        MaterialState.focused,
      });
      break;
    case TextType.InputFieldHint:
      _textStyle = _inputTheme.hintStyle;
      break;
    case TextType.InputFieldError:
      _textStyle = _inputTheme.errorStyle;
      break;
    case TextType.InputFieldLabel:
      _textStyle = _inputTheme.labelStyle;
      break;
  }
  return _textStyle;
}
