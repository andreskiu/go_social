import 'package:flutter/material.dart';
import '../../../config/localizations/app_localizations.dart';
import '../../../domain/activities/activities_objects/activities_fields.dart';
import '../../../domain/activities/failures/activities_failures.dart';
import '../../core/widgets/responsivity/responsive_text.dart';

class ActivityDescriptionFormField extends StatefulWidget {
  const ActivityDescriptionFormField({
    Key key,
    this.onSaved,
    this.initialValue,
  });

  @override
  _ActivityDescriptionFormFieldState createState() =>
      _ActivityDescriptionFormFieldState();

  final void Function(String) onSaved;
  final String initialValue;
}

class _ActivityDescriptionFormFieldState
    extends State<ActivityDescriptionFormField> with ActivitiesFailureManager {
  @override
  Widget build(BuildContext context) {
    final _i18n = AppLocalizations.of(context);
    return ResponsiveInput(
      labelText: _i18n.translate("activities.fields.description.label"),
      hintText: _i18n.translate("activities.fields.description.label"),
      initialValue: widget.initialValue,
      validator: (description) {
        final error = FieldActivityDescription(description).getError();

        if (error != null) {
          final _msg = getActivityErrorContent(error);
          return _msg.mustBeTranslated
              ? _i18n.translate(_msg.message)
              : _msg.message;
        }
        return null;
      },
      onSaved: widget.onSaved,
    );
  }
}
