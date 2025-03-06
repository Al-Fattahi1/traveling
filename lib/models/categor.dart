
class Category {//
  final String id;//final: تعني أن القيم لهذه الخصائص لا يمكن تغييرها بعد تعيينها (أي أنها ثابتة).
  final String title;
  final String imageUrl;

  const Category(
      {required this.id, required this.title, required this.imageUrl});
}
//{required ...}: تُستخدم لتحديد أن هذه الخصائص مطلوبة عند إنشاء كائن جديد من الفئة. إذا لم يتم تمرير قيمة، سيظهر خطأ في وقت الترجمة.