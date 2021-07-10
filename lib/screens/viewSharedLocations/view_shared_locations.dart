import 'package:dummy_project/database/databaseMethod.dart';
import 'package:dummy_project/database/location_sharing_methods.dart';
import 'package:dummy_project/models/app_user.dart';
import 'package:dummy_project/screens/viewSharedLocations/show_user_on_map.dart';
import 'package:dummy_project/screens/widgets/circularProfileImage.dart';
import 'package:dummy_project/screens/widgets/homeAppBar.dart';
import 'package:dummy_project/screens/widgets/showLoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewSharedLocations extends StatefulWidget {
  static const routeName = '/ViewSharedLocations';
  const ViewSharedLocations({Key key}) : super(key: key);
  @override
  _ViewSharedLocationsState createState() => _ViewSharedLocationsState();
}

class _ViewSharedLocationsState extends State<ViewSharedLocations> {
  List<AppUser> _canView = [];
  _initPage() async {
    List<String> _canViewUID = [];
    final docs = await LocationSharingMethods().getCompleteDocOfCurrectUser();
    _canViewUID = List<String>.from(docs?.data()['canView']);
    _canViewUID.forEach((uid) async {
      final _userDocs = await DatabaseMethods().getUserInfofromFirebase(uid);
      AppUser _tempUser = AppUser.fromDocument(_userDocs);
      _canView.add(_tempUser);
      setState(() {});
    });
  }

  @override
  void initState() {
    _initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            (_canView.length > 0)
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _canView?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () async {
                            showLoadingDislog(context, 'message');
                            final _locationDoc = await LocationSharingMethods()
                                .getCompleteDocOfAnyUser(
                              uid: _canView[index].uid,
                            );
                            if (_locationDoc == null) {
                              Navigator.of(context).pop();
                              Fluttertoast.showToast(
                                msg: 'Unable to show the location now!',
                                backgroundColor: Colors.red,
                              );
                            } else {
                              final double lat =
                                  (_locationDoc?.data()['lat'] ?? 0.0 + 0.0);
                              final double lng =
                                  (_locationDoc?.data()['lng'] ?? 0.0 + 0.0);
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ShowUserLocationOnMap(
                                    user: _canView[index],
                                    lat: lat,
                                    lng: lng,
                                  ),
                                ),
                              );
                            }
                          },
                          leading: CircularProfileImage(
                            imageUrl: _canView[index].imageURL,
                          ),
                          title: Text(_canView[index].displayName),
                          subtitle: Text(_canView[index].email),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text('No Person Found Yet!'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
