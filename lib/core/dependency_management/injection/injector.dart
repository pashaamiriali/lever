import 'package:camera/camera.dart';
import 'package:lever/core/infrastructure/data/date_time_provider.dart';
import 'package:lever/core/infrastructure/data/id_generator.dart';
import 'package:lever/core/infrastructure/data/moor_db/app_database.dart';
import 'package:lever/features/hive_management/data/hive_repo_impl.dart';
import 'package:lever/features/hive_management/domain/usecases/usecases.dart';

import 'package:uuid/uuid.dart';

class Injector {
  Uuid _uuid;
  AppDatabase _appDatabase;
  IDGen _idGen;
  DateTimeProvider _datetimeProvider;
  HiveRepoImpl _hiveRepoImpl;
  CameraDescription camera;
  Future initiate() async {
    this._uuid = Uuid();
    this._appDatabase = AppDatabase();
    this._idGen = IDGenImpl(_uuid);
    this._datetimeProvider = DateTimeProviderImpl();
    this._hiveRepoImpl =
        HiveRepoImpl(this._appDatabase, this._idGen, this._datetimeProvider);
    this.camera = (await availableCameras()).first;
  }

  AddHiveCmnd get getAddHiveCmnd => AddHiveCmnd(this._hiveRepoImpl);
  FetchHivesCmnd get getFetchHivesCmnd => FetchHivesCmnd(this._hiveRepoImpl);
  GenerateHiveNumberCmnd get getGenerateHiveNumberCmnd =>
      GenerateHiveNumberCmnd(this._hiveRepoImpl);
  DeleteHiveCmnd get getDeleteHiveCmnd => DeleteHiveCmnd(this._hiveRepoImpl);
  EditHiveCmnd get getEditHiveCmnd => EditHiveCmnd(this._hiveRepoImpl);
  FetchHiveCmnd get getFetchHiveCmnd => FetchHiveCmnd(this._hiveRepoImpl);
  FetchVisitsCmnd get getFetchVisitsCmnd => FetchVisitsCmnd(this._hiveRepoImpl);
}
