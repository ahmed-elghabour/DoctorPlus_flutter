import 'package:doctor_plus/core/theming/colors.dart';
import 'package:flutter/material.dart';

Widget appBarIcon({
  bool isDefault = true,
  double iconSize = 24.0,
  required IconData icon,
  required void Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 48.0,
      height: 48.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: isDefault
            ? Border.all(
                color: ColorsManager.lightGray,
                width: .5,
                style: BorderStyle.solid,
              )
            : null,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: isDefault ? ColorsManager.darkBlue : Colors.white,
      ),
    ),
  );
}
