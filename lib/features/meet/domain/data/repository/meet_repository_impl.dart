import 'package:dio/dio.dart';
import 'package:flash_meeting_app/core/model/either.dart';
import 'package:flash_meeting_app/core/model/failure.dart';
import 'package:flash_meeting_app/features/meet/domain/data/datasource/meet_remote_datasource.dart';
import 'package:flash_meeting_app/features/meet/domain/entity/meet_entity.dart';
import 'package:flash_meeting_app/features/meet/domain/repository/meet_repository.dart';

class MeetRepositoryImpl implements MeetRepository {
  final MeetRemoteDatasource meetRemoteDatasource;

  MeetRepositoryImpl({required this.meetRemoteDatasource});

  @override
  Future<Either<Failure, List<MeetEntity>>> getLastMeets({
    int? page,
    int? limit,
  }) async {
    try {
      return Right(
        await meetRemoteDatasource.getLastMeets(page: page, limit: limit),
      );
    } on DioException catch (e) {
      return Left(MeetFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(MeetFailure(message: e.toString()));
    }
  }
}
