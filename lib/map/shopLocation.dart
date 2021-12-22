import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopLocation extends StatefulWidget {
  @override
  _ShopLocationState createState() => _ShopLocationState();
}

class _ShopLocationState extends State<ShopLocation> {
  BitmapDescriptor customIcon;
  Set<Marker> markers = HashSet<Marker>();
  GoogleMapController _controller;
  BitmapDescriptor _markerIcon;

  void initState() {
    super.initState();
    _setMarkerIcon();
    markers = Set.from([]);
  }

  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(26.663965, 87.274050), zoom: 22);

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/shopLocation.png');
  }

  void _onMapCreated(controller) {
    controller = controller;
    setState(() {
      markers.add(Marker(
          markerId: MarkerId('0'),
          position: LatLng(26.663965, 87.274050),
          infoWindow: InfoWindow(
            title: "Hello Mobiile Serve",
            snippet: "A Complete Solution For Your Mobile Devices",
          ),
          icon: _markerIcon));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _initialPosition,
        mapType: MapType.normal,
        // onMapCreated: (controller) {
        //   setState(() {
        //     _controller = controller;
        //   });
        // },
        markers: markers,
        onTap: (cordinate) {
          _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
          _onMapCreated(cordinate);
        },
      ),
    );
  }
}

// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FlutterMap(
//           options: MapOptions(
//             center: LatLng(26.664009649934286, 87.27406291353203),
//             zoom: 13.0,
//           ),
//           layers: [
//             // MarkerLayerOptions(
//             //   markers: [
//             //     Marker(
//             //       width: 80.0,
//             //       height: 80.0,
//             //       point: LatLng(26.664009649934286, 87.27406291353203),
//             //       builder: (ctx) => Container(
//             //         child: Icon(Icons.location_city),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//           ],
//           children: <Widget>[
//             TileLayerWidget(
//                 options: TileLayerOptions(
//                     urlTemplate:
//                         "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                     subdomains: ['a', 'b', 'c'])),
//             MarkerLayerWidget(
//                 options: MarkerLayerOptions(
//               markers: [
//                 Marker(
//                   width: 80.0,
//                   height: 80.0,
//                   point: LatLng(26.663951568831333, 87.27410580646833),
//                   builder: (ctx) => Container(
//                     child: Row(
//                       children: [
//                         Icon(Icons.location_on),
//                         Text("Hello Mobiles")
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
