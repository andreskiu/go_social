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
          child: ListTile(
            contentPadding: EdgeInsets.only(
              left: _horizontalUnit * UIHelper.spaceSemiMedium,
            ),
            title: Row(
              children: [
                Expanded(
                  child: ResponsiveText(
                    activity.title,
                    fontSize: 30,
                  ),
                ),
                ResponsiveText(
                  DateFormat.MEd().format(activity.date),
                  color: ColorPalette.primaryColorDark,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: _verticalUnit * 2),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.person),
                      ResponsiveText(
                        activity.owner,
                        color: ColorPalette.primaryColorDark,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      Expanded(
                        child: ResponsiveText(
                          activity.address,
                          color: ColorPalette.primaryColorDark,
                          // maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
