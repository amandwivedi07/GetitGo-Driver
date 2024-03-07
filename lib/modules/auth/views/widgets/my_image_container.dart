import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CustomImageContainer extends StatefulWidget {
  final double width;
  final double height;
  final bool hasImage;
  final String imagePath;
  final Function(XFile) onImagePicked;

  const CustomImageContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.hasImage,
    this.imagePath = "",
    required this.onImagePicked,
  }) : super(key: key);

  @override
  State<CustomImageContainer> createState() => _CustomImageContainerState();
}

class _CustomImageContainerState extends State<CustomImageContainer> {
  final ImagePicker _picker = ImagePicker();
  late String _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = "";
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        setState(() {
          _imagePath = pickedImage.path;
        });
        widget.onImagePicked(pickedImage);
      }
    } catch (e) {
      print("Error picking image: $e");
      // Handle the error gracefully, e.g., display an error message to the user.
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!widget.hasImage) {
          _pickImage();
        } else {
          _pickImage();
        }
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.hasImage ? Colors.white : Colors.grey,
          borderRadius: BorderRadius.circular(20), // Set border radius to 20
          border: Border.all(
            color: Colors.grey.shade100, // Set border color
            width: 1, // Set border width
            style: BorderStyle.solid, // Set border style to solid
          ),
        ),
        child: widget.hasImage
            ? Image.file(
                File(widget.imagePath),
                fit: BoxFit.cover,
              )
            : const Icon(
                Icons.camera_alt_sharp,
                color: Colors.white,
                size: 50,
              ),
      ),
    );
  }
}
