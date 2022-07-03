import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/services/api_services.dart';
import 'package:news_app/views/error_page.dart';

class NewsController extends GetxController {
  //final newsList = <Article>[].obs;
  var newsList = List<dynamic>.empty(growable: true).obs;
  var favoritesList = [].obs;
  var page = 1;
  var isLoading = true.obs;


  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;
  late TextEditingController searchBarController;

  @override
  void onInit() {
    searchBarController = TextEditingController();
    fetchNews2(page.toString(),"a");
    paginateNews();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchBarController.dispose();
    super.onClose();
  }

  void fetchFavs() async {
    favoritesList.clear();

    for(int i=0; i < newsList.length; i++){
      if(newsList[i].isFavorite.value) {
        favoritesList.add(newsList[i]);
      }
    }
    print(favoritesList.length);
  }

  void fetchNews2 (String page, String search) async {
    try{
      isMoreDataAvailable(false);
      isLoading(true);
      var news = await ApiServices.fetchNews(page,search);
      if (news!.status == "ok") {
        newsList.value = news.articles!;
        print(newsList.length);
        isLoading(false);
      }else{
        Get.to(ErrorPage());
      }
    }  catch(err){
      isLoading(false);
      Get.snackbar("Exception", err.toString());
    }
  }

  void fetchNewss(String page, String search) async {
    try{
      isLoading(true);
      var news = await ApiServices.fetchNews(page,search);
      print("news:$news");
      if (news!.status == "ok") {
        newsList.value = news.articles!;
        print(newsList);
        isLoading(false);
      }else{
        Get.to(ErrorPage());
      }
    }
    catch(err){
      Get.off(ErrorPage());
    }
  }

  void paginateNews() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("reached end");
        page++;
        getMoreNews(page, searchBarController.text.toString());
      }
    });
  }

  void getMoreNews(var page, search){
    try{
      ApiServices.fetchNews(page, search).then((resp){
        if(resp!.articles!.length > 0){
          isMoreDataAvailable(true);
        }else{
          isMoreDataAvailable(false);
          Get.snackbar("Message", "No more items");
        }
        newsList.add(resp);
        print(newsList.length);
      },onError: (err){
        isMoreDataAvailable(false);
        Get.snackbar("Error", err.toString());
      });
    }catch(err){
      isMoreDataAvailable(false);
      Get.snackbar("Exception", err.toString());
    }
  }


  void fetchNews(String page, String search) async {
    try{
      isLoading(true);
      var news = await ApiServices.fetchNews(page,search);
      print("news:$news");
      if (news!.status == "ok") {
        newsList.value = news.articles!;
        print(newsList);
        isLoading(false);
      }else{
        Get.to(ErrorPage());
      }
    }
    catch(err){
      Get.off(ErrorPage());
    }
  }
}