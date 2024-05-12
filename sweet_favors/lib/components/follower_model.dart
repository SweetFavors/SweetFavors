class Follower {
  final int userId;
  final int followingId;
  final String followerUsername;
  final String followerUserPic;

  Follower(
      {required this.userId,
      required this.followingId,
      required this.followerUsername,
      required this.followerUserPic});

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      userId: json['user_id'],
      followingId: json['following_id'],
      followerUsername: json['follower_username'],
      followerUserPic: json['follower_user_pic'],
    );
  }
}
