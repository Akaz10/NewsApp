import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/widgets/news_card.dart';


class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final NewsController controller = Get.put(NewsController());
  var _isSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("News",style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w500),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.searchBarController,
              onChanged: (text){
                  print(text);
                  controller.fetchNews2("1",text);
              },
              decoration: const InputDecoration(
                  hintText: "Search the News",
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),),
                  filled: true,
                  fillColor: Colors.white,
              ),
              style: const TextStyle(
                  color: Color(0xFF262932),),),
                ),
                Obx(()=> controller.isLoading.value ? Center(heightFactor: 12,child: CircularProgressIndicator(color: Colors.red,)) :
                    ListView.builder(
                        controller: controller.scrollController,
                        //physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.newsList.length,
                        itemBuilder: (context, index) {
                      return controller.newsList.length == 0 ? CircularProgressIndicator() : NewsCard(news: controller.newsList[index]);
                    }
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}