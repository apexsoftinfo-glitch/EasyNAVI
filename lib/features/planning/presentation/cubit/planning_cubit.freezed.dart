// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planning_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanningState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanningState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlanningState()';
}


}

/// @nodoc
class $PlanningStateCopyWith<$Res>  {
$PlanningStateCopyWith(PlanningState _, $Res Function(PlanningState) __);
}


/// Adds pattern-matching-related methods to [PlanningState].
extension PlanningStatePatterns on PlanningState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( Loaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Loaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( Loaded value)  loaded,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Loading():
return loading(_that);case Loaded():
return loaded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( Loaded value)?  loaded,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Loaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<AddressModel> allAddresses,  List<String> selectedAddressIds,  List<AddressModel> plannedAddresses,  int currentIndex,  String? errorKey)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Loaded() when loaded != null:
return loaded(_that.allAddresses,_that.selectedAddressIds,_that.plannedAddresses,_that.currentIndex,_that.errorKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<AddressModel> allAddresses,  List<String> selectedAddressIds,  List<AddressModel> plannedAddresses,  int currentIndex,  String? errorKey)  loaded,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case Loading():
return loading();case Loaded():
return loaded(_that.allAddresses,_that.selectedAddressIds,_that.plannedAddresses,_that.currentIndex,_that.errorKey);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<AddressModel> allAddresses,  List<String> selectedAddressIds,  List<AddressModel> plannedAddresses,  int currentIndex,  String? errorKey)?  loaded,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Loaded() when loaded != null:
return loaded(_that.allAddresses,_that.selectedAddressIds,_that.plannedAddresses,_that.currentIndex,_that.errorKey);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements PlanningState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlanningState.initial()';
}


}




/// @nodoc


class Loading implements PlanningState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlanningState.loading()';
}


}




/// @nodoc


class Loaded implements PlanningState {
  const Loaded({final  List<AddressModel> allAddresses = const [], final  List<String> selectedAddressIds = const [], final  List<AddressModel> plannedAddresses = const [], this.currentIndex = 0, this.errorKey}): _allAddresses = allAddresses,_selectedAddressIds = selectedAddressIds,_plannedAddresses = plannedAddresses;
  

 final  List<AddressModel> _allAddresses;
@JsonKey() List<AddressModel> get allAddresses {
  if (_allAddresses is EqualUnmodifiableListView) return _allAddresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allAddresses);
}

 final  List<String> _selectedAddressIds;
@JsonKey() List<String> get selectedAddressIds {
  if (_selectedAddressIds is EqualUnmodifiableListView) return _selectedAddressIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedAddressIds);
}

 final  List<AddressModel> _plannedAddresses;
@JsonKey() List<AddressModel> get plannedAddresses {
  if (_plannedAddresses is EqualUnmodifiableListView) return _plannedAddresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plannedAddresses);
}

@JsonKey() final  int currentIndex;
 final  String? errorKey;

/// Create a copy of PlanningState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._allAddresses, _allAddresses)&&const DeepCollectionEquality().equals(other._selectedAddressIds, _selectedAddressIds)&&const DeepCollectionEquality().equals(other._plannedAddresses, _plannedAddresses)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_allAddresses),const DeepCollectionEquality().hash(_selectedAddressIds),const DeepCollectionEquality().hash(_plannedAddresses),currentIndex,errorKey);

@override
String toString() {
  return 'PlanningState.loaded(allAddresses: $allAddresses, selectedAddressIds: $selectedAddressIds, plannedAddresses: $plannedAddresses, currentIndex: $currentIndex, errorKey: $errorKey)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $PlanningStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<AddressModel> allAddresses, List<String> selectedAddressIds, List<AddressModel> plannedAddresses, int currentIndex, String? errorKey
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of PlanningState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? allAddresses = null,Object? selectedAddressIds = null,Object? plannedAddresses = null,Object? currentIndex = null,Object? errorKey = freezed,}) {
  return _then(Loaded(
allAddresses: null == allAddresses ? _self._allAddresses : allAddresses // ignore: cast_nullable_to_non_nullable
as List<AddressModel>,selectedAddressIds: null == selectedAddressIds ? _self._selectedAddressIds : selectedAddressIds // ignore: cast_nullable_to_non_nullable
as List<String>,plannedAddresses: null == plannedAddresses ? _self._plannedAddresses : plannedAddresses // ignore: cast_nullable_to_non_nullable
as List<AddressModel>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
