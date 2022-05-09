import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(4.082782, 9.7563399),
    zoom: 11.5,
  );

  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  // Directions _info;

  // List<Placema>

  var latitude;
  var longitude;
  var position;
  var locationMessage = "";

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  void getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lats = position.latitude;
    var longs = position.longitude;

    setState(() {
      locationMessage = "latitude : $lats and longitude: $longs";

      latitude = lats;
      longitude = longs;
    });

    print("**********Location ${locationMessage}");
  }

  void getAddress(double latitude, double longitude) async
  {

  }

  Set<Marker> _createMarker()
  {
    return <Marker> [
      Marker(
        markerId: MarkerId("home"),
        position: LatLng(latitude, longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "Home", snippet: "Patrick")
      ),
    ].toSet();
  }

  void initMarker(request, requestId)
  {
    var markerIdVal = requestId;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(request["position"].latitude, request["position"].longitude),
      infoWindow: InfoWindow(title: "Nom de la société : ${request["localisation_entreprise"]}", snippet: " Lieu: ${request["quartier_entreprise"]}, ${request["quartier_entreprise"]}")
    );

    setState(() {
      markers[markerId] = marker;
      print("*******Markerss ${markerId}");
    });
  }

  populateClients()
  {
    Firestore.instance.collection("formulaire").getDocuments().then((value) {
      if(value.documents.isNotEmpty)
        {
          for(int i =0; i< value.documents.length; i++)
            {
              if(value.documents[i]["position"] != null)
                {
                  initMarker(value.documents[i].data, value.documents[i].documentID);
                }
            }
        }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    populateClients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Lieux d'enregistrement"),
        actions: [
          // if (_origin != null)
          //   TextButton(
          //     onPressed: () => _googleMapController.animateCamera(
          //       CameraUpdate.newCameraPosition(
          //         CameraPosition(
          //           target: _origin.position,
          //           zoom: 14.5,
          //           tilt: 50.0,
          //         ),
          //       ),
          //     ),
          //     style: TextButton.styleFrom(
          //       primary: Colors.green,
          //       textStyle: const TextStyle(fontWeight: FontWeight.w600),
          //     ),
          //     child: const Text('ORIGIN'),
          //   ),
          // if (_destination != null)
          //   TextButton(
          //     onPressed: () => _googleMapController.animateCamera(
          //       CameraUpdate.newCameraPosition(
          //         CameraPosition(
          //           target: _destination.position,
          //           zoom: 14.5,
          //           tilt: 50.0,
          //         ),
          //       ),
          //     ),
          //     style: TextButton.styleFrom(
          //       primary: Colors.blue,
          //       textStyle: const TextStyle(fontWeight: FontWeight.w600),
          //     ),
          //     child: const Text('DEST'),
          //   )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(latitude ?? 4.082782, longitude ?? 9.7563399 ),
              zoom: 12.0
            ),
            onMapCreated: (controller) => _googleMapController = controller,
            markers: Set<Marker>.of(markers.values),
            // polylines: {
            //   if (_info != null)
            //     Polyline(
            //       polylineId:  PolylineId('overview_polyline'),
            //       color: Colors.red,
            //       width: 5,
            //       points: _info.polylinePoints
            //           .map((e) => LatLng(e.latitude, e.longitude))
            //           .toList(),
            //     ),
            // },

            onLongPress: _addMarker,
          ),
          // if (_info != null)
          //   Positioned(
          //     top: 20.0,
          //     child: Container(
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 6.0,
          //         horizontal: 12.0,
          //       ),
          //       decoration: BoxDecoration(
          //         color: Colors.yellowAccent,
          //         borderRadius: BorderRadius.circular(20.0),
          //         boxShadow: const [
          //           BoxShadow(
          //             color: Colors.black26,
          //             offset: Offset(0, 2),
          //             blurRadius: 6.0,
          //           )
          //         ],
          //       ),
          //       child: Text(
          //         '{_info.totalDistance}, {_info.totalDuration}',
          //         style: const TextStyle(
          //           fontSize: 18.0,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          // _info != null
          //     ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
          //     :
        CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(latitude ?? 4.082782, longitude ?? 9.7563399 ),
            zoom: 12.0
        )),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId:  MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        // _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId:  MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get directions
      // final directions = await DirectionsRepository()
      //     .getDirections(origin: _origin.position, destination: pos);
      // setState(() => _info = directions);
    }
  }
}
