
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StepsCounter extends StatefulWidget {
  const StepsCounter({super.key});

  @override
  State<StepsCounter> createState() => _StepsCounterState();
}

class _StepsCounterState extends State<StepsCounter> {
  late Stream<StepCount> _stepCountStream;
	late Stream<PedestrianStatus> _pedestrianStatusStream;

	String _steps = '0';
	String _pedestrianStatus = 'stopped';

	//bool _permissionGranted = true;
  bool _permissionGranted = false;

	String _unit = 'Steps';
  
	@override
	void initState() {
		super.initState();
		initPlatformState();
	}

	void onStepCount(StepCount event) {
		print('Event occurred: $event.toString()');
		setState(() {
			_steps = event.steps.toString();
		});
	}

	void onStepCountError(err) {
		print('Error occurred');
	}

	void onPedestrianStatusChanged(PedestrianStatus event) {
		print('Event occurred: $event.toString()');
		setState(() {
			_pedestrianStatus = event.status.toString();
		});
	}

	void onPedestrianStatusError(err) {
		print('Error occurred: $err');
		setState(() {
			_pedestrianStatus = 'unknown';
		});
	}

	Future<bool> checkPermission() async {
		if (await Permission.activityRecognition.request().isGranted) {
			return true;
		} else {
			return false;
		}
	}

	void initPlatformState() async {
		if (await checkPermission()) {
			setState(() { _permissionGranted = true; });

			setState(() {
				_stepCountStream = Pedometer.stepCountStream;
				_stepCountStream
					.listen(onStepCount)
					.onError(onStepCountError);

				_pedestrianStatusStream = Pedometer.pedestrianStatusStream;
				_pedestrianStatusStream
					.listen(onPedestrianStatusChanged)
					.onError(onPedestrianStatusError);
			});
		}

		if (!mounted) return;
	}

	String convertStepsTo(String unit) {
		switch (unit) {
			case 'Kilometers':
				return (int.parse(_steps) / 1300).toStringAsFixed(1);

			case 'Meters':
				return (int.parse(_steps) / 1.3).toStringAsFixed(1);

			case 'Centimeters':
				return (int.parse(_steps) / 0.013).toStringAsFixed(1);

			case 'Inches':
				return (int.parse(_steps) / 0.03).toStringAsFixed(1);

			case 'Feet':
				return (int.parse(_steps) / 0.4).toStringAsFixed(1);

			case 'Yard':
				return (int.parse(_steps) / 1.2).toStringAsFixed(1);

			case 'Miles':
				return (int.parse(_steps) / 2100).toStringAsFixed(1);
		}

		return _steps;
	}

	void showConfigPanel(BuildContext context) {
		ListTile generateOption(String unit, StateSetter setLocalState) {
			return ListTile(
				title: Text(unit),
				leading: Radio(
					value: unit, 
					groupValue: _unit,
					onChanged: (value) {
						setLocalState(() {
							_unit = value.toString();
						});

						setState(() {
							_unit = value.toString();
						});
					}
				)
			);
		}
    AlertDialog alert = AlertDialog(
			title: const Text('Set unit'),
			content: StatefulBuilder(
				builder: (BuildContext state, StateSetter setState) {
					return Column(
						mainAxisSize: MainAxisSize.min,
						children: <Widget>[
							generateOption('Steps', setState),
							generateOption('Kilometers', setState),
							generateOption('Meters', setState),
							generateOption('Centimeters', setState),
							generateOption('Inches', setState),
							generateOption('Feet', setState),
							generateOption('Yards', setState),
							generateOption('Miles', setState)
						]
					);
				}
			),
			actions: <Widget>[
				TextButton(
					child: const Text('OK'),
					onPressed: () {
						Navigator.pop(context);
					}
				)
			]
		);

		showDialog(
			context: context,
			builder: (BuildContext ctx) {
				return alert;
			}
		);
  }
  @override
  Widget build(BuildContext context) {
return MaterialApp(
			home: Scaffold(
				appBar: AppBar(
					title: const Text('Fitness: Step counter'), 
					actions: <Widget>[
						IconButton(
							icon: const Icon(
								Icons.settings,
								color: Colors.white,
								size: 32,
							),
							onPressed: () {
								showConfigPanel(context);
							},
						)
					],
					
				),
				body: Container(
					alignment: Alignment.center,
					child:  _permissionGranted ? 
							Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									Text(
										_unit == 'Steps' ? '$_unit taken:' : '$_unit walked:',
										style: TextStyle(
											fontSize: _unit.length > 8 ?  32 : 48
										)
									),
									Text(
										convertStepsTo(_unit),
										style: TextStyle(
											fontSize: convertStepsTo(_unit).length > 5 ? 64 : 128
										)
									),
									
									const Divider(height: 32, color: Colors.white),
									
									Icon(_pedestrianStatus == 'stopped' ?
											Icons.boy_rounded : 
											_pedestrianStatus == 'walking' ?
												Icons.directions_walk :
												Icons.error,
										size: 128),
									Text(_pedestrianStatus != 'unknown' ?
											'You are $_pedestrianStatus' :
											'Unknown pedestrian status'),
                  
								]
							) 
              :
							const AlertDialog(
        						title: Text('Permission Denied'),
        						content: Text('You must grant activity recognition permission to use this app'),
      						)
							
				),
			)
		);
	} 
}



