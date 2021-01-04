import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:tokolink/model/address.dart';
import 'address_add_screen.dart';

class AddressScreen extends StatefulWidget {
  final bool isedit;

  const AddressScreen({
    Key key,
    this.isedit,
  }) : super(key: key);
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<Address> listAddress = [];
  Map<String, String> headers;
  bool _addressLoading = false;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _getToken();
  }
  void _getToken() async{
    setState(() {
      _addressLoading = true;
    });
    prefs = await SharedPreferences.getInstance();
    setState(() {
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': prefs.getString('token'),
      };
      _getAddress();
    });
  }
  void _getAddress() async{
    var response = await http.get(GlobalConstant.BASE_URL+'/address', headers: headers);
    final data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Exception(
          'Request failed with status ${response.statusCode}: ${response.body}');
    }else{
      setState(() {
        _addressLoading = false;
        if(data['data'] != null){
          for (Map i in data['data']) {
            listAddress.add(Address.fromJson(i));
          }
        }
        //_getShipping(defaultAddress.district.idDistrict);
      });
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
        centerTitle: true,
      ),
      body: (_addressLoading) ? Center(child:CircularProgressIndicator() ): Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: listAddress.length,
                itemBuilder: (context, i) {
                  return Column(children: [
                    address(listAddress[i]),
                    SizedBox(height: 20),
                  ]);
                }
              ),
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

  Widget address(Address address){
    return  GestureDetector(
      onTap: (){
        if(widget.isedit){

        }else{
          Navigator.pop(context, address);
        }
      },
      child:Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                Text(address.name, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                Text((address.isprimary == '1') ? '(Primary)' : '')
              ]),
              SizedBox(height: 5),
              Text(address.phone),
              SizedBox(height: 5),
              Text(address.address, style: TextStyle(color: Colors.grey)),
            ]
          )
        ),
      )
    );
  }
  
}
