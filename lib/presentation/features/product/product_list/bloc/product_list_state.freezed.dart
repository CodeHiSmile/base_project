// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductListState {

 LoadingStatus? get loadStatus;
/// Create a copy of ProductListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductListStateCopyWith<ProductListState> get copyWith => _$ProductListStateCopyWithImpl<ProductListState>(this as ProductListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductListState&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus));
}


@override
int get hashCode => Object.hash(runtimeType,loadStatus);

@override
String toString() {
  return 'ProductListState(loadStatus: $loadStatus)';
}


}

/// @nodoc
abstract mixin class $ProductListStateCopyWith<$Res>  {
  factory $ProductListStateCopyWith(ProductListState value, $Res Function(ProductListState) _then) = _$ProductListStateCopyWithImpl;
@useResult
$Res call({
 LoadingStatus? loadStatus
});




}
/// @nodoc
class _$ProductListStateCopyWithImpl<$Res>
    implements $ProductListStateCopyWith<$Res> {
  _$ProductListStateCopyWithImpl(this._self, this._then);

  final ProductListState _self;
  final $Res Function(ProductListState) _then;

/// Create a copy of ProductListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loadStatus = freezed,}) {
  return _then(_self.copyWith(
loadStatus: freezed == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as LoadingStatus?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductListState].
extension ProductListStatePatterns on ProductListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductListState value)  $default,){
final _that = this;
switch (_that) {
case _ProductListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductListState value)?  $default,){
final _that = this;
switch (_that) {
case _ProductListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadingStatus? loadStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductListState() when $default != null:
return $default(_that.loadStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadingStatus? loadStatus)  $default,) {final _that = this;
switch (_that) {
case _ProductListState():
return $default(_that.loadStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadingStatus? loadStatus)?  $default,) {final _that = this;
switch (_that) {
case _ProductListState() when $default != null:
return $default(_that.loadStatus);case _:
  return null;

}
}

}

/// @nodoc


class _ProductListState extends ProductListState {
  const _ProductListState({this.loadStatus = LoadingStatus.initial}): super._();
  

@override@JsonKey() final  LoadingStatus? loadStatus;

/// Create a copy of ProductListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductListStateCopyWith<_ProductListState> get copyWith => __$ProductListStateCopyWithImpl<_ProductListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductListState&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus));
}


@override
int get hashCode => Object.hash(runtimeType,loadStatus);

@override
String toString() {
  return 'ProductListState(loadStatus: $loadStatus)';
}


}

/// @nodoc
abstract mixin class _$ProductListStateCopyWith<$Res> implements $ProductListStateCopyWith<$Res> {
  factory _$ProductListStateCopyWith(_ProductListState value, $Res Function(_ProductListState) _then) = __$ProductListStateCopyWithImpl;
@override @useResult
$Res call({
 LoadingStatus? loadStatus
});




}
/// @nodoc
class __$ProductListStateCopyWithImpl<$Res>
    implements _$ProductListStateCopyWith<$Res> {
  __$ProductListStateCopyWithImpl(this._self, this._then);

  final _ProductListState _self;
  final $Res Function(_ProductListState) _then;

/// Create a copy of ProductListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loadStatus = freezed,}) {
  return _then(_ProductListState(
loadStatus: freezed == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as LoadingStatus?,
  ));
}


}

// dart format on
