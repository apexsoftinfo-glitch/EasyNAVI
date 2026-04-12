// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'maps_search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapsSearchState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapsSearchState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MapsSearchState()';
}


}

/// @nodoc
class $MapsSearchStateCopyWith<$Res>  {
$MapsSearchStateCopyWith(MapsSearchState _, $Res Function(MapsSearchState) __);
}


/// Adds pattern-matching-related methods to [MapsSearchState].
extension MapsSearchStatePatterns on MapsSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( LoadingPredictions value)?  loading,TResult Function( LoadedPredictions value)?  loaded,TResult Function( Selected value)?  selected,TResult Function( SearchError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case LoadingPredictions() when loading != null:
return loading(_that);case LoadedPredictions() when loaded != null:
return loaded(_that);case Selected() when selected != null:
return selected(_that);case SearchError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( LoadingPredictions value)  loading,required TResult Function( LoadedPredictions value)  loaded,required TResult Function( Selected value)  selected,required TResult Function( SearchError value)  error,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case LoadingPredictions():
return loading(_that);case LoadedPredictions():
return loaded(_that);case Selected():
return selected(_that);case SearchError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( LoadingPredictions value)?  loading,TResult? Function( LoadedPredictions value)?  loaded,TResult? Function( Selected value)?  selected,TResult? Function( SearchError value)?  error,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case LoadingPredictions() when loading != null:
return loading(_that);case LoadedPredictions() when loaded != null:
return loaded(_that);case Selected() when selected != null:
return selected(_that);case SearchError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<PredictionModel> predictions)?  loaded,TResult Function( Map<String, String> details)?  selected,TResult Function( String errorKey)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case LoadingPredictions() when loading != null:
return loading();case LoadedPredictions() when loaded != null:
return loaded(_that.predictions);case Selected() when selected != null:
return selected(_that.details);case SearchError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<PredictionModel> predictions)  loaded,required TResult Function( Map<String, String> details)  selected,required TResult Function( String errorKey)  error,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case LoadingPredictions():
return loading();case LoadedPredictions():
return loaded(_that.predictions);case Selected():
return selected(_that.details);case SearchError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<PredictionModel> predictions)?  loaded,TResult? Function( Map<String, String> details)?  selected,TResult? Function( String errorKey)?  error,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case LoadingPredictions() when loading != null:
return loading();case LoadedPredictions() when loaded != null:
return loaded(_that.predictions);case Selected() when selected != null:
return selected(_that.details);case SearchError() when error != null:
return error(_that.errorKey);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements MapsSearchState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MapsSearchState.initial()';
}


}




/// @nodoc


class LoadingPredictions implements MapsSearchState {
  const LoadingPredictions();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingPredictions);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MapsSearchState.loading()';
}


}




/// @nodoc


class LoadedPredictions implements MapsSearchState {
  const LoadedPredictions(final  List<PredictionModel> predictions): _predictions = predictions;
  

 final  List<PredictionModel> _predictions;
 List<PredictionModel> get predictions {
  if (_predictions is EqualUnmodifiableListView) return _predictions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_predictions);
}


/// Create a copy of MapsSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedPredictionsCopyWith<LoadedPredictions> get copyWith => _$LoadedPredictionsCopyWithImpl<LoadedPredictions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedPredictions&&const DeepCollectionEquality().equals(other._predictions, _predictions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_predictions));

@override
String toString() {
  return 'MapsSearchState.loaded(predictions: $predictions)';
}


}

/// @nodoc
abstract mixin class $LoadedPredictionsCopyWith<$Res> implements $MapsSearchStateCopyWith<$Res> {
  factory $LoadedPredictionsCopyWith(LoadedPredictions value, $Res Function(LoadedPredictions) _then) = _$LoadedPredictionsCopyWithImpl;
@useResult
$Res call({
 List<PredictionModel> predictions
});




}
/// @nodoc
class _$LoadedPredictionsCopyWithImpl<$Res>
    implements $LoadedPredictionsCopyWith<$Res> {
  _$LoadedPredictionsCopyWithImpl(this._self, this._then);

  final LoadedPredictions _self;
  final $Res Function(LoadedPredictions) _then;

/// Create a copy of MapsSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? predictions = null,}) {
  return _then(LoadedPredictions(
null == predictions ? _self._predictions : predictions // ignore: cast_nullable_to_non_nullable
as List<PredictionModel>,
  ));
}


}

/// @nodoc


class Selected implements MapsSearchState {
  const Selected(final  Map<String, String> details): _details = details;
  

 final  Map<String, String> _details;
 Map<String, String> get details {
  if (_details is EqualUnmodifiableMapView) return _details;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_details);
}


/// Create a copy of MapsSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectedCopyWith<Selected> get copyWith => _$SelectedCopyWithImpl<Selected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Selected&&const DeepCollectionEquality().equals(other._details, _details));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_details));

@override
String toString() {
  return 'MapsSearchState.selected(details: $details)';
}


}

/// @nodoc
abstract mixin class $SelectedCopyWith<$Res> implements $MapsSearchStateCopyWith<$Res> {
  factory $SelectedCopyWith(Selected value, $Res Function(Selected) _then) = _$SelectedCopyWithImpl;
@useResult
$Res call({
 Map<String, String> details
});




}
/// @nodoc
class _$SelectedCopyWithImpl<$Res>
    implements $SelectedCopyWith<$Res> {
  _$SelectedCopyWithImpl(this._self, this._then);

  final Selected _self;
  final $Res Function(Selected) _then;

/// Create a copy of MapsSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? details = null,}) {
  return _then(Selected(
null == details ? _self._details : details // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

/// @nodoc


class SearchError implements MapsSearchState {
  const SearchError(this.errorKey);
  

 final  String errorKey;

/// Create a copy of MapsSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchErrorCopyWith<SearchError> get copyWith => _$SearchErrorCopyWithImpl<SearchError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchError&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey));
}


@override
int get hashCode => Object.hash(runtimeType,errorKey);

@override
String toString() {
  return 'MapsSearchState.error(errorKey: $errorKey)';
}


}

/// @nodoc
abstract mixin class $SearchErrorCopyWith<$Res> implements $MapsSearchStateCopyWith<$Res> {
  factory $SearchErrorCopyWith(SearchError value, $Res Function(SearchError) _then) = _$SearchErrorCopyWithImpl;
@useResult
$Res call({
 String errorKey
});




}
/// @nodoc
class _$SearchErrorCopyWithImpl<$Res>
    implements $SearchErrorCopyWith<$Res> {
  _$SearchErrorCopyWithImpl(this._self, this._then);

  final SearchError _self;
  final $Res Function(SearchError) _then;

/// Create a copy of MapsSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorKey = null,}) {
  return _then(SearchError(
null == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
