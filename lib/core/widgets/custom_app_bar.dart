import 'package:doctor_plus/core/theming/colors.dart';
import 'package:doctor_plus/core/widgets/appbar_icon.dart';
import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final bool isDefault;
  final bool removeLeading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  const MyCustomAppBar({
    super.key,
    this.bottom,
    this.actions,
    this.height = 28,
    required this.title,
    this.isDefault = true,
    this.removeLeading = false,
  });
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + height);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 48,
        bottom: bottom,
        leading: removeLeading
            ? const SizedBox()
            : appBarIcon(
                isDefault: isDefault,
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () => Navigator.pop(context),
              ),
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: isDefault ? ColorsManager.darkBlue : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        actions: actions,
      ),
    );
  }
}
