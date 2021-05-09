import 'package:flutter/material.dart';
import 'package:lyrics_app/application/activities/activity_form_state.dart';
import 'package:lyrics_app/config/localizations/app_localizations.dart';
import 'package:lyrics_app/domain/activities/activities_objects/activities_fields.dart';
import 'package:lyrics_app/presentation/core/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../domain/activities/models/activity.dart';
import '../core/widgets/responsivity/device_detector_widget.dart';
import '../core/widgets/responsivity/responsive_text.dart';
import 'form_fields/address_form_field.dart';
import 'form_fields/date_form_field.dart';
import 'form_fields/description_form_field.dart';
import 'form_fields/title_form_field.dart';

class NewActivityPage extends StatelessWidget {
  final Activity activity;

  NewActivityPage({
    this.activity,
  });

  final GlobalKey<FormState> _saveActivityForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _i18n = AppLocalizations.of(context);
    return ResponsiveBuilder(
      builder: (context, size) {
        final _horizontalUnit = size.blockUnit.width;
        final _verticalUnit = size.blockUnit.height;
        final _today = DateTime.now();
        return ChangeNotifierProvider<ActivityFormState>(
          create: (context) {
            return ActivityFormState(initialActivity: activity);
          },
          builder: (context, snapshot) {
            return Consumer<ActivityFormState>(
              builder: (context, state, child) {
                return Scaffold(
                  appBar: AppBar(
                    title: ResponsiveText(
                      state.initialActivity?.title ?? "New Activity",
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: _horizontalUnit * 5,
                        vertical: _verticalUnit,
                      ),
                      child: Form(
                        key: _saveActivityForm,
                        child: Column(
                          children: [
                            ActivityTitleFormField(
                              initialValue: state.initialActivity?.title,
                              onSaved: (title) {
                                state.fieldTitle = FieldActivityTitle(title);
                              },
                            ),
                            ActivityAddressFormField(
                              initialValue: state.initialActivity?.address,
                              onSaved: (address) {
                                state.fieldAddress =
                                    FieldActivityAddress(address);
                              },
                            ),
                            ActivityDescriptionFormField(
                              initialValue: state.initialActivity?.description,
                              onSaved: (description) {
                                state.fieldDescription =
                                    FieldActivityDescription(description);
                              },
                            ),
                            DatetimeFormField(
                              initialValue: state.initialActivity?.date,
                              onSaved: (date) {
                                state.fieldDate = FieldActivityDate(date);
                              },
                              labelText: _i18n
                                  .translate("activities.fields.date.label"),
                              firstDate: _today,
                              lastDate: _today.add(Duration(days: 365)),
                            ),
                            AppButton(
                                textContent: "Save",
                                onPressed: () async {
                                  if (_saveActivityForm.currentState
                                      .validate()) {
                                    _saveActivityForm.currentState.save();
                                    final _success = await state.submitForm();
                                    if (_success) {
                                      Navigator.of(context).pop();
                                    }
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
