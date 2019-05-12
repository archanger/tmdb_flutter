import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:movies/tools/date_time_formatters.dart';

class TMDBDateTimeSerializer implements PrimitiveSerializer<DateTime> {
  @override
  DateTime deserialize(Serializers serializers, Object serialized, {FullType specifiedType = FullType.unspecified}) {
    return DateTime.parse(serialized as String);
  }

  @override
  Object serialize(Serializers serializers, DateTime object, {FullType specifiedType = FullType.unspecified}) {
    return DateTimeFormatters.tmdbDateFrom(object);
  }

  @override
  Iterable<Type> get types => BuiltList<Type>([DateTime]);

  @override
  String get wireName => 'DateTime';
}
