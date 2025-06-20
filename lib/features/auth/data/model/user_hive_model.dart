
import 'package:batch_34a/app/constant/hive_table_constant.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';


@HiveType(typeId : HiveTableConstant.userTableId)
class UserHiveModel extends Equatable{
  final String? userId;
  final String userName;

  UserHiveModel({
    this.userId,
    required this.userName,
  })


  @override
  List<Object?> get props => throw UnimplementedError();

}