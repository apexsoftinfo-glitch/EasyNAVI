// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prediction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PredictionModel {

 String get description;@JsonKey(name: 'place_id') String get placeId;
/// Create a copy of PredictionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PredictionModelCopyWith<PredictionModel> get copyWith => _$PredictionModelCopyWithImpl<PredictionModel>(this as PredictionModel, _$identity);

  /// Serializes this PredictionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PredictionModel&&(identical(other.description, description) || other.description == description)&&(identical(other.placeId, placeId) || other.placeId == placeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,placeId);

@override
String toString() {
  return 'PredictionModel(description: $description, placeId: $placeId)';
}


}

/// @nodoc
abstract mixin class $PredictionModelCopyWith<$Res>  {
  factory $PredictionModelCopyWith(PredictionModel value, $Res Function(PredictionModel) _then) = _$PredictionModelCopyWithImpl;
@useResult
$Res call({
 String description,@JsonKey(name: 'place_id') String placeId
});




}
/// @nodoc
class _$PredictionModelCopyWithImpl<$Res>
    implements $PredictionModelCopyWith<$Res> {
  _$PredictionModelCopyWithImpl(this._self, this._then);

  final PredictionModel _self;
  final $Res Function(PredictionModel) _then;

/// Create a copy of PredictionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = null,Object? placeId = null,}) {
  return _then(_self.copyWith(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PredictionModel].
extension PredictionModelPatterns on PredictionModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PredictionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PredictionModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PredictionModel value)  $default,){
final _that = this;
switch (_that) {
case _PredictionModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PredictionModel value)?  $default,){
final _that = this;
switch (_that) {
case _PredictionModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String description, @JsonKey(name: 'place_id')  String placeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PredictionModel() when $default != null:
return $default(_that.description,_that.placeId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String description, @JsonKey(name: 'place_id')  String placeId)  $default,) {final _that = this;
switch (_that) {
case _PredictionModel():
return $default(_that.description,_that.placeId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String description, @JsonKey(name: 'place_id')  String placeId)?  $default,) {final _that = this;
switch (_that) {
case _PredictionModel() when $default != null:
return $default(_that.description,_that.placeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PredictionModel implements PredictionModel {
  const _PredictionModel({required this.description, @JsonKey(name: 'place_id') required this.placeId});
  factory _PredictionModel.fromJson(Map<String, dynamic> json) => _$PredictionModelFromJson(json);

@override final  String description;
@override@JsonKey(name: 'place_id') final  String placeId;

/// Create a copy of PredictionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PredictionModelCopyWith<_PredictionModel> get copyWith => __$PredictionModelCopyWithImpl<_PredictionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PredictionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PredictionModel&&(identical(other.description, description) || other.description == description)&&(identical(other.placeId, placeId) || other.placeId == placeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,placeId);

@override
String toString() {
  return 'PredictionModel(description: $description, placeId: $placeId)';
}


}

/// @nodoc
abstract mixin class _$PredictionModelCopyWith<$Res> implements $PredictionModelCopyWith<$Res> {
  factory _$PredictionModelCopyWith(_PredictionModel value, $Res Function(_PredictionModel) _then) = __$PredictionModelCopyWithImpl;
@override @useResult
$Res call({
 String description,@JsonKey(name: 'place_id') String placeId
});




}
/// @nodoc
class __$PredictionModelCopyWithImpl<$Res>
    implements _$PredictionModelCopyWith<$Res> {
  __$PredictionModelCopyWithImpl(this._self, this._then);

  final _PredictionModel _self;
  final $Res Function(_PredictionModel) _then;

/// Create a copy of PredictionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = null,Object? placeId = null,}) {
  return _then(_PredictionModel(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
