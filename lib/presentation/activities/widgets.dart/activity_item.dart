import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/helpers/ui_helper.dart';
import '../../core/style/color_palette.dart';
import '../../core/widgets/responsivity/device_detector_widget.dart';
import '../../core/widgets/responsivity/responsive_text.dart';

import '../../../domain/activities/models/activity.dart';
import '../view_activity_page.dart';

class ActivityTile extends StatelessWidget {
  final Activity activity;

  const ActivityTile({
    @required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        final _verticalUnit = size.blockUnit.height;
        final _horizontalUnit = size.blockUnit.width;
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewActivityPage(activity: activity),
              ),
            );
          },
          child: Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: _verticalUnit * 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(activity.image),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: _verticalUnit,
                      right: _horizontalUnit * UIHelper.spaceSmall,
                      child: ResponsiveText(
                        DateFormat.MEd().format(activity.date),
                        color: ColorPalette.white,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Positioned(
                      bottom: _verticalUnit * UIHelper.spaceSmall,
                      left: _horizontalUnit * UIHelper.spaceSmall,
                      child: ResponsiveText(
                        activity.title,
                        color: ColorPalette.white,
                        fontSize: 35,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: _verticalUnit,
                    left: _horizontalUnit,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person),
                      ResponsiveText(
                        activity.owner,
                        color: ColorPalette.primaryColorDark,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: _verticalUnit / UIHelper.spaceSmall,
                    left: _horizontalUnit,
                    bottom: _verticalUnit,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      Expanded(
                        child: ResponsiveText(
                          activity.address,
                          color: ColorPalette.primaryColorDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
