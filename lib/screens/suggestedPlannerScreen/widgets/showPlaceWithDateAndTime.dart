import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/myFonts.dart';
import '../../../core/myPhotos.dart';
import '../../../providers/placesproviders.dart';
import '../../../providers/tripDateTimeProvider.dart';
import '../../placeDeatilScreen/placeDetailScreen.dart';
import '../../plannerForm/dateTimepicker/datePicker/widgets/showSelectedDate.dart';

class ShowPlaceWithDateAndTime extends StatelessWidget {
  final Place _place;
  final TripDate _tripDate;
  final TripTime _tripTime;
  ShowPlaceWithDateAndTime({
    Key key,
    Place place,
    TripDate tripDate,
    TripTime tripTime,
  })  : this._place = place,
        this._tripDate = tripDate,
        this._tripTime = tripTime,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ShowSelectedDate(date: _tripDate, onClick: null),
            // Text('ssfcdsscc'),
            Spacer(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                (_tripTime.getFormatedTime() == null)
                    ? DateFormat('hh:mm a').format(DateTime.now())
                    : _tripTime.getFormatedTime(),
                style: TextStyle(fontFamily: englishText, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).primaryColor,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
            PlaceInfoCard(
              place: _place,
            ),
          ],
        )
      ],
    );
  }
}

class PlaceInfoCard extends StatelessWidget {
  final Place _place;
  const PlaceInfoCard({
    Key key,
    @required Place place,
  })  : this._place = place,
        super(key: key);

  // bool _pageTransion() {
  //   UserLocalData.setPlaceIDInLocalData(_place.getPlaceID());
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetailScreen(place: _place),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width * .55,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (_place.getPlaceName() == null)
                  ? 'Name Not Found'
                  : _place.getPlaceName(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: englishText,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              (_place.getPlaceRating() == null)
                  ? '0'
                  : _place.getPlaceRating().toString(),
            ),
            Text(
              (_place.getPlaceFormattedAddress() == null)
                  ? 'Address Not Found'
                  : _place.getPlaceFormattedAddress(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: englishText,
              ),
            ),
            Hero(
              tag: _place.getPlaceID(),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (_place.getPlaceImageUrl() == null ||
                            _place.getPlaceImageUrl().isEmpty)
                        ? AssetImage(appLogo)
                        : NetworkImage(_place.getPlaceImageUrl()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
