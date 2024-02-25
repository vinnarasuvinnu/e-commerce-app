import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';

class TopChip extends StatefulWidget {
  final String title;
  final int id;
  final int currentId;

  const TopChip(
      {Key? key,
      required this.title,
      required this.id,
      required this.currentId})
      : super(key: key);

  @override
  State<TopChip> createState() => _TopChipState();
}

class _TopChipState extends State<TopChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.id == widget.currentId ? Fins.finsColor : Colors.white,
          border: Border.all(color: Fins.finsColor, width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.title,
          style: TextStyle(
            color:
                widget.id != widget.currentId ? Fins.finsColor : Colors.white,
          ),
        ),
      ),
    );
  }
}
