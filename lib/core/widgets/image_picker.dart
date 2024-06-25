import 'dart:io';
import 'package:flutter/material.dart';

class CustomImagePicker extends StatefulWidget {
  final File? image;
  final IconData icon;
  final Color frameColor;
  final double imageSize;
  final String imagePath;
  final void Function()? onFileSelected;
  const CustomImagePicker({
    super.key,
    this.image,
    this.imageSize = 60,
    this.onFileSelected,
    this.icon = Icons.add,
    this.frameColor = Colors.black,
    this.imagePath = 'assets/profile.png',
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: widget.imageSize + 5,
          backgroundColor: widget.frameColor,
          child: CircleAvatar(
            radius: widget.imageSize,
            backgroundColor: Colors.transparent,
            backgroundImage: widget.image != null
                ? FileImage(widget.image!)
                : AssetImage(widget.imagePath) as ImageProvider,
          ),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: GestureDetector(
            onTap: widget.onFileSelected,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
