import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../application/auth/auth_state.dart';
import '../core/style/color_palette.dart';
import '../../application/activities/activities_page_state.dart';
import '../../config/localizations/app_localizations.dart';
import '../../domain/activities/models/activity.dart';
import 'widgets.dart/activity_item.dart';
import '../core/helpers/ui_helper.dart';
import '../core/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../core/widgets/responsivity/device_detector_widget.dart';
import '../core/widgets/responsivity/responsive_text.dart';

class ActivitiesPage extends StatelessWidget {
  ActivitiesPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _i18n = AppLocalizations.of(context);
    return ResponsiveBuilder(builder: (context, size) {
      final _verticalUnit = size.blockUnit.height;
      final _horizontalUnit = size.blockUnit.width;
      const _hello = "activities.pages.activities.labels.title";
      const _loading = "activities.pages.activities.labels.loading";
      return FutureBuilder<ActivityPageState>(
          future: GetIt.I.getAsync<ActivityPageState>(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: ResponsiveCircularIndicator(),
              );
            }
            return ChangeNotifierProvider<ActivityPageState>.value(
              value: snapshot.data,
              builder: (context, child) {
                return Consumer<ActivityPageState>(
                  builder: (context, state, widget) {
                    return Scaffold(
                      appBar: AppBar(
                        title: FutureBuilder<AuthState>(
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
                                    if (state.userLogged == null) {
                                      return Container();
                                    }
                                    final _name =
                                        " ${state.userLogged.username}!";
                                    return ResponsiveText(
                                      _i18n.translate(
                                            _hello,
                                          ) +
                                          _name,
                                      textType: TextType.Headline4,
                                      fontSize: 28,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        actions: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: _horizontalUnit * 5),
                            child: ResponsiveIconButton(
                              icon: Icons.add,
                              sizePercent: 4,
                              color: ColorPalette.white,
                              onPressed: () {
                                Navigator.pushNamed(context, "/new_activity");
                              },
                            ),
                          )
                        ],
                      ),
                      body: StreamBuilder<List<Activity>>(
                        stream: state.activitiesStream,
                        builder: (context, snap) {
                          if (!snap.hasData) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ResponsiveCircularIndicator(),
                                  SizedBox(
                                    height: _verticalUnit * 2,
                                  ),
                                  ResponsiveText(
                                    _i18n.translate(_loading),
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: snap.data.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    _horizontalUnit * UIHelper.spaceSmall,
                                vertical: _verticalUnit,
                              ),
                              child: ActivityTile(
                                activity: snap.data[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          });
    });
  }
}
