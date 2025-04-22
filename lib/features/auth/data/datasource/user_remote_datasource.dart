import 'package:dio/dio.dart';
import 'package:flash_meeting_app/features/auth/domain/entity/user_entity.dart';

class UserRemoteDatasource {
  final Dio dio;

  UserRemoteDatasource({required this.dio});

  Future<UserEntity> getUser() async {
    var request = await dio.get('user/profile');
    return UserEntity.fromJson(request.data);
  }
}
