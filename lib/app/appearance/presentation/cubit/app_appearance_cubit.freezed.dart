// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_appearance_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppAppearanceState {

 AppLocaleOptionModel get selectedLocale; double get brightness; CarIconType get carIcon; bool get isSaving;
/// Create a copy of AppAppearanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppAppearanceStateCopyWith<AppAppearanceState> get copyWith => _$AppAppearanceStateCopyWithImpl<AppAppearanceState>(this as AppAppearanceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppAppearanceState&&(identical(other.selectedLocale, selectedLocale) || other.selectedLocale == selectedLocale)&&(identical(other.brightness, brightness) || other.brightness == brightness)&&(identical(other.carIcon, carIcon) || other.carIcon == carIcon)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving));
}


@override
int get hashCode => Object.hash(runtimeType,selectedLocale,brightness,carIcon,isSaving);

@override
String toString() {
  return 'AppAppearanceState(selectedLocale: $selectedLocale, brightness: $brightness, carIcon: $carIcon, isSaving: $isSaving)';
}


}

/// @nodoc
abstract mixin class $AppAppearanceStateCopyWith<$Res>  {
  factory $AppAppearanceStateCopyWith(AppAppearanceState value, $Res Function(AppAppearanceState) _then) = _$AppAppearanceStateCopyWithImpl;
@useResult
$Res call({
 AppLocaleOptionModel selectedLocale, double brightness, CarIconType carIcon, bool isSaving
});




}
/// @nodoc
class _$AppAppearanceStateCopyWithImpl<$Res>
    implements $AppAppearanceStateCopyWith<$Res> {
  _$AppAppearanceStateCopyWithImpl(this._self, this._then);

  final AppAppearanceState _self;
  final $Res Function(AppAppearanceState) _then;

/// Create a copy of AppAppearanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedLocale = null,Object? brightness = null,Object? carIcon = null,Object? isSaving = null,}) {
  return _then(_self.copyWith(
selectedLocale: null == selectedLocale ? _self.selectedLocale : selectedLocale // ignore: cast_nullable_to_non_nullable
as AppLocaleOptionModel,brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as double,carIcon: null == carIcon ? _self.carIcon : carIcon // ignore: cast_nullable_to_non_nullable
as CarIconType,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppAppearanceState].
extension AppAppearanceStatePatterns on AppAppearanceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppAppearanceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppAppearanceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppAppearanceState value)  $default,){
final _that = this;
switch (_that) {
case _AppAppearanceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppAppearanceState value)?  $default,){
final _that = this;
switch (_that) {
case _AppAppearanceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppLocaleOptionModel selectedLocale,  double brightness,  CarIconType carIcon,  bool isSaving)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppAppearanceState() when $default != null:
return $default(_that.selectedLocale,_that.brightness,_that.carIcon,_that.isSaving);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppLocaleOptionModel selectedLocale,  double brightness,  CarIconType carIcon,  bool isSaving)  $default,) {final _that = this;
switch (_that) {
case _AppAppearanceState():
return $default(_that.selectedLocale,_that.brightness,_that.carIcon,_that.isSaving);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppLocaleOptionModel selectedLocale,  double brightness,  CarIconType carIcon,  bool isSaving)?  $default,) {final _that = this;
switch (_that) {
case _AppAppearanceState() when $default != null:
return $default(_that.selectedLocale,_that.brightness,_that.carIcon,_that.isSaving);case _:
  return null;

}
}

}

/// @nodoc


class _AppAppearanceState extends AppAppearanceState {
  const _AppAppearanceState({required this.selectedLocale, required this.brightness, required this.carIcon, this.isSaving = false}): super._();
  

@override final  AppLocaleOptionModel selectedLocale;
@override final  double brightness;
@override final  CarIconType carIcon;
@override@JsonKey() final  bool isSaving;

/// Create a copy of AppAppearanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppAppearanceStateCopyWith<_AppAppearanceState> get copyWith => __$AppAppearanceStateCopyWithImpl<_AppAppearanceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppAppearanceState&&(identical(other.selectedLocale, selectedLocale) || other.selectedLocale == selectedLocale)&&(identical(other.brightness, brightness) || other.brightness == brightness)&&(identical(other.carIcon, carIcon) || other.carIcon == carIcon)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving));
}


@override
int get hashCode => Object.hash(runtimeType,selectedLocale,brightness,carIcon,isSaving);

@override
String toString() {
  return 'AppAppearanceState(selectedLocale: $selectedLocale, brightness: $brightness, carIcon: $carIcon, isSaving: $isSaving)';
}


}

/// @nodoc
abstract mixin class _$AppAppearanceStateCopyWith<$Res> implements $AppAppearanceStateCopyWith<$Res> {
  factory _$AppAppearanceStateCopyWith(_AppAppearanceState value, $Res Function(_AppAppearanceState) _then) = __$AppAppearanceStateCopyWithImpl;
@override @useResult
$Res call({
 AppLocaleOptionModel selectedLocale, double brightness, CarIconType carIcon, bool isSaving
});




}
/// @nodoc
class __$AppAppearanceStateCopyWithImpl<$Res>
    implements _$AppAppearanceStateCopyWith<$Res> {
  __$AppAppearanceStateCopyWithImpl(this._self, this._then);

  final _AppAppearanceState _self;
  final $Res Function(_AppAppearanceState) _then;

/// Create a copy of AppAppearanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedLocale = null,Object? brightness = null,Object? carIcon = null,Object? isSaving = null,}) {
  return _then(_AppAppearanceState(
selectedLocale: null == selectedLocale ? _self.selectedLocale : selectedLocale // ignore: cast_nullable_to_non_nullable
as AppLocaleOptionModel,brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as double,carIcon: null == carIcon ? _self.carIcon : carIcon // ignore: cast_nullable_to_non_nullable
as CarIconType,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
