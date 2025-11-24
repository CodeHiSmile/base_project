// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppState {

 LanguageCode get languageCode; bool get isDarkTheme; bool get debugOverlayButton; int get mainPageIndex;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.isDarkTheme, isDarkTheme) || other.isDarkTheme == isDarkTheme)&&(identical(other.debugOverlayButton, debugOverlayButton) || other.debugOverlayButton == debugOverlayButton)&&(identical(other.mainPageIndex, mainPageIndex) || other.mainPageIndex == mainPageIndex));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode,isDarkTheme,debugOverlayButton,mainPageIndex);

@override
String toString() {
  return 'AppState(languageCode: $languageCode, isDarkTheme: $isDarkTheme, debugOverlayButton: $debugOverlayButton, mainPageIndex: $mainPageIndex)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 LanguageCode languageCode, bool isDarkTheme, bool debugOverlayButton, int mainPageIndex
});




}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? languageCode = null,Object? isDarkTheme = null,Object? debugOverlayButton = null,Object? mainPageIndex = null,}) {
  return _then(_self.copyWith(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as LanguageCode,isDarkTheme: null == isDarkTheme ? _self.isDarkTheme : isDarkTheme // ignore: cast_nullable_to_non_nullable
as bool,debugOverlayButton: null == debugOverlayButton ? _self.debugOverlayButton : debugOverlayButton // ignore: cast_nullable_to_non_nullable
as bool,mainPageIndex: null == mainPageIndex ? _self.mainPageIndex : mainPageIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppState].
extension AppStatePatterns on AppState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppState value)  $default,){
final _that = this;
switch (_that) {
case _AppState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppState value)?  $default,){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LanguageCode languageCode,  bool isDarkTheme,  bool debugOverlayButton,  int mainPageIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.languageCode,_that.isDarkTheme,_that.debugOverlayButton,_that.mainPageIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LanguageCode languageCode,  bool isDarkTheme,  bool debugOverlayButton,  int mainPageIndex)  $default,) {final _that = this;
switch (_that) {
case _AppState():
return $default(_that.languageCode,_that.isDarkTheme,_that.debugOverlayButton,_that.mainPageIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LanguageCode languageCode,  bool isDarkTheme,  bool debugOverlayButton,  int mainPageIndex)?  $default,) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.languageCode,_that.isDarkTheme,_that.debugOverlayButton,_that.mainPageIndex);case _:
  return null;

}
}

}

/// @nodoc


class _AppState extends AppState {
  const _AppState({this.languageCode = LanguageCode.vi, this.isDarkTheme = false, this.debugOverlayButton = false, this.mainPageIndex = 0}): super._();
  

@override@JsonKey() final  LanguageCode languageCode;
@override@JsonKey() final  bool isDarkTheme;
@override@JsonKey() final  bool debugOverlayButton;
@override@JsonKey() final  int mainPageIndex;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.isDarkTheme, isDarkTheme) || other.isDarkTheme == isDarkTheme)&&(identical(other.debugOverlayButton, debugOverlayButton) || other.debugOverlayButton == debugOverlayButton)&&(identical(other.mainPageIndex, mainPageIndex) || other.mainPageIndex == mainPageIndex));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode,isDarkTheme,debugOverlayButton,mainPageIndex);

@override
String toString() {
  return 'AppState(languageCode: $languageCode, isDarkTheme: $isDarkTheme, debugOverlayButton: $debugOverlayButton, mainPageIndex: $mainPageIndex)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 LanguageCode languageCode, bool isDarkTheme, bool debugOverlayButton, int mainPageIndex
});




}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? languageCode = null,Object? isDarkTheme = null,Object? debugOverlayButton = null,Object? mainPageIndex = null,}) {
  return _then(_AppState(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as LanguageCode,isDarkTheme: null == isDarkTheme ? _self.isDarkTheme : isDarkTheme // ignore: cast_nullable_to_non_nullable
as bool,debugOverlayButton: null == debugOverlayButton ? _self.debugOverlayButton : debugOverlayButton // ignore: cast_nullable_to_non_nullable
as bool,mainPageIndex: null == mainPageIndex ? _self.mainPageIndex : mainPageIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
