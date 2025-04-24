import 'dart:async';

import 'package:flash_meeting_app/features/create_meet/presentation/bloc/location_picker_event.dart';
import 'package:flash_meeting_app/features/create_meet/presentation/bloc/location_picker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerBloc
    extends Bloc<LocationPickerEvent, LocationPickerState> {
  LocationPickerBloc() : super(LocationPickerState.initial()) {
    on<GetUserLocationEvent>(onGetUserLocationEvent);
    on<SetLocationEvent>(onSetLocationEvent);
  }

  Future onGetUserLocationEvent(
    GetUserLocationEvent event,
    Emitter<LocationPickerState> emit,
  ) async {
    emit(state.copyWith(status: LocationPickerStatus.loading));
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print('****************************************** START PERMISSION');
    if (!serviceEnabled) {
      return;
    }
    print('****************************************** CHECK PERMISSION');
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print('****************************************** REQUEST PERMISSION');
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      }
      print('****************************************** GET LOCATION');
      Position position = await Geolocator.getCurrentPosition();
      emit(
        state.copyWith(
          location: LatLng(position.latitude, position.longitude),
          status: LocationPickerStatus.success,
        ),
      );
    }
  }

  Future onSetLocationEvent(
    SetLocationEvent event,
    Emitter<LocationPickerState> emit,
  ) async {
    emit(
      state.copyWith(
        location: event.location,
        status: LocationPickerStatus.locationUpdated,
      ),
    );
  }
}
