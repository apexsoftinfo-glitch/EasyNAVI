// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'directions_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DirectionsModel {

 LatLng get boundsSw; LatLng get boundsNe; List<LatLng> get polylinePoints; String get totalDistance; String get totalDuration;
/// Create a copy of DirectionsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DirectionsModelCopyWith<DirectionsModel> get copyWith => _$DirectionsModelCopyWithImpl<DirectionsModel>(this as DirectionsModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DirectionsModel&&(identical(other.boundsSw, boundsSw) || other.boundsSw == boundsSw)&&(identical(other.boundsNe, boundsNe) || other.boundsNe == boundsNe)&&const DeepCollectionEquality().equals(other.polylinePoints, polylinePoints)&&(identical(other.totalDistance, totalDistance) || other.totalDistance == totalDistance)&&(identical(other.totalDuration, totalDuration) || other.totalDuration == totalDuration));
}


@override
int get hashCode => Object.hash(runtimeType,boundsSw,boundsNe,const DeepCollectionEquality().hash(polylinePoints),totalDistance,totalDuration);

@override
String toString() {
  return 'DirectionsModel(boundsSw: $boundsSw, boundsNe: $boundsNe, polylinePoints: $polylinePoints, totalDistance: $totalDistance, totalDuration: $totalDuration)';
}


}

/// @nodoc
abstract mixin class $DirectionsModelCopyWith<$Res>  {
  factory $DirectionsModelCopyWith(DirectionsModel value, $Res Function(DirectionsModel) _then) = _$DirectionsModelCopyWithImpl;
@useResult
$Res call({
 LatLng boundsSw, LatLng boundsNe, List<LatLng> polylinePoints, String totalDistance, String totalDuration
});




}
/// @nodoc
class _$DirectionsModelCopyWithImpl<$Res>
    implements $DirectionsModelCopyWith<$Res> {
  _$DirectionsModelCopyWithImpl(this._self, this._then);

  final DirectionsModel _self;
  final $Res Function(DirectionsModel) _then;

/// Create a copy of DirectionsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? boundsSw = null,Object? boundsNe = null,Object? polylinePoints = null,Object? totalDistance = null,Object? totalDuration = null,}) {
  return _then(_self.copyWith(
boundsSw: null == boundsSw ? _self.boundsSw : boundsSw // ignore: cast_nullable_to_non_nullable
as LatLng,boundsNe: null == boundsNe ? _self.boundsNe : boundsNe // ignore: cast_nullable_to_non_nullable
as LatLng,polylinePoints: null == polylinePoints ? _self.polylinePoints : polylinePoints // ignore: cast_nullable_to_non_nullable
as List<LatLng>,totalDistance: null == totalDistance ? _self.totalDistance : totalDistance // ignore: cast_nullable_to_non_nullable
as String,totalDuration: null == totalDuration ? _self.totalDuration : totalDuration // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DirectionsModel].
extension DirectionsModelPatterns on DirectionsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DirectionsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DirectionsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DirectionsModel value)  $default,){
final _that = this;
switch (_that) {
case _DirectionsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DirectionsModel value)?  $default,){
final _that = this;
switch (_that) {
case _DirectionsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LatLng boundsSw,  LatLng boundsNe,  List<LatLng> polylinePoints,  String totalDistance,  String totalDuration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DirectionsModel() when $default != null:
return $default(_that.boundsSw,_that.boundsNe,_that.polylinePoints,_that.totalDistance,_that.totalDuration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LatLng boundsSw,  LatLng boundsNe,  List<LatLng> polylinePoints,  String totalDistance,  String totalDuration)  $default,) {final _that = this;
switch (_that) {
case _DirectionsModel():
return $default(_that.boundsSw,_that.boundsNe,_that.polylinePoints,_that.totalDistance,_that.totalDuration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LatLng boundsSw,  LatLng boundsNe,  List<LatLng> polylinePoints,  String totalDistance,  String totalDuration)?  $default,) {final _that = this;
switch (_that) {
case _DirectionsModel() when $default != null:
return $default(_that.boundsSw,_that.boundsNe,_that.polylinePoints,_that.totalDistance,_that.totalDuration);case _:
  return null;

}
}

}

/// @nodoc


class _DirectionsModel implements DirectionsModel {
  const _DirectionsModel({required this.boundsSw, required this.boundsNe, required final  List<LatLng> polylinePoints, required this.totalDistance, required this.totalDuration}): _polylinePoints = polylinePoints;
  

@override final  LatLng boundsSw;
@override final  LatLng boundsNe;
 final  List<LatLng> _polylinePoints;
@override List<LatLng> get polylinePoints {
  if (_polylinePoints is EqualUnmodifiableListView) return _polylinePoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_polylinePoints);
}

@override final  String totalDistance;
@override final  String totalDuration;

/// Create a copy of DirectionsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DirectionsModelCopyWith<_DirectionsModel> get copyWith => __$DirectionsModelCopyWithImpl<_DirectionsModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DirectionsModel&&(identical(other.boundsSw, boundsSw) || other.boundsSw == boundsSw)&&(identical(other.boundsNe, boundsNe) || other.boundsNe == boundsNe)&&const DeepCollectionEquality().equals(other._polylinePoints, _polylinePoints)&&(identical(other.totalDistance, totalDistance) || other.totalDistance == totalDistance)&&(identical(other.totalDuration, totalDuration) || other.totalDuration == totalDuration));
}


@override
int get hashCode => Object.hash(runtimeType,boundsSw,boundsNe,const DeepCollectionEquality().hash(_polylinePoints),totalDistance,totalDuration);

@override
String toString() {
  return 'DirectionsModel(boundsSw: $boundsSw, boundsNe: $boundsNe, polylinePoints: $polylinePoints, totalDistance: $totalDistance, totalDuration: $totalDuration)';
}


}

/// @nodoc
abstract mixin class _$DirectionsModelCopyWith<$Res> implements $DirectionsModelCopyWith<$Res> {
  factory _$DirectionsModelCopyWith(_DirectionsModel value, $Res Function(_DirectionsModel) _then) = __$DirectionsModelCopyWithImpl;
@override @useResult
$Res call({
 LatLng boundsSw, LatLng boundsNe, List<LatLng> polylinePoints, String totalDistance, String totalDuration
});




}
/// @nodoc
class __$DirectionsModelCopyWithImpl<$Res>
    implements _$DirectionsModelCopyWith<$Res> {
  __$DirectionsModelCopyWithImpl(this._self, this._then);

  final _DirectionsModel _self;
  final $Res Function(_DirectionsModel) _then;

/// Create a copy of DirectionsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? boundsSw = null,Object? boundsNe = null,Object? polylinePoints = null,Object? totalDistance = null,Object? totalDuration = null,}) {
  return _then(_DirectionsModel(
boundsSw: null == boundsSw ? _self.boundsSw : boundsSw // ignore: cast_nullable_to_non_nullable
as LatLng,boundsNe: null == boundsNe ? _self.boundsNe : boundsNe // ignore: cast_nullable_to_non_nullable
as LatLng,polylinePoints: null == polylinePoints ? _self._polylinePoints : polylinePoints // ignore: cast_nullable_to_non_nullable
as List<LatLng>,totalDistance: null == totalDistance ? _self.totalDistance : totalDistance // ignore: cast_nullable_to_non_nullable
as String,totalDuration: null == totalDuration ? _self.totalDuration : totalDuration // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
