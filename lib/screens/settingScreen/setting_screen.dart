import 'dart:io';
import 'package:dummy_project/database/databaseMethod.dart';
import 'package:dummy_project/database/userLocalData.dart';
import 'package:dummy_project/models/app_user.dart';
import 'package:dummy_project/screens/widgets/circularProfileImage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/SeetingScreen';
  SettingScreen({Key key}) : super(key: key);
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String name, phone;
  PickedFile _image;
  File file;

  void _onChangeName(String newName) {
    name = newName;
  }

  void _onChangePhoneNumber(String newPhone) {
    phone = newPhone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Change Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('You can change your Name'),
              onTap: () {
                _changeName(context);
              },
            ),
            ListTile(
              title: Text(
                'Change Phone Number',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('You can change your phone number'),
              onTap: () {
                _changePhoneNumber(context);
              },
            ),
            ListTile(
              title: Text(
                'Change Profile Image',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('You can change your profile '),
              onTap: () {
                // _showPicker(context);
                _changeProfileImage(context);
              },
            ),
            ListTile(
              title: Text(
                'About Us',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('See details about this app'),
              onTap: () {
                showAboutDialog(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _changeName(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 80,
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              initialValue: UserLocalData.getUserDisplayName(),
              onChanged: (value) {
                _onChangeName(value);
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Back'),
            ),
            ElevatedButton(
              onPressed: () async {
                AppUser appUser = AppUser(
                  uid: UserLocalData.getUserUID(),
                  displayName: name,
                  email: UserLocalData.getUserEmail(),
                  phoneNumber: UserLocalData.getUserPhoneNumber(),
                  imageURL: UserLocalData.getUserImageUrl(),
                  interest: UserLocalData.getUserInterest(),
                );
                await DatabaseMethods().updateUserDoc(
                    uid: UserLocalData.getUserUID(), userMap: appUser.toMap());
                UserLocalData.setUserDisplayName(name);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _changePhoneNumber(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 80,
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              initialValue: UserLocalData.getUserPhoneNumber(),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                _onChangePhoneNumber(value);
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Back'),
            ),
            ElevatedButton(
              onPressed: () async {
                AppUser appUser = AppUser(
                  uid: UserLocalData.getUserUID(),
                  displayName: UserLocalData.getUserDisplayName(),
                  email: UserLocalData.getUserEmail(),
                  phoneNumber: phone,
                  imageURL: UserLocalData.getUserImageUrl(),
                  interest: UserLocalData.getUserInterest(),
                );
                await DatabaseMethods().updateUserDoc(
                    uid: UserLocalData.getUserUID(), userMap: appUser.toMap());
                UserLocalData.setUserPhoneNumber(phone);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _changeProfileImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularProfileImage(
                  imageUrl: UserLocalData.getUserImageUrl(),
                  radius: 60,
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => _showPicker(context),
                  child: Text('Select Image'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Back'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    ImagePicker _imagePicker = ImagePicker();
    PickedFile _file = await _imagePicker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    setState(() {
      _image = _file;
    });
  }

  _imgFromGallery() async {
    ImagePicker _imagePicker = ImagePicker();
    PickedFile _file = await _imagePicker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      _image = _file;
    });
  }
}
