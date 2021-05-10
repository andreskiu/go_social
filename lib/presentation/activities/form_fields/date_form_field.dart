import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../config/localizations/app_localizations.dart';
import '../../../domain/activities/activities_objects/activities_fields.dart';
import '../../../domain/activities/failures/activities_failures.dart';
import '../../core/widgets/responsivity/responsive_text.dart';

class DatetimeFormField<DateTime> extends StatefulWidget {
  final DateTime initialValue;
  final DateTime firstDate;
  final DateTime lastDate;
  final String labelText;
  final bool mandatory;
  final void Function(DateTime) onSaved;
  final void Function(DateTime) onChanged;
  final DateFormat dateFormat;
  const DatetimeFormField({
    Key key,
    this.initialValue,
    @required this.firstDate,
    @required this.lastDate,
    this.mandatory = false,
    this.labelText = '',
    this.onChanged,
    this.onSaved,
    this.dateFormat,
  }) : super(key: key);

  @override
  _DatetimeFormFieldState createState() => _DatetimeFormFieldState();
}

class _DatetimeFormFieldState extends State<DatetimeFormField>
    with ActivitiesFailureManager {
  TextEditingController _controller;
  DateTime _dateTime;
  DateFormat _dateFormat;
  @override
  void initState() {
    super.initState();
    _dateTime = widget.initialValue ?? DateTime.now();
    _dateFormat = widget.dateFormat ?? DateFormat.MMMMd().add_y();
    _controller = TextEditingController();
    _controller.text = _dateTime == null ? "" : _dateFormat.format(_dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final _i18n = AppLocalizations.of(context);
    return ResponsiveInput(
      controller: _controller,
      labelText: widget.labelText,
      readOnly: true,
      suffixIconData: _dateTime == null ? null : Icons.cancel_outlined,
      onIconPressed: () => setState(() {
        _dateTime = null;
      }),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: widget.firstDate,
          fieldHintText: widget.labelText,
          fieldLabelText: widget.labelText,
          initialDate: _dateTime != null && _dateTime.isAfter(widget.firstDate)
              ? _dateTime
              : DateTime.now(),
          lastDate: widget.lastDate,
          selectableDayPredicate: (day) {
            return true;
          },
        );
        if (date != null) {
          setState(() {
            final time = TimeOfDay(hour: 0, minute: 0);
            _dateTime = DateTimeField.combine(date, time);
            _controller.text = _dateFormat.format(_dateTime);
          });
        }
        if (_dateTime == null) {
          _controller.clear();
        }
      },
      validator: (_) {
        final error = FieldActivityDate(_dateTime).getError();

        if (error != null) {
          final _msg = getActivityErrorContent(error);
          return _msg.mustBeTranslated
              ? _i18n.translate(_msg.message)
              : _msg.message;
        }
        return null;
      },
      onChanged: (_) {
        setState(() {
          if (widget.onChanged != null) {
            widget.onChanged(_dateTime);
          }
        });
      },
      onSaved: (_) {
        setState(() {
          if (widget.onSaved != null) {
            widget.onSaved(_dateTime);
          }
        });
      },
    );
  }
}
