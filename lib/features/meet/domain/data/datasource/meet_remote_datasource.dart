import 'package:dio/dio.dart';
import 'package:flash_meeting_app/features/meet/domain/entity/meet_entity.dart';

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
}
