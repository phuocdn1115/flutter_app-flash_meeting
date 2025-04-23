import 'package:flash_meeting_app/core/model/either.dart';
import 'package:flash_meeting_app/core/model/failure.dart';
import 'package:flash_meeting_app/features/meet/domain/entity/meet_entity.dart';

abstract class MeetRepository {
  Future<Either<Failure, List<MeetEntity>>> getLastMeets({
    int? page,
    int? limit,
  });
}
