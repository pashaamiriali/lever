import 'queen_info.dart';
import 'visit.dart';

class ChangeQueen extends Visit {
  final QueenInfo queenInfo;

  ChangeQueen(String id,String hiveId, DateTime date, List<String> pictures,
      String description, this.queenInfo)
      : super(id, hiveId,date, pictures, description);
}
