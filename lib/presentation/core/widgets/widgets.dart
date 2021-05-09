import 'package:flutter/material.dart';

import '../style/color_palette.dart';
import 'responsivity/device_detector_widget.dart';
import 'responsivity/responsive_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    @required this.textContent,
    @required this.onPressed,
  });

  final String textContent;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: ResponsiveText(
          textContent,
          textType: TextType.ElevatedButton,
        ),
      ),
    );
  }
}

class ResponsiveCircularIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        final _verticalUnit = size.blockUnit.height;
        return CircularProgressIndicator(
          strokeWidth: _verticalUnit / 2,
        );
      },
    );
  }
}

class ResponsiveDivider extends StatelessWidget {
  final double indentPercent;
  final double endIndentPercent;

  const ResponsiveDivider({
    this.indentPercent = 0,
    this.endIndentPercent = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        final _verticalUnit = size.blockUnit.height;
        final _horizontalUnit = size.blockUnit.width;
        return Divider(
          color: Theme.of(context).primaryColorDark,
          endIndent: _horizontalUnit * endIndentPercent,
          indent: _horizontalUnit * indentPercent,
          thickness: _verticalUnit / 8,
        );
      },
    );
  }
}

class ResponsiveIconButton extends StatelessWidget {
  final double sizePercent;
  final Function() onPressed;
  final IconData icon;

  const ResponsiveIconButton({
    @required this.icon,
    this.sizePercent = 2,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizeInfo) {
        final _verticalUnit = sizeInfo.blockUnit.height;
        return IconButton(
          icon: Icon(
            icon,
            size: _verticalUnit * sizePercent,
            color: ColorPalette.greyDarkIcon,
          ),
          constraints: BoxConstraints.tightFor(
            width: _verticalUnit * sizePercent,
            height: _verticalUnit * sizePercent,
          ),
          splashRadius: _verticalUnit * sizePercent,
          padding: EdgeInsets.zero,
          onPressed: onPressed,
        );
      },
    );
  }
}
