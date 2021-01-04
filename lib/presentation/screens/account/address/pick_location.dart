import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocation extends StatefulWidget {
  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  LocationResult _pickedLocation;
  LocationResult result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body:  Container(
        child: _buildBody(context),
      )
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () async {
              result = await showLocationPicker(
                context,
                'AIzaSyCCVQQw-iYHeqSbqybaXSq0QnlcmZ_e0PE',
                initialCenter: LatLng(31.1975844, 29.9598339),
                myLocationButtonEnabled: true,
                layersButtonEnabled: true,
              );
              print('result = $result');
              setState(() => _pickedLocation = result);
            },
            child: Text('Pick location'),
          ),
          Text(_pickedLocation.toString()),
        ],
      ),
    );
  }
}
