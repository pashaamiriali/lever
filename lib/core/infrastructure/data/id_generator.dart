import 'package:uuid/uuid.dart';

abstract class IDGen {
  generateId();
}

class IDGenImpl implements IDGen {
  final Uuid _uuid;

  IDGenImpl(this._uuid);

  @override
  generateId() => this._uuid.v1();
}
