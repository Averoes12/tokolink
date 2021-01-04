import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:tokolink/presentation/screens/widgets/label_widget.dart';
import 'package:http/http.dart' as http;
import 'package:tokolink/presentation/utils/mixins/has_form_key_mixin.dart';

class AddressAddScreen extends StatefulWidget {
  @override
  _AddressAddScreenState createState() => _AddressAddScreenState();
}

class _AddressAddScreenState extends State<AddressAddScreen> with HasFormKeyMixin{
  bool keyboardOpen = false;
  bool checked = false;
  LocationResult _pickedLocation = LocationResult();
  LocationResult result;
  String _name = '';
  String _phone = '';
  bool _loading = false;
  Map<String, String> headers;
  SharedPreferences prefs;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  void initState() {
    super.initState();
    keyboardVisibilityListener();
  }

  void registerUser() async {
    setState(() {
      _loading = true;
    });
    prefs = await SharedPreferences.getInstance();
    headers = {
      'Accept': 'application/json',
      'Authorization': prefs.getString('token'),
    };
    final response = await http.post(GlobalConstant.BASE_URL+'/address/', headers: headers, body: {
      'name': name.text,
      'phone': phone.text,
      'address': _pickedLocation.address ,
      'latitude': _pickedLocation.latLng.latitude.toString() ,
      'longitude': _pickedLocation.latLng.longitude.toString()
    });
    //final data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      setState(() {
        _loading = false;
      });
      await Navigator.pop(context, 'new_address');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
        centerTitle: true,
      ),
      body: Container(
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
                        padding: EdgeInsets.all(10),
                        child:  Form(
                          key: fk,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              LabelWidget(text: 'Nama Lengkap'),
                              TextFormField(
                                autofocus: true,
                                controller: name,
                                enabled: true,
                                style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                                validator: (v) {
                                  if (v.isEmpty) return 'Nama harus diisi';
                                  return null;
                                },
                                onSaved: (v) => setState(() => _name = v),
                                decoration: InputDecoration(hintText: 'Nama lengkap penerima'),
                              ),
                              SizedBox(height: 10),
                              LabelWidget(text: 'Nomor Telepon'),
                              TextFormField(
                                autofocus: true,
                                controller: phone,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                                validator: (v) {
                                  if (v.isEmpty) return 'Nomor diperlukan';
                                  if (v.substring(0, 1) == '0' || v.length < 10 || v.length > 12) return 'Format nomer salah';
                                  return null;
                                },
                                onSaved: (v) => setState(() => _phone = v),
                                decoration: InputDecoration(
                                  prefixText: '+62 | ',
                                  hintText: 'Phone number',
                                  prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                                ),
                              ),
                              SizedBox(height: 20),
                              (_pickedLocation.address != null) ?
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
                                ])
                              : RaisedButton(
                                onPressed: () {
                                  pickCoordinat();
                                },
                                textColor: Colors.white,
                                child: Text('Pilih koordinat'),
                              ),

                              SizedBox(height: 10),
                            ],
                          ),
                        )
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            LabelWidget(
                              text: 'Set as primary',
                            ),
                            Checkbox(value: checked, onChanged: (v) => setState(() => checked = v)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !keyboardOpen,
              child: RaisedButton(
                onPressed: () {
                  if (fk.currentState.validate()) {
                    (_pickedLocation.address != null) ?
                    registerUser()
                    : null;
                  }
                },
                color: (_pickedLocation.address != null) ? ColorConfig.PRIMARY : Colors.grey[300],
                textColor: Colors.white,
                child: (_loading) ? Text('Loading ...'): Text('Simpan'),
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
