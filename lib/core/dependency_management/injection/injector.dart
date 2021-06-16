import 'package:camera/camera.dart';
import 'package:lever/core/env.dart';
import 'package:lever/core/infrastructure/data/database_initializer.dart';
import 'package:lever/core/infrastructure/data/database_provider.dart';
import 'package:lever/core/infrastructure/data/database_provider_impl.dart';
import 'package:lever/core/infrastructure/data/date_time_provider.dart';
import 'package:lever/core/infrastructure/data/id_generator.dart';
import 'package:lever/features/hive_management/data/hive_repo_impl.dart';
import 'package:lever/features/hive_management/domain/usecases/add_hive_cmnd.dart';
import 'package:lever/features/hive_management/domain/usecases/fetch_hives_cmnd.dart';
import 'package:lever/features/hive_management/domain/usecases/generate_hive_number_cmnd.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class Injector {
  Database _db;
  Uuid _uuid;
  DatabaseWrapper _dbWrapper;
  IDGen _idGen;
  DateTimeProvider _datetimeProvider;
  HiveRepoImpl _hiveRepoImpl;
  CameraDescription camera;
  Future initiate() async {
    this._db = await _instantiateDb();
    this._uuid = Uuid();
    this._dbWrapper = DatabaseWrapperImpl(this._db);
    this._idGen = IDGenImpl(_uuid);
    this._datetimeProvider = DateTimeProviderImpl();
    this._hiveRepoImpl =
        HiveRepoImpl(this._dbWrapper, this._idGen, this._datetimeProvider);
    this.camera = (await availableCameras()).first;
  }

  Future<Database> _instantiateDb() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, DB_NAME);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, version) async {
      await DatabaseInitializer.createTables(db);
    });
  }

  AddHiveCmnd get getAddHiveCmnd => AddHiveCmnd(this._hiveRepoImpl);
  FetchHivesCmnd get getFetchHivesCmnd => FetchHivesCmnd(this._hiveRepoImpl);
  GenerateHiveNumberCmnd get getGenerateHiveNumberCmnd =>
      GenerateHiveNumberCmnd(this._hiveRepoImpl);
}
