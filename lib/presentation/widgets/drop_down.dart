import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  final String value;
  final List<String> list;
  final void Function(String?)? onChanged;
  const CustomDropDownMenu({
    super.key,
    required this.list,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: widget.value,
            isExpanded: true,
            onChanged: widget.onChanged,
            items: widget.list.map<DropdownMenuItem<String>>((String val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Center(child: Text(val)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
