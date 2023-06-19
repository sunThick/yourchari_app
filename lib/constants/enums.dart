// Stringにしたい
enum TokenType { following, likeChari, muteUser, mistake }

// 引数にTokenType.followingを入れるとStringの"following"がreturn
String returnTokenTypeString({required TokenType tokenType}) =>
    tokenType.toString().substring(10);

String followingTokenTypeString =
    returnTokenTypeString(tokenType: TokenType.following);

String likeChariTokenTypeString =
    returnTokenTypeString(tokenType: TokenType.likeChari);

String muteUserTokenTypeString =
    returnTokenTypeString(tokenType: TokenType.muteUser);

TokenType mapToTokenType({required Map<String, dynamic> tokenMap}) {
  final String tokenTypeString = tokenMap["tokenType"];
  if (tokenTypeString == followingTokenTypeString) {
    return TokenType.following;
  } else if (tokenTypeString == likeChariTokenTypeString) {
    return TokenType.likeChari;
  } else if (tokenTypeString == muteUserTokenTypeString) {
    return TokenType.muteUser;
  } else {
    return TokenType.mistake;
  }
}
