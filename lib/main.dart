import 'package:dummy_project/screens/settingScreen/setting_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './database/userLocalData.dart';
import './core/myColors.dart';
import './providers/trips.dart';
import './providers/placesproviders.dart';
import './providers/tripDateTimeProvider.dart';
import './screens/allPlacesTypeScreen/all_places_type_screeen.dart';
import './screens/planFeedScreen/plans_feed_screen.dart';
import './screens/reportProbleScreen/report_problem_screen.dart';
import './screens/myPlannerScreen/my_planner_screen.dart';
import './screens/placeDeatilScreen/placeDetailScreen.dart';
import './screens/profileScreen/profile_screen.dart';
import './screens/suggestedPlannerScreen/seggestedPlannerScreen.dart';
import './screens/splashScreen/welcomeScreen.dart';
import './screens/auth/loginScreen/loginScreen.dart';
import './screens/auth/signupScreen/signupScreen.dart';
import './screens/homeScreen/homeScreen.dart';
import './screens/PlannerForm/plannerFormScreen.dart';
import './screens/plannerListViewScreen/plannerListViewScreen.dart';
import './screens/plannerMapScreen/plan_map_view_screen.dart';
import './screens/plannerForm/aboutLocations/SearchLocation/SearchStartingPoint.dart';
import './screens/plannerForm/aboutLocations/SearchLocation/searchEndingPoint.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserLocalData.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TripTypeProvider()),
        ChangeNotifierProvider.value(value: PlacesProvider()),
        ChangeNotifierProvider.value(value: TripDateTimeProvider()),
      ],
      child: Consumer<TripTypeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tour & Travel Sharing',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              iconTheme: IconThemeData(color: greenShade),
            ),
            home: WelcomeScreen(),
            routes: {
              WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
              AllPlacesTypeScreen.routeName: (ctx) => AllPlacesTypeScreen(),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              SignUpScreen.routeName: (ctx) => SignUpScreen(),
              PlansFeedScreen.routeName: (ctx) => PlansFeedScreen(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              PlannerFormScreen.routeName: (ctx) => PlannerFormScreen(),
              SuggestedPlannerScreen.routeName: (ctx) =>
                  SuggestedPlannerScreen(),
              PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
              SearchStartingPoint.routeName: (ctx) => SearchStartingPoint(),
              SearchEndingPoint.routeName: (ctx) => SearchEndingPoint(),
              PlannerListViewScreen.routeName: (ctx) => PlannerListViewScreen(),
              PlanMapViewScreen.routeName: (ctx) => PlanMapViewScreen(),
              MyPlannerScreen.routeName: (ctx) => MyPlannerScreen(),
              ProfileScreen.routeName: (ctx) => ProfileScreen(),
              ReportProblemScreen.routeName: (ctx) => ReportProblemScreen(),
              SettingScreen.routeName: (ctx) => SettingScreen(),
            },
          );
        },
      ),
    );
  }
}

// Certificate fingerprints:
//  SHA1: F6:3C:6E:07:37:98:D1:37:8D:8D:AD:2B:80:BE:5E:2C:50:EF:71:F9
//  SHA256: B8:1F:B2:FF:CB:2E:A2:45:12:1B:22:43:35:C5:B6:CC:A5:3B:CE:D4:6B:97:93:EF:76:D9:81:0F:F9:16:4C:6E