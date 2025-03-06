import 'package:flutter/material.dart';
import 'package:traveling_app/app_data.dart';

class TripDetailScreen extends StatelessWidget {
  static const screenRoute = '/trip-detail';
  final Function manageFavorite;
  final Function isFavorite; //دالة تُستخدم للتحقق مما إذا كانت الرحلة مفضلة.

  const TripDetailScreen(this.manageFavorite, this.isFavorite, {super.key});
//دالة تُستخدم لإنشاء عنوان قسم.
  Widget buildSectionTitle(BuildContext context, String titleText) {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

//دالة تُستخدم لإنشاء حاوية تحتوي على قائمة.
  Widget buildListViewContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 200,
      padding: EdgeInsets.all(10),
      child: child,
    );
  }

  @override // دالة تقوم ببناء واجهة المستخدم
  Widget build(BuildContext context) {
    final tripId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedTrip = Trips_data.firstWhere(
      //تُستخدم لاسترجاع الرحلة المحددة من Trips_data باستخدام firstWhere
      (trip) => trip.id == tripId,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedTrip.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedTrip.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildSectionTitle(context, 'الأنشطة'),
            buildListViewContainer(
              ListView.builder(
                itemCount: selectedTrip.activities.length,
                itemBuilder: (ctx, index) => Card(
                  elevation: 0.3,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedTrip.activities[index]),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildSectionTitle(context, 'البرنامج اليومي'),
            buildListViewContainer(ListView.builder(
              itemCount: selectedTrip.program.length,
              itemBuilder: (ctx, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('يوم ${index + 1}'),
                    ),
                    title: Text(selectedTrip.program[index]),
                  ),
                  Divider(),
                ],
              ),
            )),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(tripId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => manageFavorite(tripId),
      ),
    );
  }
}
