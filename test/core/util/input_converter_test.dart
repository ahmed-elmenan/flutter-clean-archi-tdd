import 'package:dartz/dartz.dart';
import 'package:flutter_ayoub/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
        'should return an integer when the string represent and unsigne dinteger',
        () async {
      //arrange
      final str = '23';

      //act
      final result = inputConverter.stringToUnsignedInteger(str);

      //assert
      expect(result, Right(23));
    });

    test('should return Failure when the string is not an int', () async {
     //arrange
      final str = 'abc';

      //act
      final result = inputConverter.stringToUnsignedInteger(str);

      //assert
      expect(result, Left(InvalidInputFailure()));
    
    });
    test('should return Failure when the string is not a negative int', () async {
     //arrange
      final str = '-23';

      //act
      final result = inputConverter.stringToUnsignedInteger(str);

      //assert
      expect(result, Left(InvalidInputFailure()));
    
    });
  });
}
