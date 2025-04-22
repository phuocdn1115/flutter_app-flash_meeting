import 'package:flash_meeting_app/core/model/either.dart';
import 'package:flash_meeting_app/core/model/failure.dart';
import 'package:flash_meeting_app/features/auth/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser();
}