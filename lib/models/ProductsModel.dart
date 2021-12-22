class ProductModel {
  String id;
  String name;
  int price;
  int quantity;
  int amount;
  int productDiscount;
  String image;
  int sp;

  int sellingPrice;

  ProductModel(
      {this.id,
      this.name,
      this.price,
      this.quantity,
      this.image,
      this.sellingPrice});
}
