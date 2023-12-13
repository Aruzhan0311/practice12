import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:flutter_application_1/generated/locale_keys.g.dart';
import 'package:image_picker/image_picker.dart';

class Stories extends StatefulWidget {
  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<Stories> {
  final ImagePicker _picker = ImagePicker();
  List<dynamic> _images = [];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (kIsWeb) {
        Uint8List imageBytes = await image.readAsBytes();
        setState(() {
          _images.add(imageBytes);
        });
      } else {
        setState(() {
          _images.add(image);
        });
      }
    }
  }

  void _viewStory(dynamic image) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return StoryViewScreen(image: image);
    }));
  }

  Widget _buildImageWidget(dynamic image) {
    if (kIsWeb && image is Uint8List) {
      return Image.memory(image);
    } else if (image is XFile) {
      return Image.file(File(image.path));
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Stories.tr()),
        backgroundColor: MYColors.primaryColor, 
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 58, 183, 158), MYColors.blueColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_images.isNotEmpty)
                Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _viewStory(_images[index]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: MemoryImage(_images[index]),
                            backgroundColor: MYColors.secondaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text(LocaleKeys.Add_Photo.tr()),
                style: ElevatedButton.styleFrom(
                  foregroundColor: MYColors.secondaryColor, backgroundColor: MYColors.redColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StoryViewScreen extends StatelessWidget {
  final dynamic image;

  StoryViewScreen({required this.image});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
    });

    return Scaffold(
      body: Center(
        child: (image is Uint8List) ? Image.memory(image) : Image.file(File(image.path)),
      ),
    );
  }
}