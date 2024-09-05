class UserDetailes {
   String? userId;
   String? deviceId;
   int? otp;

  UserDetailes({
     this.userId,
     this.deviceId,
     this.otp
  });

  factory UserDetailes.fromJson(Map<String, dynamic> json) {
    return UserDetailes(
      userId: json['userId'],
      deviceId: json['deviceId'],
      otp:  json["otp"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'deviceId': deviceId,
      "otp":otp
    };
  }
}