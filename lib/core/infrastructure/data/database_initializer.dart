import 'package:sqflite/sqflite.dart';

class DatabaseInitializer {
  static List<String> tables = [
    'CREATE TABLE hives (id TEXT PRIMARY KEY, number INTEGER, annualHoney INTEGER, description TEXT, picture TEXT)',
    'CREATE TABLE regularVisits (id TEXT PRIMARY KEY, hiveId Text, date DATETIME, pictures TEXT, description TEXT, behavior TEXT, queenSeen INTEGER, honeyMaking TEXT)',
    'CREATE TABLE changeQueens (id TEXT PRIMARY KEY, hiveId Text, date DATETIME, pictures TEXT, description TEXT)',
    'CREATE TABLE queenInfos (id TEXT PRIMARY KEY, changeQueenId Text, enterDate DATETIME, breed TEXT, backColor TEXT)',
    'CREATE TABLE populationInfos (id TEXT PRIMARY KEY, regularVisitId Text, frames INTEGER, stairs INTEGER, status TEXT)',
  ];

  static createTables(Database database) async {
    for (String table in tables) await database.execute(table);
  }
}
