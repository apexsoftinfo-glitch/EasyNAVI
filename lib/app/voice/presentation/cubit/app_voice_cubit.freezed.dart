// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_voice_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppVoiceState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppVoiceState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppVoiceState()';
}


}

/// @nodoc
class $AppVoiceStateCopyWith<$Res>  {
$AppVoiceStateCopyWith(AppVoiceState _, $Res Function(AppVoiceState) __);
}


/// Adds pattern-matching-related methods to [AppVoiceState].
extension AppVoiceStatePatterns on AppVoiceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Loaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Loaded value)  loaded,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Loaded():
return loaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Loaded value)?  loaded,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( double speechRate,  double speechPitch)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loaded() when loaded != null:
return loaded(_that.speechRate,_that.speechPitch);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( double speechRate,  double speechPitch)  loaded,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case Loaded():
return loaded(_that.speechRate,_that.speechPitch);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( double speechRate,  double speechPitch)?  loaded,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loaded() when loaded != null:
return loaded(_that.speechRate,_that.speechPitch);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements AppVoiceState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppVoiceState.initial()';
}


}




/// @nodoc


class Loaded implements AppVoiceState {
  const Loaded({this.speechRate = 1.0, this.speechPitch = 1.0});
  

@JsonKey() final  double speechRate;
@JsonKey() final  double speechPitch;

/// Create a copy of AppVoiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&(identical(other.speechRate, speechRate) || other.speechRate == speechRate)&&(identical(other.speechPitch, speechPitch) || other.speechPitch == speechPitch));
}


@override
int get hashCode => Object.hash(runtimeType,speechRate,speechPitch);

@override
String toString() {
  return 'AppVoiceState.loaded(speechRate: $speechRate, speechPitch: $speechPitch)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $AppVoiceStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 double speechRate, double speechPitch
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of AppVoiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? speechRate = null,Object? speechPitch = null,}) {
  return _then(Loaded(
speechRate: null == speechRate ? _self.speechRate : speechRate // ignore: cast_nullable_to_non_nullable
as double,speechPitch: null == speechPitch ? _self.speechPitch : speechPitch // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
