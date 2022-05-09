/*
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vector_math/vector_math.dart';

class HomeScreen extends StatefulWidget {
  static const id = "HOME_SCREEN";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<Marker> _markers = <Marker>[];
  Animation<double>? _animation;
  late GoogleMapController _controller;

  final _mapMarkerSC = StreamController<List<Marker>>();

  StreamSink<List<Marker>> get _mapMarkerSink => _mapMarkerSC.sink;

  Stream<List<Marker>> get mapMarkerStream => _mapMarkerSC.stream;

  @override
  void initState() {
    super.initState();

    //Starting the animation after 1 second.
    Future.delayed(const Duration(seconds: 1)).then((value) {
      animateCar(
        37.42796133580664,
        -122.085749655962,
        37.428714,
        -122.078301,
        _mapMarkerSink,
        this,
        _controller,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLocationCamera = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

    final googleMap = StreamBuilder<List<Marker>>(
        stream: mapMarkerStream,
        builder: (context, snapshot) {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: currentLocationCamera,
            rotateGesturesEnabled: false,
            tiltGesturesEnabled: false,
            mapToolbarEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            markers: Set<Marker>.of(snapshot.data ?? []),
            padding: EdgeInsets.all(8),
          );
        });

    return Scaffold(
      body: Stack(
        children: [
          googleMap,
        ],
      ),
    );
  }

  setUpMarker() async {
    const currentLocationCamera = LatLng(37.42796133580664, -122.085749655962);

    final pickupMarker = Marker(
      markerId: MarkerId("${currentLocationCamera.latitude}"),
      position: LatLng(
          currentLocationCamera.latitude, currentLocationCamera.longitude),
      icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset('asset/icons/ic_car_top_view.png', 70)),
    );

    //Adding a delay and then showing the marker on screen
    await Future.delayed(const Duration(milliseconds: 500));

    _markers.add(pickupMarker);
    _mapMarkerSink.add(_markers);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  animateCar(
      double fromLat, //Starting latitude
      double fromLong, //Starting longitude
      double toLat, //Ending latitude
      double toLong, //Ending longitude
      StreamSink<List<Marker>>
      mapMarkerSink, //Stream build of map to update the UI
      TickerProvider
      provider, //Ticker provider of the widget. This is used for animation
      GoogleMapController controller, //Google map controller of our widget
      ) async {
    final double bearing =
    getBearing(LatLng(fromLat, fromLong), LatLng(toLat, toLong));

    _markers.clear();

    var carMarker = Marker(
        markerId: const MarkerId("driverMarker"),
        position: LatLng(fromLat, fromLong),
        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset('asset/icons/ic_car_top_view.png', 60)),
        anchor: const Offset(0.5, 0.5),
        flat: true,
        rotation: bearing,
        draggable: false);

    //Adding initial marker to the start location.
    _markers.add(carMarker);
    mapMarkerSink.add(_markers);

    final animationController = AnimationController(
      duration: const Duration(seconds: 5), //Animation duration of marker
      vsync: provider, //From the widget
    );

    Tween<double> tween = Tween(begin: 0, end: 1);

    _animation = tween.animate(animationController)
      ..addListener(() async {
        //We are calculating new latitude and logitude for our marker
        final v = _animation!.value;
        double lng = v * toLong + (1 - v) * fromLong;
        double lat = v * toLat + (1 - v) * fromLat;
        LatLng newPos = LatLng(lat, lng);

        //Removing old marker if present in the marker array
        if (_markers.contains(carMarker)) _markers.remove(carMarker);

        //New marker location
        carMarker = Marker(
            markerId: const MarkerId("driverMarker"),
            position: newPos,
            icon: BitmapDescriptor.fromBytes(
                await getBytesFromAsset('asset/icons/ic_car_top_view.png', 50)),
            anchor: const Offset(0.5, 0.5),
            flat: true,
            rotation: bearing,
            draggable: false);

        //Adding new marker to our list and updating the google map UI.
        _markers.add(carMarker);
        mapMarkerSink.add(_markers);

        //Moving the google camera to the new animated location.
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: newPos, zoom: 15.5)));
      });

    //Starting the animation
    animationController.forward();
  }

  double getBearing(LatLng begin, LatLng end) {
    double lat = (begin.latitude - end.latitude).abs();
    double lng = (begin.longitude - end.longitude).abs();

    if (begin.latitude < end.latitude && begin.longitude < end.longitude) {
      return degrees(atan(lng / lat));
    } else if (begin.latitude >= end.latitude &&
        begin.longitude < end.longitude) {
      return (90 - degrees(atan(lng / lat))) + 90;
    } else if (begin.latitude >= end.latitude &&
        begin.longitude >= end.longitude) {
      return degrees(atan(lng / lat)) + 180;
    } else if (begin.latitude < end.latitude &&
        begin.longitude >= end.longitude) {
      return (90 - degrees(atan(lng / lat))) + 270;
    }
    return -1;
  }
}*/
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

//Setting dummies values
// const kStartPosition = LatLng(18.488213, -69.959186);
const kStartPosition = LatLng(23.080245599999998, 72.5243763);
var kSantoDomingo = CameraPosition(target: kStartPosition, zoom: 14);
var kMarkerId = MarkerId('MarkerId1');
var kDuration = Duration(milliseconds: 800);
/*const kLocations = [
  kStartPosition,
  LatLng(18.488101, -69.957995),
  LatLng(18.489210, -69.952459),
  LatLng(18.487307, -69.952759),
  LatLng(18.487308, -69.952759),
];*/
var kLocations = [];
/*var kLocations = [
  kStartPosition,
LatLng(23.08017, 72.52468),
LatLng(23.07962, 72.52452),
LatLng(23.07938, 72.52543),
LatLng(23.08047, 72.52576),
LatLng(23.08033, 72.52626),
LatLng(23.08232, 72.52684),
LatLng(23.08366, 72.52723),
LatLng(23.08464, 72.52761),
LatLng(23.08545, 72.52782),
LatLng(23.08549, 72.52766),
LatLng(23.08668, 72.52798),
LatLng(23.08644, 72.52838),
LatLng(23.08638, 72.52862),
LatLng(23.08631, 72.52931),
LatLng(23.08623, 72.53012),
LatLng(23.08619, 72.53029),
LatLng(23.0861, 72.53046),
LatLng(23.08597, 72.53058),
LatLng(23.0852, 72.53119),
LatLng(23.08488, 72.53144),
LatLng(23.08441, 72.53187),
LatLng(23.08387, 72.53238),
LatLng(23.08274, 72.53351),
LatLng(23.08217, 72.53408),
LatLng(23.08184, 72.53448),
LatLng(23.08111, 72.53543),
LatLng(23.08093, 72.5356),
LatLng(23.08001, 72.53607),
LatLng(23.07956, 72.53634),
LatLng(23.07873, 72.53692),
LatLng(23.07792, 72.53749),
LatLng(23.07712, 72.53807),
LatLng(23.0767, 72.53841),
LatLng(23.07669, 72.53843),
LatLng(23.07668, 72.53846),
LatLng(23.07666, 72.53848),
LatLng(23.0766, 72.53849),
LatLng(23.07655, 72.53847),
LatLng(23.07652, 72.53841),
LatLng(23.07653, 72.53835)
];*/

class SimpleMarkerAnimationExample extends StatefulWidget {
  @override
  SimpleMarkerAnimationExampleState createState() =>
      SimpleMarkerAnimationExampleState();
}

class SimpleMarkerAnimationExampleState
    extends State<SimpleMarkerAnimationExample> {


  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyClF9LiY6ePi8NUmO1VG8x-wFURFVCyNrU";

  Set<Marker> marker = Set(); //markers for google map

  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = const LatLng(23.080245599999998, 72.5243763);
  LatLng endLocation = const LatLng(23.07652, 72.53832899999999);
  late LatLngBounds bounds;



  final markers = <MarkerId, Marker>{};
  final controller = Completer<GoogleMapController>();


  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: startLocation)));
    // mapController?.animateCamera(u);
    LatLngBounds l1=await c.getVisibleRegion();
    LatLngBounds l2=await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if(l1.southwest.latitude==-90 ||l2.southwest.latitude==-90)
      check(u, c);
  }

  getDirections(GoogleMapController gController) async {
  // getDirections() async {
    List<LatLng> polylineCoordinates = [];

    var url = Uri.parse('http://kayaapi.appsara.in/KayaService.svc/getgoogledirections/${startLocation.latitude}/${startLocation.longitude}/${endLocation.latitude}/${endLocation.longitude}/');
    var response = await http.get(url);
    var json = jsonDecode(response.body);

    var latLongLis = json["googleresponse"]["routes"][0]["overview_polyline"]["points"];
    print("_____"+latLongLis);

    List<PointLatLng> points = NetworkUtil().decodeEncodedPolyline(json["googleresponse"]["routes"][0]["overview_polyline"]["points"]);
    int i = 0;
    kLocations.clear();
    points.forEach((element) {
      // print("_____________"+element.latitude.toString());
      polylineCoordinates.add(LatLng(element.latitude, element.longitude));
      print("LatLng(${element.latitude}, ${element.longitude}");
      if((points.length -1) == i)
      {
        // print("LatLng(${element.latitude}, ${element.longitude}");
        setState(() {
        addPolyLine(polylineCoordinates);
        });
      }

      kLocations.add(LatLng(element.latitude, element.longitude));
      if((points.length -1) == i)
      {
        print("=-=-=====================>"+kLocations.length.toString());
        setState(() {
          var stream = Stream.periodic(kDuration, (count) => kLocations[count]).take(kLocations.length);
          stream.forEach((value) => newLocationUpdate(value));
          controller.complete(gController);
          // stream = Stream.periodic(kDuration, (count) => kLocations[count])
          //     .take(kLocations.length);
        });}
      i=i+1;
    });
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
    });


  }
  @override
  void initState() {
    super.initState();
    bounds = LatLngBounds(southwest: endLocation, northeast: startLocation);
    marker.add(Marker( //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    marker.add(Marker( //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Markers Animation Example',
      home: Animarker(
        shouldAnimateCamera: true,

        rippleRadius: 0.2,
        useRotation: true,
        mapId: controller.future
            .then<int>((value) => value.mapId), //Grab Google Map Id
        markers: markers.values.toSet(),
        child: GoogleMap(
            mapType: MapType.normal,
            markers: marker,
            initialCameraPosition: kSantoDomingo,
            polylines: Set<Polyline>.of(polylines.values),
            onMapCreated: (gController) {
              getDirections(gController);
            }),
      ),
    );
  }

  Future<void> newLocationUpdate(LatLng latLng) async {
    final bitmapIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(10,10)), 'assets/images/car1.png');
    var marker = Marker(
        markerId: kMarkerId,
        position: latLng,
         icon: bitmapIcon ,
        onTap: () {
          print('Tapped! $latLng');
        });

    setState(() => markers[kMarkerId] = marker);
  }
}


