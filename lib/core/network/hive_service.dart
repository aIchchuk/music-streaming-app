import 'package:batch_34a/app/constant/hive_table_constant.dart';
import 'package:batch_34a/features/auth/data/model/user_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';


class HiveService {
  Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}student_management.db';



    Hive.init(path);

    // Register Adapters
    
    Hive.registerAdapter(UserHiveModelAdapter());

    // Add Dummy Data
    // await addBatchData();
    // await addCourseData();

    // clearAll();
  }

  // User Queries

  Future<void> register(UserHiveModel auth) async {
    var box = await Hive.openBox<UserHiveModel>(
      HiveTableConstant.userBox,
    );
    await box.put(auth.userId, auth);
  }

  // Login

  Future<UserHiveModel?> login(String username, String password) async {
    var box = await Hive.openBox<UserHiveModel>(
      HiveTableConstant.userBox,
    );
    var user = box.values.firstWhere(
      (element) => element.username == username && element.password == password,
      orElse: () => throw Exception('Invalid username or password'),
    );
    box.close();
    return user;
  }
 
}