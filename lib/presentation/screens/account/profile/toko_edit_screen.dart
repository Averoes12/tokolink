import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:tokolink/model/user.dart';
import 'package:tokolink/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:tokolink/presentation/screens/widgets/dashed_divider.dart';
import 'package:tokolink/presentation/screens/widgets/label_widget.dart';
import 'package:http/http.dart' as http;

class TokoEditScreen extends StatefulWidget {
  @override
  _TokoEditScreenState createState() => _TokoEditScreenState();
}

class _TokoEditScreenState extends State<TokoEditScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool keyboardOpen = false;
  bool checked = false;
  SharedPreferences prefs;
  Map<String, String> headers;
  var user;
  bool loading = false;
  bool _loading = false;
  LocationResult _pickedLocation = LocationResult();
  LocationResult result;
  TextEditingController name = TextEditingController();
  String latitude;
  String longitude;
  // TextEditingController phone = TextEditingController();
  // TextEditingController email = TextEditingController();
  @override
  void initState() {
    super.initState();
    keyboardVisibilityListener();
    getData();
  }

  void getData() async{
    setState(() {
      loading = true;
    });
    prefs = await SharedPreferences.getInstance();
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': prefs.getString('storeToken'),
    };
    var response = await http.get(GlobalConstant.BASE_URL+'/user/store', headers: headers);
    final data = jsonDecode(response.body);
    print(data);
    if (response.statusCode != 200) {
      throw Exception(
          'Request failed with status ${response.statusCode}: ${response.body}');
    }else{
      setState(() {
        loading = false;
        user = data['data'];
        name.text = user['name'];
        _pickedLocation.address = user['address'];
        latitude = user['latitude'];
        longitude = user['longitude'];
      });
      
    }
  }

  void saveUser() async {
    setState(() {
      _loading = true;
    });
    prefs = await SharedPreferences.getInstance();
    headers = {
      'Accept': 'application/json',
      'Authorization': prefs.getString('storeToken'),
    };
    final response = await http.post(GlobalConstant.BASE_URL+'/user/storeedit',  headers: headers, body: {
      'name': name.text,
      'address': _pickedLocation.address,
      'latitude': (_pickedLocation?.latLng?.latitude != null) ? _pickedLocation.latLng.latitude.toString() : latitude ,
      'longitude':(_pickedLocation?.latLng?.longitude != null) ? _pickedLocation.latLng.longitude.toString() : longitude,
    });
    //final data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      setState(() {
        _loading = false;
      });
      final snackBar = SnackBar(content: Text('Profil Toko berhasil diperbarui'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Toko'),
        centerTitle: true,
      ),
      body: (loading) ? Center(child:CircularProgressIndicator()) : Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            LabelWidget(text: 'Nama Toko'),
                            TextFormField(
                              controller: name,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                              validator: (v) {
                                if (v.isEmpty) return 'Nama Toko harus diisi';
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Masukkan Nama Toko',
                                prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async{
                        pickCoordinat();
                      },
                      child:Card(
                        child: Padding(
                          padding: EdgeInsets.only(top:10,left:20,right: 20,bottom: 10),
                          child: 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(height: 10),
                              Row(children: [
                                Image.asset('assets/icons/address.png'),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Alamat Toko', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text('Klik untuk merubah alamat toko', style: TextStyle(color: Colors.grey[700], fontSize: 12))
                                  ]
                                )
                                
                              ]),
                              SizedBox(height: 10),
                              DashedDivider(),
                              SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Image.asset('assets/icons/pin.png'),
                                SizedBox(width: 10),
                                Flexible(
                                  child:Text(
                                    _pickedLocation.address,
                                  )
                                )
                              ]),
                              SizedBox(height: 10),
                            ]
                          )
                          ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Visibility(
              visible: !keyboardOpen,
              child: RaisedButton(
                onPressed: () {
                  saveUser();
                },
                textColor: Colors.white,
                child: Text( (_loading) ? 'Loading...' : 'Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void keyboardVisibilityListener() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() => keyboardOpen = visible);
      },
    );
  }

  void pickCoordinat() async {
    result = await showLocationPicker(
      context,
      'AIzaSyAFlSwm3SBlYRqRPiiqEryXxqR9ZWzFmYY',
      initialCenter: LatLng(31.1975844, 29.9598339),
      myLocationButtonEnabled: true,
      layersButtonEnabled: true,
    );
    print('result = $result');
    setState(() => _pickedLocation = result);

    print('picked = $_pickedLocation');
  }
}
class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toLowerCase(),
      selection: newValue.selection,
    );
  }
}