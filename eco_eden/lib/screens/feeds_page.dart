import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecoeden/models/feedsArticle.dart';
import 'package:ecoeden/services/webservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedsPageState extends State<FeedsPage> {

  List<FeedsArticle> _newsArticles = List<FeedsArticle>();
  bool liked = false;
  bool showHeartOverlay  = false;
  bool isLoading = false;
  bool trashed = false;

  ScrollController _scrollController = new ScrollController();
  static String nextPage =  'https://api.ecoeden.xyz/photos/';
  static final String NEWS_PLACEHOLDER_IMAGE_ASSET_URL = 'assets/placeholder.png';
  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _populateNewsArticles();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _populateNewsArticles() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    Webservice().load(FeedsArticle.all).then((newsArticles) => {
      setState(() => {
        isLoading = false,
        _newsArticles.addAll(newsArticles)
      })
    });

  }

  /*ListTile _buildItemsForListView(BuildContext context, int index) {
      return ListTile(
        title: _newsArticles[index].urlToImage == null ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL) : Image.network(_newsArticles[index].urlToImage),
        subtitle: Text(_newsArticles[index].title, style: TextStyle(fontSize: 18)),
      );
  }*/
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    //print(_newsArticles[0].description);
    return Scaffold(
        appBar: AppBar(
          title: Text('Feeds'),
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: _newsArticles.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == _newsArticles.length) {
                      return _buildProgressIndicator();
                    } else {
                      return Post(
                          liked: liked,
                          showHeartOverlay:showHeartOverlay,
                          trashed: trashed,
                          description: _newsArticles[index].description,
                          imageUrl: _newsArticles[index].image,
                      );
                    }
                  },
                  controller: _scrollController,
                ),
              )
            ],
          ),
        )
    );
  }
}

class Post extends StatefulWidget {
  bool liked ;
  bool showHeartOverlay ;
  bool trashed;
  final String description;
  final String imageUrl;
  Post({@required this.liked,this.showHeartOverlay,this.trashed,this.description,this.imageUrl});

  @override
  _PostState createState() => _PostState();
}
class _PostState extends State<Post> {

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: <Widget>[
            PostHeader(),
            ListTile(
              leading: Text(
                widget.description,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            GestureDetector(
              onDoubleTap: () {
                setState(() {
                  widget.liked = true;
                  widget.showHeartOverlay = true;
                  if (widget.showHeartOverlay) {
                    Timer(const Duration(
                        milliseconds: 180), () {
                      setState(() {
                        widget.showHeartOverlay = false;
                      });
                    }
                    );
                  }
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  //Image.asset('assets/profile.jpg'),
                   widget.imageUrl== null
                      ? Image.asset('assets/profile.jpg')
                      : Image.network(
                      widget.imageUrl),
                  widget.showHeartOverlay ?
                  Icon(
                    Icons.favorite, color: Colors.white54,
                    size: 80.0,)
                      : Container(),
                ],
              ),
            ),
            ListTile(
              leading: IconButton(
                  iconSize: 30.0,
                  icon: Icon(widget.liked ? Icons.favorite : Icons
                      .favorite_border,
                      color: widget.liked ? Colors.red : Colors
                          .grey),
                  onPressed: () {
                    setState(() {
                      widget.liked = !widget.liked;
                    });
                  }),
              trailing: IconButton(
                  iconSize: 30.0,
                  icon: Icon(widget.trashed ? FontAwesomeIcons.solidTrashAlt :FontAwesomeIcons.trash,
                    color: widget.trashed ? Colors.red : Colors
                        .green,
                    size: 24.0,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.trashed = !widget.trashed;
                    });
                  }),
            )
          ],
        )
    );
  }
}

class PostHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          CircleImage(),
          Container(
            padding: EdgeInsets.only(left: 15.0),
            child: Text('Harami Ghosh Dost',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              trailing: Icon(Icons.more_vert),
            ),
          )
        ],
      ),
    );
  }
}

class CircleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      height: 45.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/IMG_2661.JPG'),
          )
      ),
    );
  }
}


class FeedsPage extends StatefulWidget {

  @override
  createState() => FeedsPageState();
}