import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import '../../core/myColors.dart';
import '../../database/databaseMethod.dart';
import '../../database/places_type_catalog.dart';
import '../../database/userLocalData.dart';
import '../../models/place_type_catalog.dart';
import '../allPlacesTypeScreen/selectable_image_widget.dart';
import '../homeScreen/homeScreen.dart';

class AllPlacesTypeScreen extends StatefulWidget {
  static const routeName = '/AllPlacesTypeScreen';
  @override
  _AllPlacesTypeScreenState createState() => _AllPlacesTypeScreenState();
}

class _AllPlacesTypeScreenState extends State<AllPlacesTypeScreen> {
  List<PlacesTypeCatalog> _catalog = [];
  List<String> favList = [];
  final controller = DragSelectGridViewController();
  int miniSelection = 5;

  void scheduleRebuild() => setState(() {});

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    super.dispose();
  }

  _initPage() async {
    final QuerySnapshot docs =
        await PlacesTypeCatalogMethods().getAllPlacesCatalog();
    docs.docs.forEach((element) {
      _catalog.add(PlacesTypeCatalog.fromDocument(element));
    });
    setState(() {});
  }

  @override
  void initState() {
    controller.addListener(scheduleRebuild);
    _initPage();
    super.initState();
  }

  onClick(String id, bool isSelected) {
    if (isSelected == true) {
      favList.add(id);
    } else {
      favList.remove(id);
    }
    favList.sort();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Place choose your',
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 30,
                    wordSpacing: 2,
                  ),
                ),
                Text(
                  'Preferences',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    wordSpacing: 2,
                    color: greenShade,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: DragSelectGridView(
                    gridController: controller,
                    padding: EdgeInsets.all(8),
                    itemCount: _catalog?.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index, selected) {
                      return SelectableImageWidget(
                        isSelected: selected,
                        onClick: onClick,
                        placeType: _catalog[index],
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: () async {
                  if ((miniSelection - controller.value.amount) <= 0) {
                    await DatabaseMethods().updateUserDoc(
                      uid: UserLocalData.getUserUID(),
                      userMap: {'interest': favList},
                    );
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      HomeScreen.routeName,
                      (route) => false,
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg:
                          'Place select ${(miniSelection - controller.value.amount)} more.',
                      backgroundColor: Colors.red,
                      timeInSecForIosWeb: 5,
                    );
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: greenShade,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    ((miniSelection - controller.value.amount) <= 0)
                        ? 'Your are good to go now'
                        : 'Choose ${5 - controller.value.amount} preferences to get started',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      // wordSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
