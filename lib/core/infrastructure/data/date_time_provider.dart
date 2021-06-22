abstract class DateTimeProvider{
  DateTime getCurrentDateTime();
}
class DateTimeProviderImpl implements DateTimeProvider{
  @override
  getCurrentDateTime() =>DateTime.now();
}