import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/myColors.dart';
import '../../database/places_type_catalog.dart';
import '../../models/app_user.dart';
import '../../models/place_type_catalog.dart';
import '../profileScreen/interest_tile_widget.dart';
import '../widgets/circularProfileImage.dart';

class ProfileScreen extends StatefulWidget {
  final AppUser _user;
  const ProfileScreen({AppUser user}) : _user = user;
  static const routeName = '/profileScreen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  List<PlacesTypeCatalog> _catalog = [];
  _initPage() async {
    List<String> _allCatelogId = [];
    final QuerySnapshot _catDoc =
        await PlacesTypeCatalogMethods().getAllPlacesCatalog();
    _catDoc.docs.forEach((element) {
      final PlacesTypeCatalog temp = PlacesTypeCatalog.fromDocument(element);
      _allCatelogId.add(temp.id);
    });

    widget._user?.interest?.forEach((element) async {
      final DocumentSnapshot snapshot =
          await PlacesTypeCatalogMethods().getSpecificTypeInfo(id: element);
      final PlacesTypeCatalog temp = PlacesTypeCatalog.fromDocument(snapshot);
      if (_allCatelogId.contains(temp.id)) {
        _catalog.add(temp);
      }
      setState(() {});
    });

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    _initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: greenShade),
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProfileImage(
                        imageUrl: widget._user?.imageURL, radius: 64),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    widget._user?.displayName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 120,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: greenShade),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _catalog?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (widget._user.interest.length > 0) {
                          return InterestTileWidget(interest: _catalog[index]);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
