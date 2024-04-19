import 'package:flutter/material.dart';
//import 'dart:math' as math;
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';

class CompassPage extends StatefulWidget {
  const CompassPage({super.key});

  @override
  State<CompassPage> createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
 // bool _hasPermissions = true;
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();

    _fetchPermissionStatus();
  }
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 150, 226, 154),
        body: Builder(
          builder: (context) {
            if (_hasPermissions) {
              return _buildCompass();
            } else {
              return _buildPermissionSheet();
            }
          },
        ),
      ),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: Text("Device does not have sensors !"),
          );
        }
        // angle: ((_heading * (math.pi / 180)) * -1),
        //   child: Image.asset(
        //     'assets/compass.png',
        //     width: 200,
        //     height: 200,
        //     fit: BoxFit.contain,

        return Center(
          child: Transform.rotate(
            angle: (direction * (180 / 3.14159) * -1),
            child: Image.network(
              'https://images.unsplash.com/photo-1519709042477-8de6eaf1fdc5?q=80&w=1827&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
    ),
  ),
);

      },
    );
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: ElevatedButton(
        child: const Text('Request Permissions'),
        onPressed: () {
          Permission.locationWhenInUse.request().then((value) {
            _fetchPermissionStatus();
          });
        },
      ),
    );
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }  
    });
}


}