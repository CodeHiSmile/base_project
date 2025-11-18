import 'package:base_project/data/models/auth/api_token_data.dart';
import 'package:base_project/domain/models/entity/auth/token.dart';
import 'package:data/data.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ApiTokenDataMapper extends BaseDataMapper<ApiTokenData, Token> {
  @override
  Token mapToEntity(ApiTokenData? data) {
    return Token(
      accessToken: data?.accessToken ?? Token.defaultAccessToken,
      refreshToken: data?.refreshToken ?? Token.defaultRefreshToken,
    );
  }
}
