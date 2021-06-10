import 'package:flutter_test/flutter_test.dart';
import 'package:lever/core/infrastructure/data/id_generator.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class MockUUID extends Mock implements Uuid {}

void main() {
  test('should return the id generated by the v1 uuid function', (){
    MockUUID mockUUID=MockUUID();
    var expectedId='someId3234';
    when(mockUUID.v1()).thenReturn(expectedId);
    IDGenImpl idGenImpl=IDGenImpl(mockUUID);
    var result=idGenImpl.generateId();
    verify(mockUUID.v1());
    expect(result, expectedId);
  });
}