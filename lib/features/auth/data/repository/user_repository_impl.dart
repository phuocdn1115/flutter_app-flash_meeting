import 'package:dio/dio.dart';
import 'package:flash_meeting_app/core/model/either.dart';
import 'package:flash_meeting_app/core/model/failure.dart';
import 'package:flash_meeting_app/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:flash_meeting_app/features/auth/domain/entity/user_entity.dart';
import 'package:flash_meeting_app/features/auth/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource userRemoteDatasource;

  UserRepositoryImpl({required this.userRemoteDatasource});

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      return Right(await userRemoteDatasource.getUser());
    } on DioException catch (e) {
      return Left(UserFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(UserFailure(message: e.toString()));
    }
  }
}
