
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/widgets/red_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatelessWidget {
  NewsDetail({Key? key, required this.news}) : super(key: key);
  final NewsController controller = Get.find();
  var news;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed:() {
          controller.fetchFavs();
          Get.back();
        }, icon: Icon(Icons.chevron_left,color: Colors.black,size: 30,)),
        actions: [
          IconButton(onPressed:() {
            if(news.isFavorite.value == true){
              news.isFavorite.value = false;
            }else{
              news.isFavorite.value = true;
            }
          },
              icon: Obx(()=>Icon(Icons.favorite,size: 26,color: news.isFavorite.value ? Colors.red : Colors.grey,))),
          IconButton(onPressed:() {
            Share.share(news.url);
            print("sharebutton");
          }, icon: Icon(Icons.share,size: 30,color: Colors.grey,))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: Get.width,
                      height: Get.height,
                    ),
                    Positioned(
                        child: Container(
                          height: Get.height*0.35,
                          width: Get.width,
                          child: Image.network(news.urlToImage.toString(),fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.amber,
                              alignment: Alignment.center,
                              child: const Text(
                                'Whoops!',
                                style: TextStyle(fontSize: 30),
                              ),
                            );
                          },),
                        )),
                    Positioned(
                        top: Get.height*0.30,
                        child: Container(
                          width: Get.width,
                          height: Get.height,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(38) , topRight: Radius.circular(38))
                          ),
                          child: Column(children: [
                            SizedBox(height: Get.height*0.03,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(DateFormat.yMMMMEEEEd('en_US').add_jms().format(news.publishedAt)
                                    .toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                                SizedBox(width: Get.width*0.08,)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(news.title.toString(),textAlign: TextAlign.left,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text("   "+news.content.toString(),style: TextStyle(fontSize: 16,color: Colors.black87),),
                            ),
                            RedButton(title: 'Open News', onClick: () async {
                              String url = news.url.toString();
                              if(await canLaunchUrl(Uri.parse(url))){
                                await launchUrl(Uri.parse(url));
                              }else {
                                print("The action is not supported. (No Browser app)");
                              }
                              },),
                          ],),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}