import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/widgets/widgets.dart';
import '../../domain/activities/models/activity.dart';
import '../core/widgets/responsivity/device_detector_widget.dart';
import '../core/widgets/responsivity/responsive_text.dart';
import 'new_activity_page.dart';

class ViewActivityPage extends StatelessWidget {
  final Activity activity;

  const ViewActivityPage({
    this.activity,
  });
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        return Scaffold(
          appBar: AppBar(
            title: ResponsiveText("view"),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: ResponsiveIconButton(
                  icon: Icons.edit,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewActivityPage(activity: activity),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
