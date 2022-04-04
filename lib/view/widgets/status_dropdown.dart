import 'package:flutter/material.dart';

class StatusDropdown extends StatefulWidget {
  const StatusDropdown({Key? key}) : super(key: key);

  @override
  State<StatusDropdown> createState() => _StatusDropdown();
}

class _StatusDropdown extends State<StatusDropdown> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text("Playing"),
          onTap: () {},
        ),
        PopupMenuItem(
          child: Text("Completed"),
          onTap: () {},
        ),
        PopupMenuItem(
          child: Text("Plan to Play"),
          onTap: () {},
        ),
        // PopupMenuItem(
        //   child: Text("All"),
        //   onTap: () {},
        // ),
      ],
    );
  }
}
