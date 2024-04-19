import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';


class LightSensor extends StatefulWidget {
  const LightSensor({super.key});

  @override
  State<LightSensor> createState() => _LightSensorState();
}

class _LightSensorState extends State<LightSensor> {
  double _lightIntensity = 0.0;


  @override
  void initState() {
    super.initState();
    _initSensors();
  }

  void _initSensors() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _lightIntensity = event.x; // For demonstration, using x-axis of accelerometer as light intensity
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Light Sensor '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Light Intensity:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              _lightIntensity.toStringAsFixed(2),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }


}