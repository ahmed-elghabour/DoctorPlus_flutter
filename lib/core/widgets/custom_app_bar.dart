import 'package:doctor_plus/core/theming/colors.dart';
import 'package:doctor_plus/core/widgets/appbar_icon.dart';
import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isDefault;
  final List<Widget>? actions;
  const MyCustomAppBar(
      {super.key, required this.title, this.actions, this.isDefault = true});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 28);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: appBarIcon(
          isDefault: isDefault,
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          title,
          style:  TextStyle(
            color:isDefault? ColorsManager.darkBlue:Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        actions: actions,
      ),
    );
  }
}
