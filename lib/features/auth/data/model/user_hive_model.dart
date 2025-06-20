
import 'package:batch_34a/app/constant/hive_table_constant.dart';
import 'package:batch_34a/features/auth/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'user_hive_model.g.dart';


@HiveType(typeId : HiveTableConstant.userTableId)
class UserHiveModel extends Equatable{
  
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String? image;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String username;
  @HiveField(5)
  final String password;


  const UserHiveModel({
    this.userId,
    required this.fullName,
    this.image,
    required this.phone,
    required this.username,
    required this.password,
  });
  

  // Initial Constructor for creating a new User
  const UserHiveModel.initial() : userId = null, fullName = '', image = null, phone = '', username = '', password = '';


  // To entity
   UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      fullName: fullName,
      image: image,
      phone: phone, 
      username: username,
      password: password,
    );
  }

  // From entity
  factory UserHiveModel.fromEntity(UserEntity entity) {
    return UserHiveModel(
      userId: entity.userId,
      fullName: entity.fullName,
      image: entity.image,
      phone: entity.phone,
      username: entity.username,
      password: entity.password,
    );
  }


  @override
  List<Object?> get props => [userId, fullName, image, phone, username, password];
}