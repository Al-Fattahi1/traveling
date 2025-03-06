import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:traveling_app/app_data.dart';
import 'package:traveling_app/models/trip.dart';
import 'package:traveling_app/screens/category_trips_screen.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/trip_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {//خريطة لتخزين الفلاتر المختلفة (صيف، شتاء، عائلي)
    'summer': false,
    'winter': false,
    'family': false,
  };
        // قائمة الرحلات المتاحة والتي يتم تصفيتها بناءً على الفلاتر _availableTrips
  List<Trip> _availableTrips = Trips_data;
  final List<Trip> _favoriteTrips = [];//قائمة الرحلات المفضلة

  void _changeFilters(Map<String, bool> filterData) {//دالة لتحديث الفلاتر وإعادة تصفية الرحلات المتاحة بناءً عليها
    setState(() {
      _filters = filterData;//هذا يعني أن الفلاتر الحالية في التطبيق تم استبدالها بالقيم الجديدة
      _availableTrips = Trips_data.where((trip) {
        if (_filters['summer'] == true && trip.isInSummer != true) {
          return false;
        }
        if (_filters['winter'] == true && trip.isInWinter != true) {
          return false;
        }
        if (_filters['family'] == true && trip.isForFamilies != true) {
          return false;//تحقق مما إذا كان الفلتر الخاص بالعائلات مفعلًا وإذا لم تكن الرحلة مناسبة للعائلات.

        }
        return true;//إذا لم يتحقق أي من الشروط السابقة، تعيد الدالة true، مما يعني أن الرحلة مناسبة ويمكن إضافتها إلى قائمة _availableTrips.
      }).toList();//تحويل النتيجة الى قائمة
    });
  }

  void _manageFavorite(String tripId) {
    final existingIndex = _favoriteTrips.indexWhere(//تستخدم للبحث عن فهرس الرحلة في قائمة المفضلات _favoriteTrips
      (trip) => trip.id == tripId,//هو تعبير يستخدم للتحقق مما إذا كان معرف الرحلة في القائمة يطابق tripId المعطى. إذا وُجدت الرحلة، ستعيد الدالة فهرسها؛ إذا لم توجد، ستعيد -1
    );
    if (existingIndex >= 0) {//التحقق من وجود الرحلة في المفضلات
      setState(() {
        _favoriteTrips.removeAt(existingIndex);//تقوم بإزالة الرحلة من قائمة المفضلات باستخدام الفهرس الذي تم العثور عليه.
      });
    } else {
      setState(() {//Trips_data.firstWhere: تعيد أول رحلة من قائمة Trips_data التي تطابق معرف الرحلة (tripId).
        _favoriteTrips.add(Trips_data.firstWhere(//_favoriteTrips.add(...): تضيف الرحلة المسترجعة إلى قائمة المفضلات.
          (trip) => trip.id == tripId,
        ));
      });
    }
  }

  bool _isFavorite(String id) {//اسم الدالة، يشير إلى أنها تستخدم للتحقق مما إذا كانت رحلة معينة مفضلة أم لا.
    return _favoriteTrips.any(
      (trip) => trip.id == id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [//يحدد اللغات المدعومة، هنا اللغة العربية
        Locale('ar', 'AE'), // English
      ],
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          primarySwatch: Colors.amber,//اللون الاساسي للتطبيق
          useMaterial3: true,
          fontFamily: "Lato-Bold",
          textTheme: ThemeData.light().textTheme.copyWith(
              headlineMedium: TextStyle(
                color: Colors.teal,
                fontSize: 24,
                fontFamily: "Lato-Bold",
                fontWeight: FontWeight.bold,
              ),
              headlineLarge: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: "Lato-Bold",
                fontWeight: FontWeight.bold,
              ))),
      //home: CategoriesScreen(),
      initialRoute: '/', //يحدد الشاشة الأولى التي تظهر عند بدء التطبيق.
      routes: {
        '/': (ctx) => TabsScreen(_favoriteTrips),
        CategoryTripsScreen.screenRoute: (ctx) =>
            CategoryTripsScreen(_availableTrips),
        TripDetailScreen.screenRoute: (ctx) =>
            TripDetailScreen(_manageFavorite, _isFavorite),
        FiltersScreen.screenRout: (ctx) =>
            FiltersScreen(_filters, _changeFilters),
      },
    );
  }
}
