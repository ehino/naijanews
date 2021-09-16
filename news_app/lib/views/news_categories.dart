import 'package:flutter/material.dart';
import 'package:news_app/helpers/news.dart';
import 'package:news_app/models/article_model.dart';
import 'article_view.dart';

class NewsCategory extends StatefulWidget {
  String category;
  NewsCategory ({this.category});

  @override
  _NewsCategoryState createState() => _NewsCategoryState();
}


class _NewsCategoryState extends State<NewsCategory> {
  List <ArticleModel> articles =  List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();

  }

  getCategoryNews () async{
    CategoryNews newsClass = CategoryNews();
    await newsClass.getCategoryNews(widget.category);
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
          'Categories',
        ),
        centerTitle: true,
        elevation: 0 ,
      ),
      body:_loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        child: Container(
          child: Column (
            children:<Widget> [
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
