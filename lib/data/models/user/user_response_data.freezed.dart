// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_response_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserResponseData {

 int? get id; String? get ssoId; int? get profileId; String? get username; String? get fullName; String? get phoneNumber; String? get email; String? get gender; List<String>? get roles;
/// Create a copy of UserResponseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserResponseDataCopyWith<UserResponseData> get copyWith => _$UserResponseDataCopyWithImpl<UserResponseData>(this as UserResponseData, _$identity);

  /// Serializes this UserResponseData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserResponseData&&(identical(other.id, id) || other.id == id)&&(identical(other.ssoId, ssoId) || other.ssoId == ssoId)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.gender, gender) || other.gender == gender)&&const DeepCollectionEquality().equals(other.roles, roles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ssoId,profileId,username,fullName,phoneNumber,email,gender,const DeepCollectionEquality().hash(roles));

@override
String toString() {
  return 'UserResponseData(id: $id, ssoId: $ssoId, profileId: $profileId, username: $username, fullName: $fullName, phoneNumber: $phoneNumber, email: $email, gender: $gender, roles: $roles)';
}


}

/// @nodoc
abstract mixin class $UserResponseDataCopyWith<$Res>  {
  factory $UserResponseDataCopyWith(UserResponseData value, $Res Function(UserResponseData) _then) = _$UserResponseDataCopyWithImpl;
@useResult
$Res call({
 int? id, String? ssoId, int? profileId, String? username, String? fullName, String? phoneNumber, String? email, String? gender, List<String>? roles
});




}
/// @nodoc
class _$UserResponseDataCopyWithImpl<$Res>
    implements $UserResponseDataCopyWith<$Res> {
  _$UserResponseDataCopyWithImpl(this._self, this._then);

  final UserResponseData _self;
  final $Res Function(UserResponseData) _then;

/// Create a copy of UserResponseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? ssoId = freezed,Object? profileId = freezed,Object? username = freezed,Object? fullName = freezed,Object? phoneNumber = freezed,Object? email = freezed,Object? gender = freezed,Object? roles = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,ssoId: freezed == ssoId ? _self.ssoId : ssoId // ignore: cast_nullable_to_non_nullable
as String?,profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,roles: freezed == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserResponseData].
extension UserResponseDataPatterns on UserResponseData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserResponseData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserResponseData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserResponseData value)  $default,){
final _that = this;
switch (_that) {
case _UserResponseData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserResponseData value)?  $default,){
final _that = this;
switch (_that) {
case _UserResponseData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? ssoId,  int? profileId,  String? username,  String? fullName,  String? phoneNumber,  String? email,  String? gender,  List<String>? roles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserResponseData() when $default != null:
return $default(_that.id,_that.ssoId,_that.profileId,_that.username,_that.fullName,_that.phoneNumber,_that.email,_that.gender,_that.roles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? ssoId,  int? profileId,  String? username,  String? fullName,  String? phoneNumber,  String? email,  String? gender,  List<String>? roles)  $default,) {final _that = this;
switch (_that) {
case _UserResponseData():
return $default(_that.id,_that.ssoId,_that.profileId,_that.username,_that.fullName,_that.phoneNumber,_that.email,_that.gender,_that.roles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? ssoId,  int? profileId,  String? username,  String? fullName,  String? phoneNumber,  String? email,  String? gender,  List<String>? roles)?  $default,) {final _that = this;
switch (_that) {
case _UserResponseData() when $default != null:
return $default(_that.id,_that.ssoId,_that.profileId,_that.username,_that.fullName,_that.phoneNumber,_that.email,_that.gender,_that.roles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserResponseData implements UserResponseData {
  const _UserResponseData({this.id, this.ssoId, this.profileId, this.username, this.fullName, this.phoneNumber, this.email, this.gender, final  List<String>? roles}): _roles = roles;
  factory _UserResponseData.fromJson(Map<String, dynamic> json) => _$UserResponseDataFromJson(json);

@override final  int? id;
@override final  String? ssoId;
@override final  int? profileId;
@override final  String? username;
@override final  String? fullName;
@override final  String? phoneNumber;
@override final  String? email;
@override final  String? gender;
 final  List<String>? _roles;
@override List<String>? get roles {
  final value = _roles;
  if (value == null) return null;
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of UserResponseData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserResponseDataCopyWith<_UserResponseData> get copyWith => __$UserResponseDataCopyWithImpl<_UserResponseData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserResponseDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserResponseData&&(identical(other.id, id) || other.id == id)&&(identical(other.ssoId, ssoId) || other.ssoId == ssoId)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.gender, gender) || other.gender == gender)&&const DeepCollectionEquality().equals(other._roles, _roles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ssoId,profileId,username,fullName,phoneNumber,email,gender,const DeepCollectionEquality().hash(_roles));

@override
String toString() {
  return 'UserResponseData(id: $id, ssoId: $ssoId, profileId: $profileId, username: $username, fullName: $fullName, phoneNumber: $phoneNumber, email: $email, gender: $gender, roles: $roles)';
}


}

/// @nodoc
abstract mixin class _$UserResponseDataCopyWith<$Res> implements $UserResponseDataCopyWith<$Res> {
  factory _$UserResponseDataCopyWith(_UserResponseData value, $Res Function(_UserResponseData) _then) = __$UserResponseDataCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? ssoId, int? profileId, String? username, String? fullName, String? phoneNumber, String? email, String? gender, List<String>? roles
});




}
/// @nodoc
class __$UserResponseDataCopyWithImpl<$Res>
    implements _$UserResponseDataCopyWith<$Res> {
  __$UserResponseDataCopyWithImpl(this._self, this._then);

  final _UserResponseData _self;
  final $Res Function(_UserResponseData) _then;

/// Create a copy of UserResponseData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? ssoId = freezed,Object? profileId = freezed,Object? username = freezed,Object? fullName = freezed,Object? phoneNumber = freezed,Object? email = freezed,Object? gender = freezed,Object? roles = freezed,}) {
  return _then(_UserResponseData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,ssoId: freezed == ssoId ? _self.ssoId : ssoId // ignore: cast_nullable_to_non_nullable
as String?,profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,roles: freezed == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
