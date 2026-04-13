// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'car_icon_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CarIconModel {

 String get id; String get name; String get assetPath;
/// Create a copy of CarIconModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarIconModelCopyWith<CarIconModel> get copyWith => _$CarIconModelCopyWithImpl<CarIconModel>(this as CarIconModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarIconModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,assetPath);

@override
String toString() {
  return 'CarIconModel(id: $id, name: $name, assetPath: $assetPath)';
}


}

/// @nodoc
abstract mixin class $CarIconModelCopyWith<$Res>  {
  factory $CarIconModelCopyWith(CarIconModel value, $Res Function(CarIconModel) _then) = _$CarIconModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String assetPath
});




}
/// @nodoc
class _$CarIconModelCopyWithImpl<$Res>
    implements $CarIconModelCopyWith<$Res> {
  _$CarIconModelCopyWithImpl(this._self, this._then);

  final CarIconModel _self;
  final $Res Function(CarIconModel) _then;

/// Create a copy of CarIconModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? assetPath = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,assetPath: null == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CarIconModel].
extension CarIconModelPatterns on CarIconModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarIconModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarIconModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarIconModel value)  $default,){
final _that = this;
switch (_that) {
case _CarIconModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarIconModel value)?  $default,){
final _that = this;
switch (_that) {
case _CarIconModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String assetPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarIconModel() when $default != null:
return $default(_that.id,_that.name,_that.assetPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String assetPath)  $default,) {final _that = this;
switch (_that) {
case _CarIconModel():
return $default(_that.id,_that.name,_that.assetPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String assetPath)?  $default,) {final _that = this;
switch (_that) {
case _CarIconModel() when $default != null:
return $default(_that.id,_that.name,_that.assetPath);case _:
  return null;

}
}

}

/// @nodoc


class _CarIconModel implements CarIconModel {
  const _CarIconModel({required this.id, required this.name, required this.assetPath});
  

@override final  String id;
@override final  String name;
@override final  String assetPath;

/// Create a copy of CarIconModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarIconModelCopyWith<_CarIconModel> get copyWith => __$CarIconModelCopyWithImpl<_CarIconModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarIconModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,assetPath);

@override
String toString() {
  return 'CarIconModel(id: $id, name: $name, assetPath: $assetPath)';
}


}

/// @nodoc
abstract mixin class _$CarIconModelCopyWith<$Res> implements $CarIconModelCopyWith<$Res> {
  factory _$CarIconModelCopyWith(_CarIconModel value, $Res Function(_CarIconModel) _then) = __$CarIconModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String assetPath
});




}
/// @nodoc
class __$CarIconModelCopyWithImpl<$Res>
    implements _$CarIconModelCopyWith<$Res> {
  __$CarIconModelCopyWithImpl(this._self, this._then);

  final _CarIconModel _self;
  final $Res Function(_CarIconModel) _then;

/// Create a copy of CarIconModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? assetPath = null,}) {
  return _then(_CarIconModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,assetPath: null == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
