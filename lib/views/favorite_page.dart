import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/widgets/news_card.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({Key? key}) : super(key: key);
  final NewsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.fetchFavs();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Favorites",style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w500),),
      ),
      body: SingleChildScrollView(
        child: Obx(()=>ListView.builder(
            //physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.favoritesList.length,
            itemBuilder: (context, index) {
              return controller.favoritesList.length == 0 ? CircularProgressIndicator() : NewsCard(news: controller.favoritesList[index]);
            }
        )),
      ),
    );
  }
}
