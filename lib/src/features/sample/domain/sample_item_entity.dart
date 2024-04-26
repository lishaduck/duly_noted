import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample_item_entity.freezed.dart';

/// A placeholder class that represents an entity or model.
@freezed
@immutable
class SampleItemEntity with _$SampleItemEntity {
  const factory SampleItemEntity(int id) = _SampleItemEntity;
}
