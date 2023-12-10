class TokenDetail {
  String? token;
  String? expires;

  TokenDetail({
    this.token,
    this.expires,
  });

  TokenDetail.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'expires': expires,
  };
}


class Token {
  TokenDetail? access;
  TokenDetail? refresh;

  Token.fromJson(Map<String, dynamic> json) {
    access = TokenDetail.fromJson(json['access']);
    refresh = TokenDetail.fromJson(json['refresh']);
  }

  Map<String, dynamic> toJson() => {
    'access': access?.toJson(),
    'refresh': refresh?.toJson(),
  };
}