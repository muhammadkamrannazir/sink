import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sink/common/input_formatter.dart';
import 'package:sink/models/entry.dart';

class EntryForm extends StatefulWidget {
  final Function(Entry) onSave;
  final Entry entry;

  EntryForm({required this.onSave, required this.entry});

  @override
  State<StatefulWidget> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  late double amount;
  late DateTime date;
  late String categoryId;
  late EntryType type;

  @override
  void initState() {
    super.initState();
    amount = widget.entry.amount;
    date = widget.entry.date;
    categoryId = widget.entry.categoryId;
    type = widget.entry.type;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Your form widgets go here
          // For example:
          TextFormField(
            initialValue: amount.toString(),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [DecimalInputFormatter()],
            onChanged: (value) => setState(() {
              amount = double.tryParse(value) ?? 0.0;
            }),
          ),
          // Other form fields...
          ElevatedButton(
            onPressed: () {
              final editedEntry = Entry(
                amount: amount,
                date: date,
                categoryId: categoryId,
                type: type,
                id: widget.entry.id,
              );
              widget.onSave(editedEntry);
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
