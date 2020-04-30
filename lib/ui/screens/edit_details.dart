import 'package:contact_manager/blocs/user_bloc.dart';
import 'package:contact_manager/models/user_model.dart';
import 'package:contact_manager/ui/screens/home_page.dart';
import 'package:contact_manager/utils/utils.dart';
import 'package:flutter/material.dart';

class EditDetails extends StatefulWidget {
  final Datum data;
  final from;

  EditDetails(this.data, {this.from});

  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  String selectedGender;
  String _gender;
  List dropDownList = ['Male', 'female', 'Transgender'];
  TextEditingController _dobController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.from == 0) {
      _dobController.text = widget.data.dateOfBirth;
      _mobileController.text = widget.data.phoneNo;
      _emailController.text = widget.data.email;
      _fnameController.text = widget.data.firstName;
      _lnameController.text = widget.data.lastName;
      _gender = widget.data.gender;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.only(top: 18),
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.looks_one,
                  ),
                  title: TextFormField(
                    controller: _fnameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        helperText: 'Enter first name',
                        hintText: 'Enter firstname'),
                    validator: (value) {
                      return validate(value);
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.looks_two,
                  ),
                  title: TextFormField(
                    controller: _lnameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        helperText: 'Enter last name',
                        hintText: 'Enter last name'),
                    validator: (value) {
                      return validate(value);
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8),
                  leading: Icon(Icons.face),
                  title: DropdownButton<String>(
                      isExpanded: true,
                      hint: new Text(widget.from == 0
                          ? "${widget.data.gender}"
                          : "Select gender"),
                      value: selectedGender,
                      onChanged: (String newValue) {
                        setState(() {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          selectedGender = newValue;
                          _gender = newValue;
                        });
                      },
                      items: dropDownList.map((gender) {
                        return new DropdownMenuItem<String>(
                          value: gender,
                          child: new Text(
                            gender,
                            style: new TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList()),
                ),
                ListTile(
                  leading: Icon(Icons.date_range),
                  title: TextFormField(
                    controller: _dobController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      hintText: 'Enter DOB',
                      helperText: 'Enter DOB',
                    ),
                    validator: (value) {
                      return validate(value);
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                  ),
                  title: TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Mobile number',
                      helperText: 'Enter mobile number',
                    ),
                    validator: (value) {
                      return validate(value);
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter Email',
                      helperText: 'Enter email',
                    ),
                    validator: (value) {
                      return validate(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Save'),
          icon: Icon(Icons.save),
          isExtended: true,
          onPressed: () {
            if (_formKey.currentState.validate() && _gender != null) {
              showToast('Saving data. Please wait....');
              if (widget.from == 0) {
                userBloc
                    .editUser(
                        widget.data.id,
                        Datum(
                            id: '',
                            dateOfBirth: _dobController.text,
                            email: _emailController.text,
                            firstName: _fnameController.text,
                            lastName: _lnameController.text,
                            gender: selectedGender ?? _gender,
                            phoneNo: _mobileController.text))
                    .then((onValue) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                });
              } else {
                userBloc
                    .addUser(Datum(
                        id: '',
                        dateOfBirth: _dobController.text,
                        email: _emailController.text,
                        firstName: _fnameController.text,
                        lastName: _lnameController.text,
                        gender: selectedGender ?? _gender,
                        phoneNo: _mobileController.text))
                    .then((onValue) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                });
              }
            } else {
              showToast('Please select all filed');
            }
          },
        ),
      ),
    );
  }

  validate(String value) {
    if (value.isEmpty) {
      return 'name must be 5 to 15 characters only';
    }
    return null;
  }
}
