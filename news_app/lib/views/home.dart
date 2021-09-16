import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helpers/data.dart';
import 'package:news_app/helpers/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/news_categories.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> newsCategories = List<CategoryModel> ();
  List <ArticleModel> articles =  List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    newsCategories = getCategory();
    getNews();
  }

  getNews () async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        backgroundColor: Colors.green [500],
        title: Text(
          'NaijaNews',
        ),
        centerTitle: true,
        elevation: 0 ,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ):
      SingleChildScrollView(
        child: Container (
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column (
            children: <Widget>[
              Container(
                height: 80,
                child: ListView.builder(
                  itemCount: newsCategories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                    return CategoryTile(
                      imageUrl: newsCategories[index].imageUrl,
                      categoryName: newsCategories[index].categoryName,
                    );
                    },
                ),
              ),

              //Blogs Section
              Container (
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: articles.length,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                    return BlogTile (
                    imageUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      desc: articles[index].description,
                      url: articles[index].url,
                    );
                }),
              ),
            ],
          ),
        ),
      ),

    );

  }
}

class CategoryTile extends StatelessWidget {

  String imageUrl;
  String categoryName;

  CategoryTile ({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => NewsCategory(
              category: categoryName.toLowerCase(),
            ),
        ));
      },
      child: Container(

        margin: EdgeInsets.fromLTRB(0, 10, 15, 0),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(imageUrl : imageUrl, width: 120, height: 60, fit: BoxFit.cover,
                )
            ),
            Container(
              alignment: Alignment.center,
              width: 120, height: 60,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text (categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {

  final String imageUrl, title, desc, url;

  BlogTile ({@required this.imageUrl, @required this.title, @required this.desc, @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
            blogUrl: url,
          )
        ));
      },
      child: Container(
        padding: EdgeInsets.only(top: 15),
        child: Card(
          child: Column (
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                  child: Image.network(imageUrl)),
              Text(title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              ),
              SizedBox(height: 5),
              Text(desc,
              style: TextStyle(
                fontSize: 15
              ),),
            ],
          ),
        ),

      ),
    );
  }
}

