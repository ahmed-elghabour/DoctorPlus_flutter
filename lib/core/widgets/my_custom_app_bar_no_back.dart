import 'package:flutter/material.dart';
import 'package:doctor_plus/core/theming/colors.dart';

class MyCustomAppBarNoBack extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const MyCustomAppBarNoBack({super.key, required this.title, this.actions});
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 28);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            color: ColorsManager.darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        actions: actions,
      ),
    );
  }
}
