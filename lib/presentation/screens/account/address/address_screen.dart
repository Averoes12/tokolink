import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/presentation/screens/widgets/label_widget.dart';

import 'address_add_screen.dart';
import 'address_edit_screen.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      LabelWidget(text: 'Full name'),
                      TextFormField(
                        enabled: false,
                        initialValue: 'John Doe',
                      ),
                      SizedBox(height: 10),
                      LabelWidget(text: 'Telephone number'),
                      TextFormField(
                        enabled: false,
                        initialValue: '081234567890',
                      ),
                      SizedBox(height: 10),
                      LabelWidget(text: 'Address'),
                      TextFormField(
                        enabled: false,
                        maxLines: 4,
                        initialValue: 'Lorem ipsum dolor si amet',
                      ),
                      SizedBox(height: 10),
                      RaisedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddressEditScreen())),
                        textColor: Colors.white,
                        child: Text('Edit'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: DottedBorder(
                    strokeWidth: 3,
                    color: ColorConfig.N3,
                    dashPattern: [12, 12],
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddressAddScreen())),
                        textColor: ColorConfig.N3,
                        child: Text('Add New Address'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
