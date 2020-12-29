import 'package:flutter/material.dart';

class SortTeamDialog extends StatefulWidget {
  final int sortMethod;
  final bool ascending;

  const SortTeamDialog(
      {Key key, @required this.sortMethod, @required this.ascending})
      : super(key: key);

  @override
  _SortTeamDialogState createState() => _SortTeamDialogState();
}

class _SortTeamDialogState extends State<SortTeamDialog> {
  int _sortMethod;
  bool _ascending;

  @override
  Widget build(BuildContext context) {
    TextStyle subtitleStyle = Theme.of(context).textTheme.subtitle2;

    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: DropdownButton(
            value: _sortMethod,
            hint: Text("Sort Method"),
            items: [
              DropdownMenuItem(
                value: 0,
                child: Text("Team Number", style: subtitleStyle),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text("Team OPR", style: subtitleStyle),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("Team Elo", style: subtitleStyle),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text("Average Low Scored", style: subtitleStyle),
              ),
              DropdownMenuItem(
                value: 4,
                child: Text("Average Outer Scored", style: subtitleStyle),
              ),
              DropdownMenuItem(
                value: 5,
                child: Text("Average Inner scored", style: subtitleStyle),
              ),
              DropdownMenuItem(
                value: 6,
                child: Text("Average Penalites", style: subtitleStyle),
              ),
              DropdownMenuItem(
                value: 7,
                child: Text("Hanging Percentage", style: subtitleStyle),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _sortMethod = value;
                if (value == 0 || value == 6) {
                  _ascending = true;
                } else {
                  _ascending = false;
                }
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              RaisedButton(
                child: Text("Sort"),
                onPressed: () => Navigator.pop(context,
                    {"sortMethod": _sortMethod, "ascending": _ascending}),
              ),
            ],
          ),
        )
      ],
    );
  }
}
