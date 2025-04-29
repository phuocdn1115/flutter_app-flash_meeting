import 'package:equatable/equatable.dart';
import 'package:flash_meeting_app/features/meet/domain/entity/meet_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum MainStatus { initial, loading, success, successfullyGotUserLocation, error }

class MainState extends Equatable {
  final MainStatus mapStatus;
  final List<MeetEntity>? mapMeets;
  final String? mapErrorMessage;
  final LatLng? userLocation;

  const MainState._({required this.mapStatus, this.mapMeets, this.mapErrorMessage, this.userLocation});

  factory MainState.initial() => MainState._(mapStatus: MainStatus.initial);

  MainState copyWith({
    MainStatus? mapStatus,
    List<MeetEntity>? mapMeets,
    String? mapErrorMessage,
    LatLng? userLocation
  }) => MainState._(
    mapStatus: mapStatus ?? this.mapStatus,
    mapMeets: mapMeets ?? this.mapMeets,
    mapErrorMessage: mapErrorMessage ?? this.mapErrorMessage,
    userLocation: userLocation ?? this.userLocation
  );

  @override
  List<Object?> get props => [mapStatus, mapMeets, mapErrorMessage, userLocation];
}
