import 'queen_info.dart';
import 'visit.dart';

class ChangeQueen extends Visit {
  final QueenInfo queenInfo;

  ChangeQueen(String id, DateTime date, List<String> pictures,
      String description, this.queenInfo)
      : super(id, date, pictures, description);
}
