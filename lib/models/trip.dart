
enum Season {//لتعريف مجموعة من القيم
  Winter,
  Spring,
  Summer,
  Autumn,
}

enum TripType {//أنواع الرحلات
  Exploration,//أستكشافية
  Recovery,//للتعافي
  Activities,//أنشطة
  Therapy,//علاجية
}

class Trip {//تحتوي على مجموعة من الخصائص التي تصف الرحلة.
  final String id;
  final List<String> categories;//عشان نربط كل رحلة بالتصنيفات الخاصة فيه
  final String title;
  final String imageUrl;
  final List<String> activities;//قائة الأنشطة
  final List<String> program;
  final int duration;//متغير لعدد أيام الرحلة المخطط لها
  final Season season;//لتحديد فصل من فصول السنة
  final TripType tripType;//
  final bool isInSummer;//للفلترة للرحلات الصيفية
  final bool isInWinter;
  final bool isForFamilies;

  const Trip({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.activities,
    required this.program,
    required this.duration,
    required this.season,
    required this.tripType,
    required this.isInSummer,
    required this.isInWinter,
    required this.isForFamilies,
  });
}
