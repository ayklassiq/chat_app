import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
 final  void Function (File pickedImage) imagePickFn;

 UserImagePicker(this.imagePickFn);
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  Future<void> _pickImage()async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source:ImageSource.camera,imageQuality: 50, );
    if (pickedImage == null){
      return;
    }
    final pickedImageFile = File(pickedImage.path);

setState(() {
  _pickedImage = pickedImageFile;
});
 widget.imagePickFn(pickedImageFile);

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         CircleAvatar(
          radius: 40,
          backgroundImage:_pickedImage !=null ? FileImage(_pickedImage!): null,
        ),
        TextButton.icon(

          onPressed:_pickImage,
          icon: const Icon(Icons.image),
          label: Text('Add Image',
          style: TextStyle(
    color: Theme.of(context).primaryColor,//for text color
    ),
        ),
    ),
  ]) ;
  }
}
