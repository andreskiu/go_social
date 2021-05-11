import 'package:flutter/material.dart';
import '../../application/activities/activity_form_state.dart';
import '../../config/localizations/app_localizations.dart';
import '../../domain/activities/activities_objects/activities_fields.dart';
import '../core/widgets/widgets.dart';
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
        const _new_activity =
            "activities.pages.activity_view.labels.new_activity";
        const _edit_activity =
            "activities.pages.activity_view.labels.edit_activity";
        const _base_translation = "activities.pages.activity_form";
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
                      state.initialActivity != null
                          ? _i18n.translate(_edit_activity)
                          : _i18n.translate(_new_activity),
                      textType: TextType.Headline4,
                      fontSize: 28,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: _verticalUnit * 2),
                            ResponsiveText(
                              _i18n.translate(
                                _base_translation + ".labels.what",
                              ),
                            ),
                            SizedBox(height: _verticalUnit * 2),
                            ActivityTitleFormField(
                              initialValue: state.initialActivity?.title,
                              onSaved: (title) {
                                state.fieldTitle = FieldActivityTitle(title);
                              },
                            ),
                            SizedBox(height: _verticalUnit * 2),
                            ResponsiveText(
                              _i18n.translate(
                                _base_translation + ".labels.description",
                              ),
                            ),
                            SizedBox(height: _verticalUnit * 2),
                            ActivityDescriptionFormField(
                              initialValue: state.initialActivity?.description,
                              onSaved: (description) {
                                state.fieldDescription =
                                    FieldActivityDescription(description);
                              },
                            ),
                            SizedBox(height: _verticalUnit * 2),
                            ResponsiveText(
                              _i18n.translate(
                                _base_translation + ".labels.where",
                              ),
                            ),
                            SizedBox(height: _verticalUnit * 2),
                            ActivityAddressFormField(
                              initialValue: state.initialActivity?.address,
                              onSaved: (address) {
                                state.fieldAddress =
                                    FieldActivityAddress(address);
                              },
                            ),
                            SizedBox(height: _verticalUnit * 2),
                            ResponsiveText(
                              _i18n.translate(
                                _base_translation + ".labels.when",
                              ),
                            ),
                            SizedBox(height: _verticalUnit * 2),
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
                            SizedBox(height: _verticalUnit * 2),
                            Center(
                              child: state.isLoading
                                  ? ResponsiveCircularIndicator()
                                  : Container(
                                      width: _horizontalUnit * 50,
                                      child: AppButton(
                                        textContent: _i18n.translate(
                                          _base_translation +
                                              ".buttons.save.label",
                                        ),
                                        onPressed: () async {
                                          if (_saveActivityForm.currentState
                                              .validate()) {
                                            _saveActivityForm.currentState
                                                .save();
                                            final _success =
                                                await state.submitForm();
                                            if (_success) {
                                              Navigator.of(context).pop();
                                            }
                                          }
                                        },
                                      ),
                                    ),
                            )
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
