import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../application/auth/auth_state.dart';
import '../../config/localizations/app_localizations.dart';
import 'package:provider/provider.dart';
import '../core/helpers/ui_helper.dart';
import '../core/style/color_palette.dart';
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
        final _verticalUnit = size.blockUnit.height;
        final _horizontalUnit = size.blockUnit.width;

        final _horizontalItemPadding =
            _horizontalUnit * UIHelper.spaceSemiMedium;
        final _verticalItemPadding = _verticalUnit * UIHelper.spaceSmall;
        final _i18n = AppLocalizations.of(context);
        const _invitedBy = "activities.pages.activity_view.labels.invited_by";
        return Scaffold(
          appBar: AppBar(
            title: ResponsiveText(
              activity.title,
              fontSize: 30,
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: _horizontalUnit * UIHelper.spaceSmall,
                ),
                child: FutureBuilder<AuthState>(
                  future: GetIt.I.getAsync<AuthState>(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return SizedBox.shrink();
                    }
                    return ChangeNotifierProvider<AuthState>.value(
                      value: snapshot.data,
                      builder: (context, child) {
                        return Consumer<AuthState>(
                          builder: (context, state, child) {
                            return state.userLogged == null ||
                                    state.userLogged.username != activity.owner
                                ? Container()
                                : ResponsiveIconButton(
                                    icon: Icons.edit,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewActivityPage(
                                              activity: activity),
                                        ),
                                      );
                                    },
                                  );
                          },
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Padding(
                  padding: EdgeInsets.only(
                    right: _horizontalItemPadding,
                    left: _horizontalItemPadding,
                    top: _verticalItemPadding,
                  ),
                  child: Center(
                    child: ResponsiveText(
                      activity.title,
                      fontSize: 35,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: _horizontalItemPadding,
                    left: _horizontalItemPadding,
                    top: _verticalItemPadding,
                  ),
                  child: ResponsiveText(
                    activity.description,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: _horizontalItemPadding,
                    left: _horizontalItemPadding,
                    top: _verticalItemPadding,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: _verticalUnit * UIHelper.spaceSemiMedium,
                      ),
                      SizedBox(
                        width: _horizontalUnit,
                      ),
                      Expanded(
                        child: ResponsiveText(
                          DateFormat.MMMMEEEEd().format(activity.date),
                          color: ColorPalette.primaryColorDark,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: _horizontalItemPadding,
                    left: _horizontalItemPadding,
                    top: _verticalItemPadding,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: _verticalUnit * UIHelper.spaceSemiMedium,
                      ),
                      SizedBox(
                        width: _horizontalUnit,
                      ),
                      Expanded(
                        child: ResponsiveText(
                          activity.address,
                          color: ColorPalette.primaryColorDark,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: _horizontalItemPadding,
                    left: _horizontalItemPadding,
                    top: _verticalItemPadding,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: _verticalUnit * UIHelper.spaceSemiMedium,
                      ),
                      SizedBox(
                        width: _horizontalUnit,
                      ),
                      Expanded(
                        child: ResponsiveText(
                          _i18n.translate(_invitedBy) + "${activity.owner}",
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
