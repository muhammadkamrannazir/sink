import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  static const _YEAR = 365;

  const DatePicker({Key key, this.labelText, this.selectedDate, this.onChanged})
      : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: _YEAR * 10)),
      lastDate: DateTime.now().add(Duration(days: _YEAR * 10)),
    );

    if (picked != null && picked != selectedDate) {
      onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
            child: InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.today),
                            ),
                            Text(
                              DateFormat.yMMMMEEEEd().format(selectedDate),
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )))
      ],
    );
  }
}
