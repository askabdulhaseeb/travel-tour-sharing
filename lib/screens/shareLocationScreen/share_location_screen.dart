import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_project/database/databaseMethod.dart';
import 'package:dummy_project/database/location_sharing_methods.dart';
import 'package:dummy_project/database/userLocalData.dart';
import 'package:dummy_project/models/app_user.dart';
import 'package:dummy_project/models/location_share.dart';
import 'package:dummy_project/screens/widgets/circularProfileImage.dart';
import 'package:dummy_project/screens/widgets/homeAppBar.dart';
import 'package:dummy_project/screens/widgets/showLoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShareLocationScreen extends StatefulWidget {
  static const routeName = '/ShareLocationScreen';
  const ShareLocationScreen({Key key}) : super(key: key);
  @override
  _ShareLocationScreenState createState() => _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {
  String initialValue = '';
  Stream _seaarchResult;
  List<String> shareLocationWithUid = [];
  List<AppUser> shareLocationWith = [];

  // _getSharedWith() async {
  //   var docs = await LocationSharingMethods().getCompleteDocOfCurrectUser();
  //   print('Docs: $docs');
  //   locationShare = LocationShare.fromDocument(docs);
  //   setState(() {});
  //   _getSharedUserData();
  // }

  _getSharedUserData() {
    shareLocationWithUid = UserLocalData.getShareLocationWith();
    shareLocationWith.clear();
    shareLocationWithUid.forEach((element) async {
      var docs = await DatabaseMethods().getUserInfofromFirebase(element);
      AppUser _user = AppUser.fromDocument(docs);
      shareLocationWith.add(_user);
      setState(() {});
    });
  }

  _onChange(String name) async {
    _seaarchResult = await DatabaseMethods().searchUserByName(name);
    setState(() {});
  }

  @override
  void initState() {
    // _getSharedWith();
    _getSharedUserData();
    _onChange(initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: homeAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: initialValue,
              keyboardType: TextInputType.streetAddress,
              autofocus: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFEEEEEE),
                hintText: '''Let's Share Location''',
                hintStyle: TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 16,
                ),
                prefixIcon: Icon(Icons.search, color: Color(0xFF757575)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
              ),
              onChanged: (newValue) {
                _onChange(newValue);
              },
            ),
            (shareLocationWith?.length == 0)
                ? SizedBox()
                : SizedBox(height: 10),
            (shareLocationWith?.length == 0)
                ? SizedBox()
                : Text(
                    'You already Shared your location with',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
            Container(
              height: (shareLocationWith?.length == 0) ? 0 : 100,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: shareLocationWith?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircularProfileImage(
                              imageUrl: shareLocationWith[index].imageURL,
                              radius: 36,
                            ),
                            GestureDetector(
                              onTap: () async {
                                showLoadingDislog(context, 'message');
                                LocationSharingMethods()
                                    .updateShareLocationPersons(
                                        addNewPerson: false,
                                        uid: shareLocationWith[index].uid);
                                shareLocationWithUid.removeWhere((element) =>
                                    element == shareLocationWith[index].uid);
                                shareLocationWith.removeWhere((element) =>
                                    element.uid ==
                                    shareLocationWith[index].uid);
                                UserLocalData.setShareLocationWith(
                                    shareLocationWithUid);
                                // LocationSharingMethods().updateUserLocation();
                                _getSharedUserData();
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.cancel),
                            ),
                          ],
                        ),
                        Container(
                          width: 60,
                          child: Text(
                            shareLocationWith[index].displayName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // const SizedBox(height: 20),
            Flexible(
              child: StreamBuilder(
                stream: _seaarchResult,
                builder: (context, snapshot) {
                  return (snapshot.hasData)
                      ? Container(
                          child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds = snapshot.data.docs[index];
                              return (ds['uid'] == UserLocalData.getUserUID())
                                  ? SizedBox()
                                  : ListTile(
                                      leading: CircularProfileImage(
                                        imageUrl: ds['imageURL'],
                                      ),
                                      title: Text(ds['displayName']),
                                      subtitle: Text(ds['email']),
                                      onTap: () async {
                                        if (shareLocationWithUid
                                            .contains(ds['uid'])) {
                                          Fluttertoast.showToast(
                                              msg: 'Already in this list',
                                              backgroundColor: Colors.red);
                                        } else {
                                          showLoadingDislog(context, '');
                                          LocationSharingMethods()
                                              .updateShareLocationPersons(
                                                  addNewPerson: true,
                                                  uid: ds['uid']);
                                          shareLocationWithUid.add(ds['uid']);
                                          UserLocalData.setShareLocationWith(
                                              shareLocationWithUid);
                                          // LocationSharingMethods()
                                          //     .updateUserLocation();
                                          _getSharedUserData();
                                          Navigator.of(context).pop();
                                          Fluttertoast.showToast(
                                              msg: 'Successfully added',
                                              backgroundColor: Colors.green);
                                        }
                                      },
                                    );
                            },
                          ),
                        )
                      : Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
