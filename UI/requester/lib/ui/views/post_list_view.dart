import 'package:intl/intl.dart';

import 'package:requester/models/post.dart';
import 'package:requester/ui/shared/ui_helpers.dart';
import 'package:requester/ui/widgets/base_appbar.dart';
import 'package:requester/ui/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:requester/viewmodels/post_list_view_model.dart';

import '../widgets/bottom_navbar.dart';

class ItemModel {
  bool isExpanded;
  Post post;

  ItemModel({this.isExpanded: false, this.post});
}

class PostListView extends StatefulWidget {
  @override
  _PostListViewState createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PostListViewModel>.withConsumer(
        viewModel: PostListViewModel(),
        //onModelReady: (model) => model.fetchPosts(),
        builder: (context, model, child) => Scaffold(
              appBar: BaseAppbar.getAppBar('Post List'),
              
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpace(35),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                          child: Image.asset('assets/images/title.png'),
                        ),
                      ],
                    ),
                    Expanded(
                        /*
                          child: model.posts != null
                            ? ListView.builder(
                                itemCount: model.posts.length,
                                itemBuilder: (context, index) =>
                                    PostItem(post: model.posts[index]),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).primaryColor),
                                ),
                              )
                            */
                        child: ListView.builder(
                            itemCount: prepareData.length,
                            itemBuilder: (context, index) {
                              return ExpansionPanelList(
                                animationDuration: Duration(seconds: 1),
                                children: [
                                  ExpansionPanel(
                                    body: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Item: ${prepareData[index].post.item}',
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            'Service Fee: ${prepareData[index].post.serviceFee}',
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 13,
                                            ),
                                          ),
                                          verticalSpace(5),
                                          SizedBox(
                                            width: 80,
                                            height: 30,
                                            child: RaisedButton(onPressed: () {
                                              final snackBar = SnackBar(
                                                content: Text('You Accepted!'),
                                                action: SnackBarAction(
                                                  label: 'Undo',
                                                  onPressed: () {
                                                    // Some code to undo the change.
                                                  },
                                                ),
                                              );

                                              // Find the Scaffold in the widget tree and use
                                              // it to show a SnackBar.
                                              Scaffold.of(context).showSnackBar(snackBar);
                                            },
                                            child: Text(
                                              'Accept',
                                              style: TextStyle(fontSize: 15),
                                            ),)
                                          )
                                          
                                        ],
                                      ),
                                    ),
                                    headerBuilder: (context, isExpanded) {
                                      return Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                  prepareData[index].post.item),
                                              Text(DateFormat(
                                                      'kk:mm:ss \n EEE d MMM')
                                                  .format(prepareData[index]
                                                      .post
                                                      .deliverBy)),
                                              Text(prepareData[index]
                                                  .post
                                                  .serviceFee),
                                            ],
                                          ));
                                    },
                                    isExpanded: prepareData[index].isExpanded,
                                  )
                                ],
                                expansionCallback: (item, status) {
                                  setState(() {
                                    prepareData[index].isExpanded =
                                        !prepareData[index].isExpanded;
                                  });
                                },
                              );
                            }))
                  ],
                ),
              ),
              bottomNavigationBar: BottomNabar(),
            ));
  }

  List<ItemModel> prepareData = <ItemModel>[
    ItemModel(
        post: Post(
            item: 'bigMac', serviceFee: '\$30', deliverBy: DateTime.now())),
    ItemModel(
        post: Post(
            item: 'Subway', serviceFee: '\$30', deliverBy: DateTime.now())),
    ItemModel(
        post:
            Post(item: 'Panda', serviceFee: '\$30', deliverBy: DateTime.now())),
    ItemModel(
        post: Post(
            item: 'Macdonald', serviceFee: '\$30', deliverBy: DateTime.now())),
  ];
}
