class Wishlist {
  int wishlistId;
  int userId;
  String itemname;
  int quantity;
  int price;
  String linkurl;
  String itemPic;
  bool? alreadyBought; // Make it nullable to handle potential null values

  Wishlist({
    required this.wishlistId,
    required this.userId,
    required this.itemname,
    required this.quantity,
    required this.price,
    required this.linkurl,
    required this.itemPic,
    this.alreadyBought,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      wishlistId: json['wishlist_id'],
      userId: json['user_id'],
      itemname: json['itemname'],
      quantity: json['quantity'],
      price: json['price'],
      linkurl: json['linkurl'],
      itemPic: json['item_pic'],
      alreadyBought: json['already_bought'],
    );
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
