import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreenImage extends StatelessWidget {
  final File imageFile;

  const FullScreenImage({Key? key, required this.imageFile}) : super(key: key);

  Future<void> _saveImageToGallery() async {
    try {
      final result = await ImageGallerySaver.saveFile(imageFile.path);
      if (result['isSuccess']) {
        Fluttertoast.showToast(msg: 'Image saved to gallery');
      } else {
        Fluttertoast.showToast(msg: 'Failed to save image');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to save image');
    }
  }

  Future<void> _setAsWallpaper() async {
    try {
      final result = await WallpaperManager.setWallpaperFromFile(imageFile.path, WallpaperManager.HOME_SCREEN);
      if (result) {
        Fluttertoast.showToast(msg: 'Wallpaper set successfully');
      } else {
        Fluttertoast.showToast(msg: 'Failed to set wallpaper');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to set wallpaper');
    }
  }



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.save),
                    title: Text('Save to Gallery'),
                    onTap: _saveImageToGallery,
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.wallpaper),
                    title: Text('Set as Wallpaper'),
                    onTap: _setAsWallpaper,
                  ),
                ),
                
               
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Image.file(
          imageFile,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
