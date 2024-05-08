class Following {
  final int userId;
  final int followingId;
  final String followingUsername;
  final String followingUserPic;

  Following(
      {required this.userId,
      required this.followingId,
      required this.followingUsername,
      required this.followingUserPic});

  factory Following.fromJson(Map<String, dynamic> json) {
    return Following(
      userId: json['user_id'],
      followingId: json['following_id'],
      followingUsername: json['following_username'],
      followingUserPic: json['following_user_pic'],
    );
  }
}
