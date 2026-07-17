import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news/data/api.dart';
import 'package:news/data/models/news_model.dart';
import 'package:news/widgets/image_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> data = {
    "status": "ok",
    "totalResults": 9966,
    "articles": [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202020),
      appBar: AppBar(
        backgroundColor: Color(0xff1877F2),
        title: Text('News App', style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
      ),
      body: FutureBuilder<NewsModel>(
        future: Api.getNews(),
        builder: (context, snapshot) {
          log('future builder');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            log('future builder Error');

            return Center(
              child: Text(
                'Error From call get news try again',
                style: TextStyle(color: Colors.red, fontSize: 20),
                textAlign: TextAlign.center,
              ), // Text
            ); // Center
          }
          if (snapshot.hasData) {
            log('future builder has data');
            List<Article> articles = snapshot.data?.articles ?? [];
            return ListView.builder(
              itemBuilder: (context, index) {
                return ImageItemWidget(
                  image: articles[index].urlToImage,
                  title: articles[index].title,
                  onTap: () {},
                ); // ImageItemWidget
              },
              itemCount: data.length,
            ); // ListView.builder
          } else {
            return Container(width: 100, height: 100, color: Colors.red);
          }
        },
      ),
    );
  }
}

String dummyImage =
    'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip';
