import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:flutter_application_1/generated/locale_keys.g.dart';
import 'package:flutter_application_1/trasnlationbut.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email = '';
  String name = '';
  String age = '';
  Uint8List? profileImageBytes;

  @override
  void initState() {
    super.initState();
    loadUserData();
    loadProfileImage();
  }

  loadUserData() async {
    auth.User? currentUser = auth.FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
      setState(() {
        email = userDoc.get('email') ?? '';
        name = userDoc.get('name') ?? '';
        age = userDoc.get('age') ?? '';
      });
    }
  }

   loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedImage = prefs.getString('profile_image');
    if (storedImage != null) {
      setState(() {
        profileImageBytes = base64Decode(storedImage);
      });
    }
  }

   Future<void> pickProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', base64Image);

      setState(() {
        profileImageBytes = imageBytes;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.User_profile.tr()),
        backgroundColor: MYColors.primaryColor,
        actions: [
            TranslationButton(),
          ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: pickProfileImage,
                child:CircleAvatar(
                radius: 60,
                 backgroundImage: profileImageBytes != null
                 ? MemoryImage(profileImageBytes!) as ImageProvider
                : const AssetImage('assets/image/profile_picture.png') as ImageProvider,
                 backgroundColor: MYColors.secondaryColor,
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(LocaleKeys.Name.tr()),
                        subtitle: Text(name),
                        leading: Icon(Icons.person, color: MYColors.primaryColor),
                      ),
                      ListTile(
                        title: Text(LocaleKeys.Age.tr()),
                        subtitle: Text(age),
                        leading: Icon(Icons.person, color: MYColors.primaryColor),
                      ),
                      ListTile(
                        title: Text(LocaleKeys.Email.tr()),
                        subtitle: Text(email),
                        leading: Icon(Icons.email, color: MYColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.edit),
                label: Text(LocaleKeys.Edit_profile.tr()),
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              ),
              TextButton.icon(
                icon: Icon(Icons.logout),
                label: Text(LocaleKeys.Exit.tr()),
                onPressed: () {
                },
                style: TextButton.styleFrom(foregroundColor: MYColors.redColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}