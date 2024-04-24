import 'dart:io';
import 'package:camerapp/editimagescreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(CameraApp());

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraHomePage(),
    );
  }
}

class CameraHomePage extends StatefulWidget {
  @override
  _CameraHomePageState createState() => _CameraHomePageState();
}

class _CameraHomePageState extends State<CameraHomePage> {
  List<File> _images = [];

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _editImage(int index) {
    // Implement editing functionality as needed
    // For example, you can navigate to a new screen to edit the image
  }

  void _viewImageFullScreen(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageFile: _images[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera App'),
      ),
      body: _images.isEmpty
          ? Center(
              child: Text('No Images Yet'),
            )
          : ListView.builder(
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => _viewImageFullScreen(index),
                  leading: GestureDetector(
                    onTap: () => _viewImageFullScreen(index),
                    child: Image.file(
                      _images[index],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text('Image ${index + 1}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteImage(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editImage(index),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        tooltip: 'Take Picture',
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}





