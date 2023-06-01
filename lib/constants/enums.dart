// Stringにしたい！！
enum TokenType { following, likePost, likeChari}
// 引数にTokenType.followingを入れるとStringの"following"がreturnされます
String returnTokenTypeString({ required TokenType tokenType })  => tokenType.toString().substring(10);
 
String followingTokenTypeString = returnTokenTypeString(tokenType: TokenType.following);
 
String likePostTokenTypeString = returnTokenTypeString(tokenType: TokenType.likePost);
 
TokenType mapToTokenType({required Map<String,dynamic> tokenMap}) {
  final String tokenTypeString = tokenMap["tokenType"];
  if(tokenTypeString == followingTokenTypeString) {
    return TokenType.following;
  } 
  else {
    return TokenType.likePost;
  }
}
