import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

class TMDBDateTimeSerializer implements PrimitiveSerializer<DateTime> {
  @override
  DateTime deserialize(Serializers serializers, Object serialized, {FullType specifiedType = FullType.unspecified}) {
    return DateTime.parse(serialized as String);
  }

  @override
  Object serialize(Serializers serializers, DateTime object, {FullType specifiedType = FullType.unspecified}) {
    return '${object.year}-${object.month.toString().padLeft(2, '0')}-${object.day.toString().padLeft(2, '0')}';
  }

  @override
  Iterable<Type> get types => BuiltList<Type>([DateTime]);

  @override
  String get wireName => 'DateTime';
}
