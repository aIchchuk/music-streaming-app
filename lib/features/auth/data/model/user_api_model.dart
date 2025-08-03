import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:music_streaming/features/auth/domain/entity/user_entity.dart';

part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;

  final String fullName;
  final String email;
  final String password;

  const UserApiModel({
    this.userId,
    required this.fullName,
    required this.email,
    required this.password,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  // Convert to Entity
  UserEntity toEntity() {
    return UserEntity(
      UserId: userId,
      fullName: fullName,
      email: email,
      password: password,
    );
  }

  // Create from Entity
  factory UserApiModel.fromEntity(UserEntity user) {
    return UserApiModel(
      userId: user.UserId,
      fullName: user.fullName,
      email: user.email,
      password: user.password,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        fullName,
        email,
        password,
      ];
}
