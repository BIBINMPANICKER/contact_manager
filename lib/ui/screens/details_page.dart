import 'package:contact_manager/models/user_model.dart';
import 'package:contact_manager/ui/screens/edit_details.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final Datum data;

  Details(this.data);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Card(
              elevation: 2,
              margin: EdgeInsets.all(8),
              child: Stack(
                children: <Widget>[
                  ListTile(
                      contentPadding: EdgeInsets.only(top: 22),
                      title: CircleAvatar(
                          child: Text(
                            widget.data.firstName[0],
                            style: TextStyle(fontSize: 48),
                          ),
                          radius: 50),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Text(
                          '${widget.data.firstName} ${widget.data.lastName}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      )),
                  Positioned(
                      right: 22,
                      top: 22,
                      child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditDetails(
                                        widget.data,
                                        from: 0,
                                      ))))),
                ],
              ),
            ),
            Expanded(
              child: Card(
                elevation: 4,
                margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.face),
                      title: Text(widget.data.gender,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      leading: Icon(Icons.date_range),
                      title: Text(widget.data.dateOfBirth,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.phone,
                      ),
                      title: Text(widget.data.phoneNo,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text(widget.data.email,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
