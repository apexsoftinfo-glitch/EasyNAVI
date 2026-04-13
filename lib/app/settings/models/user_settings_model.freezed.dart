// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSettingsModel {

 String get locale; double get brightness; int get carIconIndex; double get speechRate; double get speechPitch;
/// Create a copy of UserSettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSettingsModelCopyWith<UserSettingsModel> get copyWith => _$UserSettingsModelCopyWithImpl<UserSettingsModel>(this as UserSettingsModel, _$identity);

  /// Serializes this UserSettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSettingsModel&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.brightness, brightness) || other.brightness == brightness)&&(identical(other.carIconIndex, carIconIndex) || other.carIconIndex == carIconIndex)&&(identical(other.speechRate, speechRate) || other.speechRate == speechRate)&&(identical(other.speechPitch, speechPitch) || other.speechPitch == speechPitch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locale,brightness,carIconIndex,speechRate,speechPitch);

@override
String toString() {
  return 'UserSettingsModel(locale: $locale, brightness: $brightness, carIconIndex: $carIconIndex, speechRate: $speechRate, speechPitch: $speechPitch)';
}


}

/// @nodoc
abstract mixin class $UserSettingsModelCopyWith<$Res>  {
  factory $UserSettingsModelCopyWith(UserSettingsModel value, $Res Function(UserSettingsModel) _then) = _$UserSettingsModelCopyWithImpl;
@useResult
$Res call({
 String locale, double brightness, int carIconIndex, double speechRate, double speechPitch
});




}
/// @nodoc
class _$UserSettingsModelCopyWithImpl<$Res>
    implements $UserSettingsModelCopyWith<$Res> {
  _$UserSettingsModelCopyWithImpl(this._self, this._then);

  final UserSettingsModel _self;
  final $Res Function(UserSettingsModel) _then;

/// Create a copy of UserSettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = null,Object? brightness = null,Object? carIconIndex = null,Object? speechRate = null,Object? speechPitch = null,}) {
  return _then(_self.copyWith(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as double,carIconIndex: null == carIconIndex ? _self.carIconIndex : carIconIndex // ignore: cast_nullable_to_non_nullable
as int,speechRate: null == speechRate ? _self.speechRate : speechRate // ignore: cast_nullable_to_non_nullable
as double,speechPitch: null == speechPitch ? _self.speechPitch : speechPitch // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSettingsModel].
extension UserSettingsModelPatterns on UserSettingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSettingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSettingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSettingsModel value)  $default,){
final _that = this;
switch (_that) {
case _UserSettingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSettingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserSettingsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String locale,  double brightness,  int carIconIndex,  double speechRate,  double speechPitch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSettingsModel() when $default != null:
return $default(_that.locale,_that.brightness,_that.carIconIndex,_that.speechRate,_that.speechPitch);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String locale,  double brightness,  int carIconIndex,  double speechRate,  double speechPitch)  $default,) {final _that = this;
switch (_that) {
case _UserSettingsModel():
return $default(_that.locale,_that.brightness,_that.carIconIndex,_that.speechRate,_that.speechPitch);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String locale,  double brightness,  int carIconIndex,  double speechRate,  double speechPitch)?  $default,) {final _that = this;
switch (_that) {
case _UserSettingsModel() when $default != null:
return $default(_that.locale,_that.brightness,_that.carIconIndex,_that.speechRate,_that.speechPitch);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSettingsModel implements UserSettingsModel {
  const _UserSettingsModel({required this.locale, required this.brightness, required this.carIconIndex, required this.speechRate, required this.speechPitch});
  factory _UserSettingsModel.fromJson(Map<String, dynamic> json) => _$UserSettingsModelFromJson(json);

@override final  String locale;
@override final  double brightness;
@override final  int carIconIndex;
@override final  double speechRate;
@override final  double speechPitch;

/// Create a copy of UserSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSettingsModelCopyWith<_UserSettingsModel> get copyWith => __$UserSettingsModelCopyWithImpl<_UserSettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSettingsModel&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.brightness, brightness) || other.brightness == brightness)&&(identical(other.carIconIndex, carIconIndex) || other.carIconIndex == carIconIndex)&&(identical(other.speechRate, speechRate) || other.speechRate == speechRate)&&(identical(other.speechPitch, speechPitch) || other.speechPitch == speechPitch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locale,brightness,carIconIndex,speechRate,speechPitch);

@override
String toString() {
  return 'UserSettingsModel(locale: $locale, brightness: $brightness, carIconIndex: $carIconIndex, speechRate: $speechRate, speechPitch: $speechPitch)';
}


}

/// @nodoc
abstract mixin class _$UserSettingsModelCopyWith<$Res> implements $UserSettingsModelCopyWith<$Res> {
  factory _$UserSettingsModelCopyWith(_UserSettingsModel value, $Res Function(_UserSettingsModel) _then) = __$UserSettingsModelCopyWithImpl;
@override @useResult
$Res call({
 String locale, double brightness, int carIconIndex, double speechRate, double speechPitch
});




}
/// @nodoc
class __$UserSettingsModelCopyWithImpl<$Res>
    implements _$UserSettingsModelCopyWith<$Res> {
  __$UserSettingsModelCopyWithImpl(this._self, this._then);

  final _UserSettingsModel _self;
  final $Res Function(_UserSettingsModel) _then;

/// Create a copy of UserSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,Object? brightness = null,Object? carIconIndex = null,Object? speechRate = null,Object? speechPitch = null,}) {
  return _then(_UserSettingsModel(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as double,carIconIndex: null == carIconIndex ? _self.carIconIndex : carIconIndex // ignore: cast_nullable_to_non_nullable
as int,speechRate: null == speechRate ? _self.speechRate : speechRate // ignore: cast_nullable_to_non_nullable
as double,speechPitch: null == speechPitch ? _self.speechPitch : speechPitch // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
