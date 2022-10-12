import 'package:flutter/material.dart';

class TagItemView extends StatelessWidget {
  const TagItemView({
    Key? key,
    required this.tagname,
    required this.tagvalue,
  }) : super(key: key);

  final String tagname;
  final String tagvalue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
      child: ListTile(
        tileColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          child: Text(
            tagname,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        subtitle: Text(
          tagvalue,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13.4),
        ),
      ),
    );
  }
}