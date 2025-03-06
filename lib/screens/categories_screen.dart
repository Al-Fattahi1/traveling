import 'package:flutter/material.dart';
import '../app_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(//لتحديد عرض كل تصنيف على الشاشة
        maxCrossAxisExtent: 200,//يحدد الحد الأقصى لعرض كل عنصر في الشبكة
        childAspectRatio: 7 / 8,//يحدد نسبة العرض إلى الارتفاع لكل عنصر في الشبكة. هنا، العرض سيكون أقل قليلاً من الارتفاع.
        mainAxisSpacing: 10,//المسافة بين العناصر في الاتجاه العمودي
        crossAxisSpacing: 10,
      ),
      children: Categories_data.map((categoryData) => CategoryItem(
          categoryData.id, categoryData.title, categoryData.imageUrl)).toList(),
    );
  }
}
//gridDelegate: يحدد كيفية توزيع العناصر في الشبكة.
//SliverGridDelegateWithMaxCrossAxisExtent: نوع من توزيع العناصر في الشبكة يسمح بتحديد أقصى عرض للعناصر.

/* Categories_data.map(...): تستخدم لتحويل قائمة الفئات (Categories_data) إلى قائمة من عناصر الواجهة.
categoryData: يمثل كل عنصر في قائمة الفئات.
CategoryItem(...): استدعاء مكون CategoryItem، حيث يتم تمرير:
categoryData.id: معرف الفئة.
categoryData.title: عنوان الفئة.
categoryData.imageUrl: رابط الصورة التمثيلية للفئة.
toList(): تحويل نتيجة map إلى قائمة. */