import 'visit.dart';

class HarvestHoney extends Visit {
  final String describedAmount;
  final int frames;
  final int weight;
  final String quality;

  HarvestHoney(String id, String hiveId, DateTime date, List<String> pictures, String description, this.describedAmount, this.frames, this.weight, this.quality) : super(id, hiveId,date, pictures, description);
}
