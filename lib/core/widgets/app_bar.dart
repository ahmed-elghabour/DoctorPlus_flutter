import 'package:flutter/material.dart';
import 'package:doctor_plus/core/theming/colors.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? tailIcon;
  const CustomAppBar({super.key, required this.title, this.tailIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Row(
        children: [
          Container(
            width: 48.0,
            height: 48.0,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorsManager.lightGray,
                width: .5,
                style: BorderStyle.solid,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: SvgPicture.asset(
              tailIcon ?? 'assets/svgs/back.svg',
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: ColorsManager.darkBlue,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const Spacer(),
          Container(
            width: 48.0,
            height: 48.0,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorsManager.lightGray,
                width: .5,
                style: BorderStyle.solid,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: SvgPicture.asset(
              tailIcon ?? 'assets/svgs/search.svg',
              width: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
