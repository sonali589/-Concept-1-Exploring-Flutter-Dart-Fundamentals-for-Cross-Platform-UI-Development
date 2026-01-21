import '../models/product.dart';

class ProductData {
  static List<Product> getAllProducts() {
    return [
      Product(
        id: '1',
        name: 'Long Frock',
        category: 'Trending',
        description: 'Casual wear,cotton',
        price: 599,
        imageUrl: 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=400',
      ),
      Product(
        id: '2',
        name: 'Korean Style T-shirt With Collar Style',
        category: 'New',
        description: 'Casual wear',
        price: 225,
        imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
      ),
      Product(
        id: '3',
        name: 'Xmas Vibes Christmas T shirt',
        category: 'Trending',
        description: 'Casual wear,cotton',
        price: 450,
        imageUrl: 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=400',
      ),
      Product(
        id: '4',
        name: 'Summer Dress',
        category: 'New',
        description: 'Light and breezy',
        price: 799,
        imageUrl: 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=400',
      ),
      Product(
        id: '5',
        name: 'Denim Jacket',
        category: 'All',
        description: 'Classic denim',
        price: 1299,
        imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400',
      ),
      Product(
        id: '6',
        name: 'Floral Top',
        category: 'Trending',
        description: 'Trendy floral print',
        price: 399,
        imageUrl: 'https://images.unsplash.com/photo-1564859228273-274232fdb516?w=400',
      ),
    ];
  }
}
