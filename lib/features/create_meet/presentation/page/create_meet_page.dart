import 'package:flash_meeting_app/core/get_it/get_it.dart';
import 'package:flash_meeting_app/core/ui/default_button.dart';
import 'package:flash_meeting_app/core/ui/default_text_field.dart';
import 'package:flash_meeting_app/features/create_meet/presentation/bloc/create_meet_bloc.dart';
import 'package:flash_meeting_app/features/create_meet/presentation/bloc/create_meet_event.dart';
import 'package:flash_meeting_app/features/create_meet/presentation/bloc/create_meet_state.dart';
import 'package:flash_meeting_app/features/create_meet/presentation/page/location_picker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateMeetPage extends StatefulWidget {
  const CreateMeetPage({super.key});

  static const String route = '/create_meet';

  @override
  State<CreateMeetPage> createState() => _CreateMeetPageState();
}

class _CreateMeetPageState extends State<CreateMeetPage> {
  final TextEditingController txtTitleController = TextEditingController();
  final TextEditingController txtDescController = TextEditingController();
  TimeOfDay timeOfDay = TimeOfDay.now();
  LatLng? myLocation = LatLng(40.730610, -73.935242);
  GoogleMapController? _googleMapController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateMeetBloc>(),
      child: BlocConsumer<CreateMeetBloc, CreateMeetState>(
        listener: (context, state) {
          if (state.status == CreateMeetStatus.error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('${state.errorMessage}')));
          }
        },
        builder: (context, state) {
          if (state.status == CreateMeetStatus.loading) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Create Meet',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              centerTitle: false,
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      DefaultTextField(
                        hintText: 'Enter meet title',
                        controller: txtTitleController,
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      DefaultTextField(
                        hintText: 'Enter meet description',
                        controller: txtDescController,
                        maxLength: 255,
                        maxLines: 6,
                        minLines: 2,
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Time',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Events automatically mark as completed 2 hours after they start.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.8),
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(children: [_buildTimePicker(context)]),
                      SizedBox(height: 15),
                      Text(
                        'Location',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Tap map to select location',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.8),
                        ),
                      ),
                      SizedBox(height: 5),
                      _buildLocationPicker(context),
                      SizedBox(height: 20),
                      DefaultButton(
                        text: 'Create',
                        onPressed:
                            myLocation == null ||
                                    txtTitleController.text.isEmpty ||
                                    txtDescController.text.isEmpty
                                ? null
                                : () {
                                  context.read<CreateMeetBloc>().add(
                                    CreateMeetEvent(
                                      title: txtTitleController.text,
                                      description: txtDescController.text,
                                      time: timeOfDay,
                                      location: myLocation!,
                                    ),
                                  );
                                },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    return Row(
      children: [
        _buildTimePart(context, timeOfDay.hour),
        SizedBox(width: 5),
        Text(':', style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(width: 5),
        _buildTimePart(context, timeOfDay.minute),
      ],
    );
  }

  Widget _buildTimePart(BuildContext context, int value) {
    return InkWell(
      onTap: () async {
        var time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.inputOnly,
        );
        if (time != null) {
          setState(() {
            timeOfDay = time;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(12),
        child: Text(
          value.toString().padLeft(2, '0'),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildLocationPicker(BuildContext context) {
    return Container(
      height: 300,
      width: double.maxFinite,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: GoogleMap(
        myLocationEnabled: false,
        compassEnabled: false,
        myLocationButtonEnabled: false,
        scrollGesturesEnabled: false,
        zoomGesturesEnabled: false,
        tiltGesturesEnabled: false,
        rotateGesturesEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (controller) {
          setState(() {
            _googleMapController = controller;
          });
        },
        onTap: (_) async {
          LatLng? selectedLocation = await context.push(
            LocationPickerPage.route,
          );
          if (selectedLocation != null) {
            setState(() {
              myLocation = selectedLocation;
            });
            _googleMapController?.animateCamera(
              CameraUpdate.newLatLngZoom(selectedLocation, 15),
            );
          }
        },
        markers:
            myLocation != null
                ? {
                  Marker(
                    markerId: MarkerId('selectedLocation'),
                    position: myLocation!,
                  ),
                }
                : {},
        initialCameraPosition: CameraPosition(
          target: myLocation ?? LatLng(40.730610, -73.935242),
          zoom: 15,
        ),
      ),
    );
  }
}
