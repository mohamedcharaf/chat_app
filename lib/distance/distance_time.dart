// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'dart:async';

// class Location {
//   final String name;
//   final double latitude;
//   final double longitude;

//   Location(this.name, this.latitude, this.longitude);
// }

// double calculateDistance(Location start, Location end) {
//   const double earthRadius = 6371; // Rayon de la Terre en kilomètres

//   double lat1 = start.latitude * pi / 180;
//   double lon1 = start.longitude * pi / 180;
//   double lat2 = end.latitude * pi / 180;
//   double lon2 = end.longitude * pi / 180;

//   double dLat = lat2 - lat1;
//   double dLon = lon2 - lon1;

//   double a = sin(dLat / 2) * sin(dLat / 2) +
//       cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
//   double c = 2 * atan2(sqrt(a), sqrt(1 - a));

//   double distance = earthRadius * c;
//   return distance; // Distance en kilomètres
// }

// List<String> citiesWithinDistance(Location myLocation, List<Location> locations, double maxDistance) {
//   List<String> cities = [];

//   for (var location in locations) {
//     double distance = calculateDistance(myLocation, location);
//     if (distance < maxDistance) {
//       cities.add(location.name);
//     }
//   }

//   return cities;
// }

// void main() {
//   Location myLocation = Location('Moi', 35.2933460731414, -1.1215377855695916); // Votre emplacement actuel
//   List<Location> locations = [
//     Location('hbh', 35.45624251107189, -1.0581233715396985), // Los Angeles
//     Location('Targa', 35.41665454358637, -1.1771896530016388), // London
//     Location('Maleh', 35.39120532287769, -1.0959209245858543),
//     Location('chabat', 35.339436438976946, -1.0966455757040106),
//     Location('sidi ben adda', 35.303685624501384, -1.1812317207464018),
//     Location('ain tolba', 35.24952191564295, -1.247908797569665),
//     // Ajoutez plus d'emplacements au besoin
//   ];

//   runApp(MyApp(myLocation: myLocation, allLocations: locations));
// }

// class MyApp extends StatefulWidget {
//   final Location myLocation;
//   final List<Location> allLocations;

//   MyApp({required this.myLocation, required this.allLocations});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<String> _citiesWithinDistance = [];
//   int _currentDistanceIndex = 0;
//   List<double> _distances = [6, 10, 13, 17, 20];
//   bool _isLoading = false;
//   double _initialDistance = 6;

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> _startSearchingCities() async {
//     setState(() {
//       _isLoading = true;
//       _currentDistanceIndex = _distances.indexOf(_initialDistance);
//     });

//     for (int i = _currentDistanceIndex; i < _distances.length; i++) {
//       double distance = _distances[i];
//       await Future.delayed(Duration(seconds: 10));
//       setState(() {
//         _citiesWithinDistance = citiesWithinDistance(widget.myLocation, widget.allLocations, distance);
//         _currentDistanceIndex = i;
//       });
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Villes dans une distance sélectionnée'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               DropdownButton<double>(
//                 value: _initialDistance,
//                 items: _distances.map((distance) {
//                   return DropdownMenuItem<double>(
//                     value: distance,
//                     child: Text('$distance km'),
//                   );
//                 }).toList(),
//                 onChanged: (double? newValue) {
//                   if (newValue != null) {
//                     setState(() {
//                       _initialDistance = newValue;
//                     });
//                   }
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _startSearchingCities,
//                 child: Text('Chercher'),
//               ),
//               SizedBox(height: 20),
//               _isLoading
//                   ? CircularProgressIndicator()
//                   : _currentDistanceIndex < _distances.length
//                       ? Text('Villes à moins de ${_distances[_currentDistanceIndex].toInt()} km :')
//                       : Text('Toutes les distances ont été traitées.'),
//               SizedBox(height: 10),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _citiesWithinDistance.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(_citiesWithinDistance[index]),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }