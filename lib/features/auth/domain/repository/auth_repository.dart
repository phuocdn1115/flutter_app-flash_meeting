import 'package:flash_meeting_app/core/model/failure.dart';
import 'package:flash_meeting_app/features/auth/domain/entity/user_entity.dart';
import '../../../../core/model/either.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, UserEntity>> signInWithGoogle();
}