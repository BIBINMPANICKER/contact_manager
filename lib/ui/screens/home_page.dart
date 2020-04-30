import 'package:contact_manager/blocs/user_bloc.dart';
import 'package:contact_manager/models/user_model.dart';
import 'package:contact_manager/ui/widgets/home_widget.dart';
import 'package:contact_manager/utils/db_factory.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel favouriteTabData;
  UserModel homeTabData;

  @override
  void initState() {
    userBloc.getAllUsers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff2a3052), primarySwatch: Colors.orange),
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
                title: Text('Contacts'), actions: <Widget>[Icon(Icons.search)]),
            bottomNavigationBar: new TabBar(
              tabs: [
                Tab(
                  icon: new Icon(Icons.home, color: Color(0xff2a3052)),
                ),
                Tab(
                  icon: new Icon(
                    Icons.star,
                    color: Color(0xff2a3052),
                  ),
                ),
              ],
            ),
            body: StreamBuilder<UserModel>(
                stream: userBloc.getUsers,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    bifurcateData(snapshot.data);
                  }
                  return snapshot.hasData
                      ? TabBarView(
                          children: [
                            HomeWidget(
                              homeTabData,
                              from: 1,
                            ),
                            HomeWidget(
                              favouriteTabData,
                              from: 2,
                            )
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                }),
          )),
    );
  }

  bifurcateData(UserModel data) {
    homeTabData = data;
    DbFactory().favouritesDb.getFavouritesId().then((onValue) {
      homeTabData = data;
      setState(() {
        onValue.forEach((f) {
          for (int i = 0; i < data.data.length; i++) {
            if (homeTabData.data[i].id == f) {
              homeTabData.data[i].isFavourite = true;
              break;
            }
          }
        });
      });
    });
    DbFactory().favouritesDb.getFavourites().then((onValue) {
      setState(() {
        favouriteTabData = onValue;
      });
    });
  }
}
