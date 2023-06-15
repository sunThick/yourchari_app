// Stringにしたい
enum TokenType { following, likeChari}
// 引数にTokenType.followingを入れるとStringの"following"がreturn
String returnTokenTypeString({ required TokenType tokenType })  => tokenType.toString().substring(10);
 
String followingTokenTypeString = returnTokenTypeString(tokenType: TokenType.following);
 
String likeChariTokenTypeString = returnTokenTypeString(tokenType: TokenType.likeChari);
 
TokenType mapToTokenType({required Map<String,dynamic> tokenMap}) {
  final String tokenTypeString = tokenMap["tokenType"];
  if(tokenTypeString == followingTokenTypeString) {
    return TokenType.following;
  } 
  else {
    return TokenType.likeChari;
  }
}