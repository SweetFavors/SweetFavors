class Wishlist {
  int wishlistId;
  int userId;
  String itemname;
  int price;
  String? linkurl;
  String? itemPic;
  bool? alreadyBought; // Make it nullable to handle potential null values
  String? userNameOfGranter;
  String? userNameOfWishlist;
  int? grantedByUserId;

  Wishlist(
      {required this.wishlistId,
      required this.userId,
      required this.itemname,
      required this.price,
      this.linkurl,
      this.itemPic,
      this.alreadyBought,
      this.userNameOfGranter,
      this.userNameOfWishlist,
      this.grantedByUserId});

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
        wishlistId: json['wishlist_id'],
        userId: json['user_id'],
        itemname: json['itemname'],
        price: json['price'],
        linkurl: json['link_url'],
        itemPic: json['item_pic'],
        alreadyBought: json['already_bought'],
        userNameOfGranter: json['username_of_granter'],
        userNameOfWishlist: json['username_of_wishlist'],
        grantedByUserId: json['granted_by_user_id']);
  }
}

class WishlistItem {
  final int id;
  final String product;
  final String grantBy;
  final int price;
  final String linkUrl;
  final String itemPic;
  // ... other properties

  WishlistItem({
    required this.id,
    required this.product,
    required this.grantBy,
    required this.price,
    required this.linkUrl,
    required this.itemPic,
  });
}

class WishItem {
  final int wishlistId;
  final int userId;
  final String itemname;
  final int price;
  final String linkurl;
  final String itemPic;
  final bool? alreadyBought;
  final int? grantedByUserId;
  final String usernameOfWishlist;
  final String? picOfWishlistUser;

  WishItem(
      {required this.wishlistId,
      required this.userId,
      required this.itemname,
      required this.price,
      required this.linkurl,
      required this.itemPic,
      this.alreadyBought,
      this.grantedByUserId,
      required this.usernameOfWishlist,
      this.picOfWishlistUser});

  factory WishItem.fromJson(Map<String, dynamic> json) {
    return WishItem(
      wishlistId: json['wishlist_id'],
      userId: json['user_id'],
      itemname: json['itemname'],
      price: json['price'],
      linkurl: json['link_url'],
      itemPic: json['item_pic'],
      alreadyBought: json['already_bought'],
      grantedByUserId: json['granted_by_user_id'],
      usernameOfWishlist: json['username_of_wishlist'],
      picOfWishlistUser: json['user_pic_of_wishlist'],
    );
  }
}
