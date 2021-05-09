import 'package:flutter/material.dart';
import '../../../config/localizations/app_localizations.dart';
import '../../../domain/activities/activities_objects/activities_fields.dart';
import '../../../domain/activities/failures/activities_failures.dart';
import '../../core/widgets/responsivity/responsive_text.dart';

class ActivityAddressFormField extends StatefulWidget {
  const ActivityAddressFormField({
    Key key,
    this.onSaved,
    this.initialValue,
  });

  @override
  _ActivityAddressFormFieldState createState() =>
      _ActivityAddressFormFieldState();

  final void Function(String) onSaved;
  final String initialValue;
}

class _ActivityAddressFormFieldState extends State<ActivityAddressFormField>
    with ActivitiesFailureManager {
  @override
  Widget build(BuildContext context) {
    final _i18n = AppLocalizations.of(context);
    return ResponsiveInput(
      labelText: _i18n.translate("activities.fields.address.label"),
      hintText: _i18n.translate("activities.fields.address.label"),
      initialValue: widget.initialValue,
      validator: (address) {
        final error = FieldActivityAddress(address).getError();

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
