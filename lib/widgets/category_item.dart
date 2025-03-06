import 'package:flutter/material.dart';
import '../screens/category_trips_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const CategoryItem(this.id, this.title, this.imageUrl, {super.key});

  void selectCategory(BuildContext ctx) {//دالة تُستخدم للتنقل إلى شاشة الرحلات المرتبطة بالفئة المحددة.
    Navigator.of(ctx).pushNamed(
      CategoryTripsScreen.screenRoute,//يُشير إلى مسار الشاشة الجديدة.
      arguments: {//تُستخدم لتمرير بيانات (المعرف والعنوان) إلى الشاشة الجديدة.
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //يجعل الستاك قابل للنقر
      onTap: () => selectCategory(context),
      splashColor: Colors.teal,//splashColor: لون التأثير عند النقر.
      borderRadius: BorderRadius.circular(15),

      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Container(//يُستخدم لتوفير خلفية مظللة فوق الصورة.
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.4),//خلفية سوداء مع شفافية
            ),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge,//استخدام نمط النص المحدد في السمة
            ),
          ),
        ],
      ),
    );
  }
}
