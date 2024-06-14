import 'package:doctor_plus/presentation/widgets/drop_down.dart';
import 'package:flutter/material.dart';

Widget additionalInfo({
  required String title,
  required String value,
  required List<String> list,
  required void Function(String?)? onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text("$title: "),
        ),
        Expanded(
          flex: 2,
          child: CustomDropDownMenu(
            list: list,
            value: value,
            onChanged: onChanged,
          ),
        )
      ],
    ),
  );
}

Widget customAdditionaInfo({
  required String title,
  required String value,
  required List<String> list,
  required List<String> selectedlist,
  required void Function(String?)? onChanged,
  required void Function(String?) onRemove,
}) {
  return Column(
    children: <Widget>[
      additionalInfo(
        title: title,
        value: value,
        list: list,
        onChanged: onChanged,
      ),
      selectedlist.isEmpty
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Wrap(
                children: selectedlist
                    .map((val) => Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 4,
                            end: 8.0,
                            bottom: 4.0,
                          ),
                          child: InkWell(
                            onTap: () => onRemove(val),
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Text(val)),
                          ),
                        ))
                    .toList(),
              ),
            )
    ],
  );
}
