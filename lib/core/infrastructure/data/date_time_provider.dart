abstract class DateTimeProvider{
  getCurrentDateTime();
}
class DateTimeProviderImpl implements DateTimeProvider{
  @override
  getCurrentDateTime() =>DateTime.now();
}