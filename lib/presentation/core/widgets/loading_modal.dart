import 'package:flutter/material.dart';

import '../helpers/ui_helper.dart';
import 'responsivity/device_detector_widget.dart';
import 'widgets.dart';

class LoadingModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Opacity(
          opacity: 0.3,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
          child: ResponsiveBuilder(
            builder: (context, size) {
              final _verticalUnit = size.blockUnit.height;
              return Container(
                width: _verticalUnit * UIHelper.factor_9,
                height: _verticalUnit * UIHelper.factor_9,
                child: ResponsiveCircularIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
