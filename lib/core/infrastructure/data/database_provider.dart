abstract class DatabaseWrapper {
  insert(Map<String,dynamic> tableData);
  select(Map<String,dynamic> selectInfo);
  selectFirst(Map<String,dynamic> selectInfo);
}
