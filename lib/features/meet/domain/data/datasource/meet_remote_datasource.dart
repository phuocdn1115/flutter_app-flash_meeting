import 'package:dio/dio.dart';
import 'package:flash_meeting_app/features/meet/domain/entity/meet_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeetRemoteDatasource {
  final Dio dio;

  MeetRemoteDatasource({required this.dio});

  Future<List<MeetEntity>> getLastMeets({int? page, int? limit}) async {
    var result = await dio.get(
      'meetings/past',
      queryParameters: {'page': page, 'limit': limit},
    );
    return (result.data['meetings'] as List)
        .map((e) => MeetEntity.fromJson(e))
        .toList();
  }

  Future<MeetEntity> createMeet({
    required String title,
    required String desc,
    required TimeOfDay time,
    required LatLng location,
  }) async {
    var result = await dio.post(
      '/meetings/',
      data: {
        'title': title,
        'description': desc,
        'date':
            DateTime.now()
                .copyWith(hour: time.hour, minute: time.minute)
                .toUtc()
                .toIso8601String(),
        'latitude': location.latitude,
        'longitude': location.longitude,
      },
    );
    return MeetEntity.fromJson(result.data);
  }

  Future<MeetEntity> getMeet(String meetId) async {
    var result = await dio.get('/meetings/${meetId}');
    return MeetEntity.fromJson(result.data);
  }

  Future joinMeet(String meetId) async {
    var result = await dio.post('/meetings/$meetId/join');
    return;
  }

  Future kickUser(String meetId, String userIdToKick) async {
    var result = await dio.post(
      '/meetings/$meetId/kick',
      data: {'userIdToKick': userIdToKick},
    );
    return;
  }

  Future transferAdmin(String meetId, String newAdminId) async {
    var rs = await dio.post(
      '/meetings/$meetId/transferAdmin',
      data: {'newAdminId': newAdminId},
    );
    return;
  }

  Future leaveMeet(String meetId) async {
    var rs = await dio.post('/meetings/$meetId/leave');
    return;
  }

  Future cancelMeet(String meetId) async {
    var rs = await dio.post('/meetings/$meetId/cancel');
    return;
  }
}
