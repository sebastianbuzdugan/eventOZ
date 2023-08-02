// import 'package:flutter/material.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:loginv1/constants/theme.dart';
// import '../../services/location.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class HomeMap extends StatefulWidget {
//   @override
//   _HomeMapState createState() => _HomeMapState();
// }

// class _HomeMapState extends State<HomeMap> {
//   Set<Marker> _markers = {};
//   MyLocation _location = MyLocation();

//   Future<Map<String, dynamic>> _getDirections(
//       LatLng origin, LatLng destination) async {
//     String url =
//         'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=walking&key=$googleApikey';
//     http.Response response = await http.get(Uri.parse(url));
//     Map<String, dynamic> data = jsonDecode(response.body);
//     return data;
//   }

//   void _updateMarkers(LatLng position, String location) {
//     setState(() {
//       _markers.add(
//         Marker(
//           markerId: MarkerId(location),
//           position: position,
//           infoWindow: InfoWindow(title: location),
//         ),
//       );
//     });
//   }

//   void _goToCurrentLocation() async {
//     await _location.getCurrentLocation();
//     mapController?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(_location.latitude, _location.longitude),
//           zoom: 15.0,
//         ),
//       ),
//     );
//   }

//   String googleApikey = "AIzaSyDfj1IMdmkXlY1NiQ_FJyYxp768-5FCrVA";
//   GoogleMapController? mapController; //contrller for Google map
//   CameraPosition? cameraPosition;
//   LatLng startLocation = LatLng(46.7571383, 23.5265539);
//   String location = 'searchLoc'.tr;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('currentLoc'.tr),
//           backgroundColor: primaryClr,
//           actions: [
//             IconButton(
//               icon: Icon(Icons.my_location),
//               onPressed: _goToCurrentLocation,
//             ),
//           ],
//         ),
//         body: Stack(children: [
//           GoogleMap(
//             //Map widget from google_maps_flutter package
//             myLocationButtonEnabled: false,
//             markers: _markers,
//             zoomGesturesEnabled: true, //enable Zoom in, out on map
//             initialCameraPosition: CameraPosition(
//               //innital position in map
//               target: startLocation, //initial position
//               zoom: 15.0, //initial zoom level
//             ),
//             mapType: MapType.normal, //map type
//             onMapCreated: (controller) {
//               //method called when map is created
//               setState(() {
//                 mapController = controller;
//               });
//             },
//           ),

//           //search autoconplete input
//           Positioned(
//               //search input bar
//               top: 10,
//               child: InkWell(
//                   onTap: () async {
//                     var place = await PlacesAutocomplete.show(
//                         context: context,
//                         apiKey: googleApikey,
//                         mode: Mode.overlay,
//                         types: [],
//                         strictbounds: false,
//                         components: [Component(Component.country, 'ro')],
//                         //google_map_webservice package
//                         onError: (err) {
//                           print(err);
//                         });

//                     if (place != null) {
//                       setState(() {
//                         location = place.description.toString();
//                       });

//                       //form google_maps_webservice package
//                       final plist = GoogleMapsPlaces(
//                         apiKey: googleApikey,
//                         apiHeaders: await GoogleApiHeaders().getHeaders(),
//                         //from google_api_headers package
//                       );
//                       String placeid = place.placeId ?? "0";
//                       final detail = await plist.getDetailsByPlaceId(placeid);
//                       final geometry = detail.result.geometry!;
//                       final lat = geometry.location.lat;
//                       final lang = geometry.location.lng;
//                       var newlatlang = LatLng(lat, lang);

//                       //move map camera to selected place with animation
//                       mapController?.animateCamera(
//                           CameraUpdate.newCameraPosition(
//                               CameraPosition(target: newlatlang, zoom: 15)));
//                       _updateMarkers(newlatlang, location);
//                       Map<String, dynamic> directions = await _getDirections(
//                         LatLng(_location.latitude, _location.longitude),
//                         newlatlang,
//                       );

//                       if (directions['status'] == 'OK') {
//                         String duration = directions['routes'][0]['legs'][0]
//                             ['duration']['text'];
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                               content:
//                                   Text('Estimated travel time: $duration')),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('No route found')),
//                         );
//                       }
//                     }
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.all(15),
//                     child: Card(
//                       child: Container(
//                           padding: EdgeInsets.all(0),
//                           width: MediaQuery.of(context).size.width - 40,
//                           child: ListTile(
//                             title: Text(
//                               location,
//                               style: TextStyle(fontSize: 18),
//                             ),
//                             trailing: Icon(Icons.search),
//                             dense: true,
//                           )),
//                     ),
//                   )))
//         ]));
//   }
// }
