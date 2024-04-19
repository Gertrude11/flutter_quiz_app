import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _pGooglePlex = LatLng(-2.0039, 30.1470);
  static const LatLng _pAuca = LatLng(-1.977027, 30.114861);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(initialCameraPosition: CameraPosition(target: _pGooglePlex,
      zoom: 15),
      markers: {
        Marker(markerId:MarkerId("_currentLocation"),icon: BitmapDescriptor.defaultMarker,position: _pGooglePlex
        ),
        Marker(markerId:MarkerId("_sourceLocation"),icon: BitmapDescriptor.defaultMarker,position: _pAuca
        ),},
      ),
    );
  }
}

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_quiz_app/5_Quiz_App/screens/mapconst.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});
  

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//    Location _locationController = new Location();

//   final Completer<GoogleMapController> _mapController =
//       Completer<GoogleMapController>();
//   static const LatLng _pGooglePlex = LatLng(-2.0039, 30.1470);
//   static const LatLng _pAuca = LatLng(-1.977027, 30.114861);
//     LatLng? _currentP = null;

//   Map<PolylineId, Polyline> polylines = {};

//    @override
//   void initState() {
//     super.initState();
//     getLocationUpdates().then(
//       (_) => {
//         getPolylinePoints().then((coordinates) => {
//               generatePolyLineFromPoints(coordinates),
//             }),
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Location', // Add this line to set the title
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Theme.of(context).primaryColor,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: _currentP == null
//           ? const Center(
//               child: Text("Loading..."),
//             )
//           : GoogleMap(
//               onMapCreated: ((GoogleMapController controller) =>
//                   _mapController.complete(controller)),
//               initialCameraPosition: CameraPosition(
//                 target: _pGooglePlex,
//                 zoom: 13,
//               ),
//               markers: {
//                 Marker(
//                   markerId: MarkerId("_currentLocation"),
//                   icon: BitmapDescriptor.defaultMarker,
//                   position: _currentP!,
//                 ),
//                 Marker(
//                     markerId: MarkerId("_sourceLocation"),
//                     icon: BitmapDescriptor.defaultMarker,
//                     position: _pGooglePlex),
//                 Marker(
//                     markerId: MarkerId("_destionationLocation"),
//                     icon: BitmapDescriptor.defaultMarker,
//                     position: _pAuca)
//               },
//               polylines: Set<Polyline>.of(polylines.values),
//             ),
//     );
//   }

//   Future<void> _cameraToPosition(LatLng pos) async {
//     final GoogleMapController controller = await _mapController.future;
//     CameraPosition _newCameraPosition = CameraPosition(
//       target: pos,
//       zoom: 13,
//     );
//     await controller.animateCamera(
//       CameraUpdate.newCameraPosition(_newCameraPosition),
//     );
//   }

//   Future<void> getLocationUpdates() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await _locationController.serviceEnabled();
//     if (_serviceEnabled) {
//       _serviceEnabled = await _locationController.requestService();
//     } else {
//       return;
//     }

//     _permissionGranted = await _locationController.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _locationController.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _locationController.onLocationChanged
//         .listen((LocationData currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         setState(() {
//           _currentP =
//               LatLng(currentLocation.latitude!, currentLocation.longitude!);
//           _cameraToPosition(_currentP!);
//         });
//       }
//     });
//   }

//   Future<List<LatLng>> getPolylinePoints() async {
//     List<LatLng> polylineCoordinates = [];
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       GOOGLE_MAPS_API_KEY,
//       PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
//       PointLatLng(_pAuca.latitude, _pAuca.longitude),
//       travelMode: TravelMode.driving,
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     return polylineCoordinates;
//   }

//   void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//         polylineId: id,
//         color: Colors.black,
//         points: polylineCoordinates,
//         width: 8);
//     setState(() {
//       polylines[id] = polyline;
//     });
//   }
// }