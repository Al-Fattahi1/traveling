import 'package:flutter/material.dart';
import 'package:traveling_app/models/trip.dart';
import '../widgets/trip_item.dart';

class CategoryTripsScreen extends StatefulWidget {//فئة تمثل الشاشة التي تعرض الرحلات المتعلقة بفئة معينة.
  static const screenRoute = '/category-trips';
  final List<Trip> avaliableTrips;//قائمة تحتوي على الرحلات المتاحة

  const CategoryTripsScreen(this.avaliableTrips, {super.key});

  @override
  State<CategoryTripsScreen> createState() => _CategoryTripsScreenState();
}

class _CategoryTripsScreenState extends State<CategoryTripsScreen> {
  String? categoryTitle;//عنوان الفئة، يُستخدم لعرضه في شريط العنوان
  List<Trip> displayTrips = [];//قائمة الرحلات التي سيتم عرضها في الشاشة
  bool _isInit = false; // متغير لضمان تشغيل الكود مرة واحدة

  @override
  void didChangeDependencies() {// تُستدعى عندما تتغير الاعتماديات، وتستخدم هنا لاستخراج البيانات من الـ arguments.
    if (!_isInit) {
      // استرجاع البيانات من الـ arguments
      final routeArgument =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>?;//يسترجع المعطيات المرسلة إلى الشاشة (مثل id وtitle). ثم تحول ال نوع ماب

      if (routeArgument != null) {
        final categoryId = routeArgument['id'] ?? '';
        categoryTitle = routeArgument['title'] ?? '';

        displayTrips = widget.avaliableTrips.where((trip) {//يتم تصفية الرحلات المتاحة بناءً على فئة categoryId
          return trip.categories.contains(categoryId);
        }).toList();
      }
      _isInit = true; // منع إعادة تشغيل الكود عند إعادة البناء
    }
    super.didChangeDependencies();
  }

  void _removeTrip(String tripId) {//دالة تُستخدم لإزالة رحلة من قائمة
    setState(() {
      displayTrips.removeWhere((trip) => trip.id == tripId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle ?? 'رحلات'),//يعرض عنوان الفئة وإذا لم يكن موجود يعرض رحلات كعنوان أفتراضي
      ),
      body: ListView.builder(
        itemCount: displayTrips.length,
        itemBuilder: (ctx, index) {//دالة تُستخدم لإنشاء كل عنصر في القائمة
          return TripItem(//مكون يعرض تفاصيل الرحلة
            id: displayTrips[index].id,
            title: displayTrips[index].title,
            imageUrl: displayTrips[index].imageUrl,
            duration: displayTrips[index].duration,
            tripType: displayTrips[index].tripType,
            season: displayTrips[index].season,
            //removeItem: _removeTrip,
          );
        },
      ),
    );
  }
}
