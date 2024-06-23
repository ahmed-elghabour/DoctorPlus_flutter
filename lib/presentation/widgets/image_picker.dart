import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final IconData icon;
  final Color frameColor;
  final double imageSize;
  final String imagePath;
  const CustomImagePicker({
    super.key,
    this.icon = Icons.add,
    this.imageSize = 60,
    this.frameColor = Colors.black,
    this.imagePath = 'assets/profile.png',
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

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
            backgroundImage: _image != null
                ? FileImage(_image!)
                : AssetImage(widget.imagePath) as ImageProvider,
          ),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: GestureDetector(
            onTap: _pickImage,
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
