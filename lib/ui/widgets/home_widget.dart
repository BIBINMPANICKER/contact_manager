import 'package:contact_manager/blocs/user_bloc.dart';
import 'package:contact_manager/models/user_model.dart';
import 'package:contact_manager/ui/screens/details_page.dart';
import 'package:contact_manager/ui/screens/edit_details.dart';
import 'package:contact_manager/ui/screens/home_page.dart';
import 'package:contact_manager/utils/db_factory.dart';
import 'package:contact_manager/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeWidget extends StatefulWidget {
  final listData;
  final from;

  HomeWidget(this.listData, {this.from});

  @override
  _HomeWidgetState createState() => _HomeWidgetState(listData);
}

class _HomeWidgetState extends State<HomeWidget> {
  UserModel homeTabData;

  _HomeWidgetState(this.homeTabData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: homeTabData.data.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => ListItem(homeTabData.data[index])),
        floatingActionButton: widget.from == 1
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditDetails(
                                Datum(),
                                from: 1,
                              )));
                },
                child: Icon(
                  Icons.add,
                ),
              )
            : SizedBox());
  }
}

class ListItem extends StatefulWidget {
  final data;

  ListItem(this.data);

  @override
  _ListItemState createState() => _ListItemState(data);
}

class _ListItemState extends State<ListItem> {
  final Datum data;

  _ListItemState(this.data);

  bool isFavourite;

  @override
  void initState() {
    isFavourite = data.isFavourite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
        child: ListTile(
          title: Text('${data.firstName} ${data.lastName}'),
          subtitle: Text(data.email),
          leading: CircleAvatar(
            child: Text(data.firstName[0]),
          ),
          trailing: isFavourite
              ? IconButton(
                  icon: Icon(
                    Icons.star,
                    color: Color(0xff2a3052),
                  ),
                  onPressed: () {
                    DbFactory().favouritesDb.deleteFavourite(data.id);
                    userBloc.getAllUsers();
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  })
              : IconButton(
                  icon: Icon(
                    Icons.star_border,
                    color: Color(0xff2a3052),
                  ),
                  onPressed: () {
                    DbFactory().favouritesDb.addFavourite(data.id);
                    userBloc.getAllUsers();
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  }),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Details(data)));
          },
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.green,
          icon: Icons.edit,
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditDetails(
                        widget.data,
                        from: 0,
                      ))),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            showToast('Deleting.....Please wait.....');
            userBloc.deleteUser(widget.data.id).then((res) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            });
          },
        ),
      ],
    );
  }
}
