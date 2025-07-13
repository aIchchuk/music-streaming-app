import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_streaming/app/constant/hive_table_constant.dart';
import 'package:music_streaming/features/auth/domain/entity/user_entity.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable{

  @HiveField(0)
  final String? UserId;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String phoneNo;

  @HiveField(3)
  final String? userImage;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String password;

  const UserHiveModel({
    this.UserId,
    required this.fullName,
    required this.phoneNo,
    this.userImage,
    required this.email,
    required this.password,
  });

  // initial constructor for creating a new user
  const UserHiveModel.initial()
  : UserId = null,
    fullName = '',
    phoneNo = '',
    userImage = null,
    email = '',
    password = '';


  // To Entity
  UserEntity toEntity() {
    return UserEntity(
      UserId: UserId,
      fullName: fullName,
      phoneNo: phoneNo,
      userImage: userImage,
      email: email,
      password: password
    );
  }

  // From Entity
  factory UserHiveModel.fromEntity(UserEntity user) {
    return UserHiveModel(
      UserId: user.UserId,
      fullName: user.fullName,
      phoneNo: user.phoneNo,
      userImage: user.userImage,
      email: user.email,
      password: user.password,
    );
  }

  @override
  List<Object?> get props => [
    UserId,
    fullName,
    phoneNo,
    userImage,
    email,
    password
  ];
}