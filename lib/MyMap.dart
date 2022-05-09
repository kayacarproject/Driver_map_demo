/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  final Set<Marker> _markers1 = {};
  final Set<Marker> _markers2 = {};
  final Set<Polyline>_polyline={};


  LatLng _lastMapPosition = _center;
  List<LatLng> latlng = [];
  */
/*LatLng _Start = LatLng(33.738045, 73.084488);
  LatLng _End = LatLng(33.567997728, 72.635997456);*//*

  double startLat = 23.551904;
  double startLng = 90.532171;
  double endLat = 23.560625;
  double endLng = 90.531813;
  

  MapType _currentMapType = MapType.normal;

  */
/*void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }*//*


  void _onAddMarker() {
    setState(() {
      */
/*_markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));*//*


      _markers1.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: LatLng(startLat, startLng),
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,

      )
      );

      _markers2.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: LatLng(endLat, endLng),
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,

      ));

      _polyline.add(Polyline(
        polylineId: PolylineId(_lastMapPosition.toString()),
        visible: true,
        //latlng is List<LatLng>
        points: latlng,
        color: Colors.blue,
      ));
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onAddMarker();
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              polylines: _polyline,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
              mapType: _currentMapType,
              onCameraMove: _onCameraMove,
            ),
            */
/*Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget> [
                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.add_location, size: 36.0),
                    ),
                  ],
                ),
              ),
            ),*//*

          ],
        ),
      ),
    );
  }
}*/

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MyMap extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyClF9LiY6ePi8NUmO1VG8x-wFURFVCyNrU";

  Set<Marker> markers = Set(); //markers for google map
  Set<Circle> circles = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = const LatLng(23.080245599999998, 72.5243763);
  LatLng endLocation = const LatLng(23.07652, 72.53832899999999);
  late LatLngBounds bounds;



  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    mapController?.animateCamera(u);
    LatLngBounds l1=await c.getVisibleRegion();
    LatLngBounds l2=await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if(l1.southwest.latitude==-90 ||l2.southwest.latitude==-90) {
      check(u, c);
    }
  }

  @override
  void initState() {
    bounds = LatLngBounds(southwest: endLocation, northeast: startLocation);
    markers.add(Marker( //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow( //popup info 
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker( //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow( //popup info 
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));



    getDirections();
    //fetch direction polylines from Google API

    super.initState();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    var url = Uri.parse('http://kayaapi.appsara.in/KayaService.svc/getgoogledirections/${startLocation.latitude}/${startLocation.longitude}/${endLocation.latitude}/${endLocation.longitude}/');
    var response = await http.get(url);
print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


    var json = jsonDecode(response.body);
    print("_____"+json["googleresponse"]["routes"][0]["overview_polyline"]["points"]);

    List<PointLatLng> points = NetworkUtil().decodeEncodedPolyline(json["googleresponse"]["routes"][0]["overview_polyline"]["points"]);
    int i = 0;
    points.forEach((element) {
      print("_____________"+element.latitude.toString());
      polylineCoordinates.add(LatLng(element.latitude, element.longitude));
      if((points.length -1) == i)
        {
          print("=-=--==-=done=-=-=-=");
          addPolyLine(polylineCoordinates);
        }
      i=i+1;
    });
    // print(await http.read(Uri.parse('http://kayaapi.appsara.in/KayaService.svc/getgoogledirections/23.080245599999998/72.5243763/23.07652/72.53832899999999/')));

PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );
    print("====-------=====");
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print("========="+result.errorMessage.toString());
    }

    // polylineCoordinates.add(startLocation);
    // polylineCoordinates.add(endLocation);

  }


  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    // if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
    if (l1.southwest.latitude == 90 || l2.southwest.latitude == 90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    setState(() {
     /* CameraUpdate u2 = CameraUpdate.newLatLngBounds(bounds, 20);
      this.mapController?.animateCamera(u2).then((void v){
        checkCameraLocation(u2, mapController!);
        // check(u2,mapController!);
      });*/


    });


  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Route Direction in Google Map"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: GoogleMap(
        // cameraTargetBounds: CameraTargetBounds.unbounded,
         padding: const EdgeInsets.all(100),//Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition( //innital position in map
          target: startLocation, //initial position
          zoom: 14.0, //initial zoom level
        ),
        markers: markers, //markers to show on map
        polylines: Set<Polyline>.of(polylines.values), //polylines
        mapType: MapType.normal, //map type
        onMapCreated: (controller) { //method called when map is created
          setState(() {
            mapController = controller;
            setState(() {
              // controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
            });
          });
        },
      ),
    );
  }
}
