import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  final String? label;
  final String value;
  final List<String> list;
  final void Function(String?)? onChanged;
  const CustomDropDownMenu({
    super.key,
    required this.list,
    this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
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
                alignment: Alignment.center,
                onChanged: widget.onChanged,
                borderRadius: BorderRadius.circular(18),
                items: widget.list.map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Center(
                        child: Text(
                      val,
                      textAlign: TextAlign.center,
                    )),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        Positioned.fill(
            top: -9,
            left: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    color: Colors.white,
                    child: Text(
                      widget.label ?? "Sdds",
                      style: const TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w400),
                    )),
              ),
            )),
      ],
    );
  }
}
