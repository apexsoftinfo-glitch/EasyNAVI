// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drive_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DriveState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DriveState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DriveState()';
}


}

/// @nodoc
class $DriveStateCopyWith<$Res>  {
$DriveStateCopyWith(DriveState _, $Res Function(DriveState) __);
}


/// Adds pattern-matching-related methods to [DriveState].
extension DriveStatePatterns on DriveState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( Loaded value)?  loaded,TResult Function( DriveError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Loaded() when loaded != null:
return loaded(_that);case DriveError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( Loaded value)  loaded,required TResult Function( DriveError value)  error,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Loading():
return loading(_that);case Loaded():
return loaded(_that);case DriveError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( Loaded value)?  loaded,TResult? Function( DriveError value)?  error,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Loaded() when loaded != null:
return loaded(_that);case DriveError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( LatLng origin,  LatLng destination,  DirectionsModel directions,  bool isNavigating,  int currentStepIndex,  LatLng? userPosition,  double bearing,  DateTime? startTime,  double traveledDistance,  double currentSpeed,  double distanceToNextStep,  int? currentSpeedLimit,  List<LatLng> nearbyRadars,  List<String> announcedRadarIds,  bool isArrived)?  loaded,TResult Function( String errorKey)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Loaded() when loaded != null:
return loaded(_that.origin,_that.destination,_that.directions,_that.isNavigating,_that.currentStepIndex,_that.userPosition,_that.bearing,_that.startTime,_that.traveledDistance,_that.currentSpeed,_that.distanceToNextStep,_that.currentSpeedLimit,_that.nearbyRadars,_that.announcedRadarIds,_that.isArrived);case DriveError() when error != null:
return error(_that.errorKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( LatLng origin,  LatLng destination,  DirectionsModel directions,  bool isNavigating,  int currentStepIndex,  LatLng? userPosition,  double bearing,  DateTime? startTime,  double traveledDistance,  double currentSpeed,  double distanceToNextStep,  int? currentSpeedLimit,  List<LatLng> nearbyRadars,  List<String> announcedRadarIds,  bool isArrived)  loaded,required TResult Function( String errorKey)  error,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case Loading():
return loading();case Loaded():
return loaded(_that.origin,_that.destination,_that.directions,_that.isNavigating,_that.currentStepIndex,_that.userPosition,_that.bearing,_that.startTime,_that.traveledDistance,_that.currentSpeed,_that.distanceToNextStep,_that.currentSpeedLimit,_that.nearbyRadars,_that.announcedRadarIds,_that.isArrived);case DriveError():
return error(_that.errorKey);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( LatLng origin,  LatLng destination,  DirectionsModel directions,  bool isNavigating,  int currentStepIndex,  LatLng? userPosition,  double bearing,  DateTime? startTime,  double traveledDistance,  double currentSpeed,  double distanceToNextStep,  int? currentSpeedLimit,  List<LatLng> nearbyRadars,  List<String> announcedRadarIds,  bool isArrived)?  loaded,TResult? Function( String errorKey)?  error,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Loaded() when loaded != null:
return loaded(_that.origin,_that.destination,_that.directions,_that.isNavigating,_that.currentStepIndex,_that.userPosition,_that.bearing,_that.startTime,_that.traveledDistance,_that.currentSpeed,_that.distanceToNextStep,_that.currentSpeedLimit,_that.nearbyRadars,_that.announcedRadarIds,_that.isArrived);case DriveError() when error != null:
return error(_that.errorKey);case _:
  return null;

}
}

}

/// @nodoc


class Initial with DiagnosticableTreeMixin implements DriveState {
  const Initial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DriveState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DriveState.initial()';
}


}




/// @nodoc


class Loading with DiagnosticableTreeMixin implements DriveState {
  const Loading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DriveState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DriveState.loading()';
}


}




/// @nodoc


class Loaded with DiagnosticableTreeMixin implements DriveState {
  const Loaded({required this.origin, required this.destination, required this.directions, this.isNavigating = false, this.currentStepIndex = 0, this.userPosition, this.bearing = 0, this.startTime, this.traveledDistance = 0, this.currentSpeed = 0, this.distanceToNextStep = 0, this.currentSpeedLimit, final  List<LatLng> nearbyRadars = const [], final  List<String> announcedRadarIds = const [], this.isArrived = false}): _nearbyRadars = nearbyRadars,_announcedRadarIds = announcedRadarIds;
  

 final  LatLng origin;
 final  LatLng destination;
 final  DirectionsModel directions;
@JsonKey() final  bool isNavigating;
@JsonKey() final  int currentStepIndex;
 final  LatLng? userPosition;
@JsonKey() final  double bearing;
 final  DateTime? startTime;
@JsonKey() final  double traveledDistance;
@JsonKey() final  double currentSpeed;
@JsonKey() final  double distanceToNextStep;
 final  int? currentSpeedLimit;
 final  List<LatLng> _nearbyRadars;
@JsonKey() List<LatLng> get nearbyRadars {
  if (_nearbyRadars is EqualUnmodifiableListView) return _nearbyRadars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nearbyRadars);
}

 final  List<String> _announcedRadarIds;
@JsonKey() List<String> get announcedRadarIds {
  if (_announcedRadarIds is EqualUnmodifiableListView) return _announcedRadarIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_announcedRadarIds);
}

@JsonKey() final  bool isArrived;

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DriveState.loaded'))
    ..add(DiagnosticsProperty('origin', origin))..add(DiagnosticsProperty('destination', destination))..add(DiagnosticsProperty('directions', directions))..add(DiagnosticsProperty('isNavigating', isNavigating))..add(DiagnosticsProperty('currentStepIndex', currentStepIndex))..add(DiagnosticsProperty('userPosition', userPosition))..add(DiagnosticsProperty('bearing', bearing))..add(DiagnosticsProperty('startTime', startTime))..add(DiagnosticsProperty('traveledDistance', traveledDistance))..add(DiagnosticsProperty('currentSpeed', currentSpeed))..add(DiagnosticsProperty('distanceToNextStep', distanceToNextStep))..add(DiagnosticsProperty('currentSpeedLimit', currentSpeedLimit))..add(DiagnosticsProperty('nearbyRadars', nearbyRadars))..add(DiagnosticsProperty('announcedRadarIds', announcedRadarIds))..add(DiagnosticsProperty('isArrived', isArrived));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.directions, directions) || other.directions == directions)&&(identical(other.isNavigating, isNavigating) || other.isNavigating == isNavigating)&&(identical(other.currentStepIndex, currentStepIndex) || other.currentStepIndex == currentStepIndex)&&(identical(other.userPosition, userPosition) || other.userPosition == userPosition)&&(identical(other.bearing, bearing) || other.bearing == bearing)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.traveledDistance, traveledDistance) || other.traveledDistance == traveledDistance)&&(identical(other.currentSpeed, currentSpeed) || other.currentSpeed == currentSpeed)&&(identical(other.distanceToNextStep, distanceToNextStep) || other.distanceToNextStep == distanceToNextStep)&&(identical(other.currentSpeedLimit, currentSpeedLimit) || other.currentSpeedLimit == currentSpeedLimit)&&const DeepCollectionEquality().equals(other._nearbyRadars, _nearbyRadars)&&const DeepCollectionEquality().equals(other._announcedRadarIds, _announcedRadarIds)&&(identical(other.isArrived, isArrived) || other.isArrived == isArrived));
}


@override
int get hashCode => Object.hash(runtimeType,origin,destination,directions,isNavigating,currentStepIndex,userPosition,bearing,startTime,traveledDistance,currentSpeed,distanceToNextStep,currentSpeedLimit,const DeepCollectionEquality().hash(_nearbyRadars),const DeepCollectionEquality().hash(_announcedRadarIds),isArrived);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DriveState.loaded(origin: $origin, destination: $destination, directions: $directions, isNavigating: $isNavigating, currentStepIndex: $currentStepIndex, userPosition: $userPosition, bearing: $bearing, startTime: $startTime, traveledDistance: $traveledDistance, currentSpeed: $currentSpeed, distanceToNextStep: $distanceToNextStep, currentSpeedLimit: $currentSpeedLimit, nearbyRadars: $nearbyRadars, announcedRadarIds: $announcedRadarIds, isArrived: $isArrived)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $DriveStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 LatLng origin, LatLng destination, DirectionsModel directions, bool isNavigating, int currentStepIndex, LatLng? userPosition, double bearing, DateTime? startTime, double traveledDistance, double currentSpeed, double distanceToNextStep, int? currentSpeedLimit, List<LatLng> nearbyRadars, List<String> announcedRadarIds, bool isArrived
});


$DirectionsModelCopyWith<$Res> get directions;

}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? origin = null,Object? destination = null,Object? directions = null,Object? isNavigating = null,Object? currentStepIndex = null,Object? userPosition = freezed,Object? bearing = null,Object? startTime = freezed,Object? traveledDistance = null,Object? currentSpeed = null,Object? distanceToNextStep = null,Object? currentSpeedLimit = freezed,Object? nearbyRadars = null,Object? announcedRadarIds = null,Object? isArrived = null,}) {
  return _then(Loaded(
origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as LatLng,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as LatLng,directions: null == directions ? _self.directions : directions // ignore: cast_nullable_to_non_nullable
as DirectionsModel,isNavigating: null == isNavigating ? _self.isNavigating : isNavigating // ignore: cast_nullable_to_non_nullable
as bool,currentStepIndex: null == currentStepIndex ? _self.currentStepIndex : currentStepIndex // ignore: cast_nullable_to_non_nullable
as int,userPosition: freezed == userPosition ? _self.userPosition : userPosition // ignore: cast_nullable_to_non_nullable
as LatLng?,bearing: null == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,traveledDistance: null == traveledDistance ? _self.traveledDistance : traveledDistance // ignore: cast_nullable_to_non_nullable
as double,currentSpeed: null == currentSpeed ? _self.currentSpeed : currentSpeed // ignore: cast_nullable_to_non_nullable
as double,distanceToNextStep: null == distanceToNextStep ? _self.distanceToNextStep : distanceToNextStep // ignore: cast_nullable_to_non_nullable
as double,currentSpeedLimit: freezed == currentSpeedLimit ? _self.currentSpeedLimit : currentSpeedLimit // ignore: cast_nullable_to_non_nullable
as int?,nearbyRadars: null == nearbyRadars ? _self._nearbyRadars : nearbyRadars // ignore: cast_nullable_to_non_nullable
as List<LatLng>,announcedRadarIds: null == announcedRadarIds ? _self._announcedRadarIds : announcedRadarIds // ignore: cast_nullable_to_non_nullable
as List<String>,isArrived: null == isArrived ? _self.isArrived : isArrived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DirectionsModelCopyWith<$Res> get directions {
  
  return $DirectionsModelCopyWith<$Res>(_self.directions, (value) {
    return _then(_self.copyWith(directions: value));
  });
}
}

/// @nodoc


class DriveError with DiagnosticableTreeMixin implements DriveState {
  const DriveError(this.errorKey);
  

 final  String errorKey;

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveErrorCopyWith<DriveError> get copyWith => _$DriveErrorCopyWithImpl<DriveError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DriveState.error'))
    ..add(DiagnosticsProperty('errorKey', errorKey));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveError&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey));
}


@override
int get hashCode => Object.hash(runtimeType,errorKey);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DriveState.error(errorKey: $errorKey)';
}


}

/// @nodoc
abstract mixin class $DriveErrorCopyWith<$Res> implements $DriveStateCopyWith<$Res> {
  factory $DriveErrorCopyWith(DriveError value, $Res Function(DriveError) _then) = _$DriveErrorCopyWithImpl;
@useResult
$Res call({
 String errorKey
});




}
/// @nodoc
class _$DriveErrorCopyWithImpl<$Res>
    implements $DriveErrorCopyWith<$Res> {
  _$DriveErrorCopyWithImpl(this._self, this._then);

  final DriveError _self;
  final $Res Function(DriveError) _then;

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorKey = null,}) {
  return _then(DriveError(
null == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
