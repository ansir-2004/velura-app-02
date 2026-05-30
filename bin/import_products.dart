import 'dart:convert';
import 'dart:io';

// Product catalog categorized by section
final Map<String, List<Map<String, dynamic>>> catalog = {
  'women': [
    {
      "title": "Vibrant Statement Dresses",
      "price": 145.00,
      "currency": "USD",
      "category": "Party Wear",
      "sizes": ["S", "M", "L"],
      "imageUrl": "https://images.pexels.com/photos/31094913/pexels-photo-31094913.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/fashion-portrait-of-two-women-in-vibrant-dresses-31094913/",
      "description": "Bold and vibrant dresses designed to make a statement at any social gathering.",
      "inStock": true
    },
    {
      "title": "Classic Evening Silhouette",
      "price": 220.00,
      "currency": "USD",
      "category": "Evening Wear",
      "sizes": ["XS", "S", "M", "L"],
      "imageUrl": "https://images.pexels.com/photos/14801160/pexels-photo-14801160.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/standing-woman-in-evening-dress-14801160/",
      "description": "A timeless evening dress with an elegant drape, perfect for formal occasions.",
      "inStock": true
    },
    {
      "title": "Sapphire Blue Sundress",
      "price": 85.50,
      "currency": "USD",
      "category": "Casual",
      "sizes": ["S", "M", "L", "XL"],
      "imageUrl": "https://images.pexels.com/photos/10324427/pexels-photo-10324427.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/a-fashionable-woman-in-blue-dress-10324427/",
      "description": "A fashionable and breezy blue dress suitable for daytime outings and summer weather.",
      "inStock": true
    },
    {
      "title": "Modern Minimalist Gowns",
      "price": 195.00,
      "currency": "USD",
      "category": "Evening Wear",
      "sizes": ["S", "M"],
      "imageUrl": "https://images.pexels.com/photos/4295842/pexels-photo-4295842.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/a-women-standing-back-to-back-4295842/",
      "description": "Sleek, modern gowns with a minimalist aesthetic for a highly sophisticated look.",
      "inStock": false
    },
    {
      "title": "Midnight Blue Velvet Dress",
      "price": 175.00,
      "currency": "USD",
      "category": "Evening Wear",
      "sizes": ["M", "L", "XL"],
      "imageUrl": "https://images.pexels.com/photos/28698708/pexels-photo-28698708.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/elegant-portrait-of-woman-in-dark-blue-dress-28698708/",
      "description": "An elegant dark blue dress featuring rich textures and a flattering portrait neckline.",
      "inStock": true
    },
    {
      "title": "Milan Gallery Pink Couture",
      "price": 310.00,
      "currency": "USD",
      "category": "Couture",
      "sizes": ["XS", "S", "M"],
      "imageUrl": "https://images.pexels.com/photos/31969033/pexels-photo-31969033.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/elegant-female-model-in-pink-dress-at-milan-gallery-31969033/",
      "description": "A high-fashion pink couture dress inspired by European gallery elegance.",
      "inStock": true
    }
  ],
  'men': [
    {
      "title": "Classic Checkered Tailored Vest",
      "price": 65.00,
      "currency": "USD",
      "category": "Formal Wear",
      "sizes": ["S", "M", "L", "XL"],
      "imageUrl": "https://images.pexels.com/photos/3771317/pexels-photo-3771317.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/bearded-man-wearing-checkered-vest-3771317/",
      "description": "A sharp, classic checkered vest that adds a layer of sophistication to any formal outfit.",
      "inStock": true
    },
    {
      "title": "Silver Cufflinks & Navy Shirt Set",
      "price": 45.00,
      "currency": "USD",
      "category": "Accessories",
      "sizes": ["One Size"],
      "imageUrl": "https://images.pexels.com/photos/17076311/pexels-photo-17076311.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/cuff-link-on-a-navy-blue-shirt-17076311/",
      "description": "Elegant silver cufflinks paired perfectly against a rich navy blue dress shirt for a polished look.",
      "inStock": true
    },
    {
      "title": "Premium Silver Wristwatch",
      "price": 150.00,
      "currency": "USD",
      "category": "Accessories",
      "sizes": ["One Size"],
      "imageUrl": "https://images.pexels.com/photos/8257325/pexels-photo-8257325.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/a-person-in-blue-suit-wearing-silver-watch-8257325/",
      "description": "A minimalist, premium silver timepiece that complements tailored suits and business attire.",
      "inStock": true
    },
    {
      "title": "Classic Leather Oxford Shoes",
      "price": 120.00,
      "currency": "USD",
      "category": "Footwear",
      "sizes": ["US 8", "US 9", "US 10", "US 11"],
      "imageUrl": "https://images.pexels.com/photos/2897533/pexels-photo-2897533.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/man-s-feet-hanging-2897533/",
      "description": "Timeless leather dress shoes designed for comfort and professional elegance.",
      "inStock": true
    },
    {
      "title": "Tailored Chino Trousers Collection",
      "price": 55.00,
      "currency": "USD",
      "category": "Casual Bottoms",
      "sizes": ["30x32", "32x32", "34x32", "36x32"],
      "imageUrl": "https://images.pexels.com/photos/11176394/pexels-photo-11176394.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/a-stack-of-pants-on-a-bar-stool-11176394/",
      "description": "Versatile and comfortable tailored chinos, perfect for smart-casual office days or weekend wear.",
      "inStock": false
    },
    {
      "title": "Modern Urban Overcoat",
      "price": 185.00,
      "currency": "USD",
      "category": "Outerwear",
      "sizes": ["M", "L", "XL"],
      "imageUrl": "https://images.pexels.com/photos/16219794/pexels-photo-16219794.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/man-leaning-on-wall-16219794/",
      "description": "A sleek, structured overcoat that provides excellent warmth while maintaining a modern silhouette.",
      "inStock": true
    }
  ],
  'kids': [
    {
      "title": "Classic Denim Jumpers",
      "price": 35.00,
      "currency": "USD",
      "category": "Kids Casual",
      "sizes": ["2T", "3T", "4T", "5T"],
      "imageUrl": "https://images.pexels.com/photos/4048011/pexels-photo-4048011.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/photo-of-boy-wearing-denim-jumpers-4048011/",
      "description": "Durable and comfortable denim overalls, perfect for active toddlers and playtime.",
      "inStock": true
    },
    {
      "title": "Vibrant Red Party Dress",
      "price": 42.00,
      "currency": "USD",
      "category": "Kids Formal Wear",
      "sizes": ["4", "5", "6", "7"],
      "imageUrl": "https://images.pexels.com/photos/2835723/pexels-photo-2835723.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/girl-in-red-dress-2835723/",
      "description": "A bright and cheerful red dress with a beautiful silhouette for special occasions.",
      "inStock": true
    },
    {
      "title": "Retro Polka Dot Dress",
      "price": 38.50,
      "currency": "USD",
      "category": "Kids Casual",
      "sizes": ["3T", "4T", "5T", "6"],
      "imageUrl": "https://images.pexels.com/photos/9998353/pexels-photo-9998353.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/photograph-of-a-child-wearing-a-black-and-white-polka-dot-dress-9998353/",
      "description": "A fun and classic black-and-white polka dot dress that is lightweight and breathable.",
      "inStock": true
    },
    {
      "title": "Casual Outfit & Hairband Set",
      "price": 29.00,
      "currency": "USD",
      "category": "Kids Sets",
      "sizes": ["5", "6", "8", "10"],
      "imageUrl": "https://images.pexels.com/photos/18833104/pexels-photo-18833104.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/a-young-girl-in-a-casual-outfit-wearing-a-hairband-18833104/",
      "description": "A stylish and comfortable everyday outfit that comes complete with a matching hairband.",
      "inStock": false
    }
  ],
  'accessories': [
    {
      "title": "Elegant Bridal Accessories Set",
      "price": 120.00,
      "currency": "USD",
      "category": "Bridal Accessories",
      "sizes": ["One Size"],
      "imageUrl": "https://images.pexels.com/photos/35556925/pexels-photo-35556925.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/elegant-wedding-accessories-flat-lay-with-shoes-35556925/",
      "description": "A sophisticated collection of bridal accessories, perfect for adding the finishing touches to a wedding day look.",
      "inStock": true
    },
    {
      "title": "Rustic Wedding Jewelry Collection",
      "price": 85.00,
      "currency": "USD",
      "category": "Bridal Accessories",
      "sizes": ["One Size"],
      "imageUrl": "https://images.pexels.com/photos/28948506/pexels-photo-28948506.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/rustic-wedding-jewelry-arranged-with-sneakers-28948506/",
      "description": "Beautifully crafted rustic jewelry pieces designed for a charming, bohemian-inspired wedding aesthetic.",
      "inStock": true
    },
    {
      "title": "Elegant Shell Statement Bracelet",
      "price": 45.00,
      "currency": "USD",
      "category": "Jewelry",
      "sizes": ["One Size"],
      "imageUrl": "https://images.pexels.com/photos/29579397/pexels-photo-29579397.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/elegant-shell-jewelry-on-woman-s-arm-29579397/",
      "description": "A stunning, nature-inspired bracelet featuring polished shell elements set in elegant metalwork.",
      "inStock": true
    },
    {
      "title": "Premium Gold Statement Jewelry",
      "price": 150.00,
      "currency": "USD",
      "category": "Jewelry",
      "sizes": ["One Size"],
      "imageUrl": "https://images.pexels.com/photos/29579372/pexels-photo-29579372.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/stylish-woman-showcasing-elegant-jewelry-29579372/",
      "description": "High-end, elegant statement jewelry designed to elevate both evening wear and sophisticated daily outfits.",
      "inStock": false
    },
    {
      "title": "Assorted Silver Drop Earrings",
      "price": 35.00,
      "currency": "USD",
      "category": "Jewelry",
      "sizes": ["One Size"],
      "imageUrl": "https://images.pexels.com/photos/7451619/pexels-photo-7451619.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/variety-of-silver-earrings-7451619/",
      "description": "A versatile collection of delicate silver earrings, ranging from simple hoops to intricate drop designs.",
      "inStock": true
    }
  ],
  'shoes': [
    {
      "title": "Trendy Streetwear Sneakers",
      "price": 85.00,
      "currency": "USD",
      "category": "Sneakers",
      "sizes": ["US 7", "US 8", "US 9", "US 10", "US 11"],
      "imageUrl": "https://images.pexels.com/photos/36463721/pexels-photo-36463721.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/trendy-sneakers-displayed-on-store-shelf-36463721/",
      "description": "Modern and trendy sneakers featuring a sleek design, perfect for everyday casual wear and streetwear styling.",
      "inStock": true
    },
    {
      "title": "Cute Pink Casual Trainers",
      "price": 60.00,
      "currency": "USD",
      "category": "Casual Footwear",
      "sizes": ["US 5", "US 6", "US 7", "US 8", "US 9"],
      "imageUrl": "https://images.pexels.com/photos/27180558/pexels-photo-27180558.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/cute-pink-shoes-27180558/",
      "description": "Adorable pink casual trainers that add a bright pop of color and all-day comfort to any playful outfit.",
      "inStock": true
    },
    {
      "title": "Classic Everyday Lace-Ups",
      "price": 75.00,
      "currency": "USD",
      "category": "Casual Footwear",
      "sizes": ["US 7", "US 8", "US 9", "US 10"],
      "imageUrl": "https://images.pexels.com/photos/24196271/pexels-photo-24196271.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/close-up-of-shoes-24196271/",
      "description": "Versatile lace-up shoes built with quality materials, blending durability with effortless everyday style.",
      "inStock": false
    },
    {
      "title": "Rugged Black Leather Boots",
      "price": 130.00,
      "currency": "USD",
      "category": "Boots",
      "sizes": ["US 8", "US 9", "US 10", "US 11", "US 12"],
      "imageUrl": "https://images.pexels.com/photos/389696/pexels-photo-389696.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/pair-of-black-boots-389696/",
      "description": "Heavy-duty black leather boots offering exceptional durability, secure lacing, and a bold, rugged aesthetic.",
      "inStock": true
    },
    {
      "title": "Chunky Sole Platform Loafers",
      "price": 95.00,
      "currency": "USD",
      "category": "Loafers",
      "sizes": ["US 6", "US 7", "US 8", "US 9", "US 10"],
      "imageUrl": "https://images.pexels.com/photos/17577101/pexels-photo-17577101.jpeg?auto=compress&cs=tinysrgb&w=800",
      "sourceUrl": "https://www.pexels.com/photo/loafers-with-thick-rubber-sole-17577101/",
      "description": "Contemporary loafers featuring a trendy thick rubber sole, providing elevated height and a strong modern appeal.",
      "inStock": true
    }
  ]
};

// Project configurations
const String projectId = 'velura-app-bf8e0';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: dart bin/import_products.dart [category_name | all]');
    print('Available categories: women, men, kids, accessories, shoes, all');
    exit(1);
  }

  final target = args[0].toLowerCase();
  if (target != 'all' && !catalog.containsKey(target)) {
    print('Error: Invalid category "$target"');
    print('Available categories: women, men, kids, accessories, shoes, all');
    exit(1);
  }

  final client = HttpClient();

  try {
    if (target == 'all') {
      print('=== Starting upload for ALL categories ===');
      for (final category in catalog.keys) {
        await uploadCategory(client, category);
      }
    } else {
      print('=== Starting upload for category: $target ===');
      await uploadCategory(client, target);
    }
    print('\n=== All Operations Completed Successfully ===');
  } catch (e) {
    print('Critical Error: $e');
  } finally {
    client.close();
  }
}

Future<void> uploadCategory(HttpClient client, String categoryKey) async {
  final products = catalog[categoryKey]!;
  // Map category key to the standard UI Category Name used in the App
  final String uiCategory;
  switch (categoryKey) {
    case 'women': uiCategory = 'Women'; break;
    case 'men': uiCategory = 'Men'; break;
    case 'kids': uiCategory = 'Kids'; break;
    case 'accessories': uiCategory = 'Accessories'; break;
    case 'shoes': uiCategory = 'Shoes'; break;
    default: uiCategory = categoryKey;
  }

  print('\n----------------------------------------');
  print('Uploading category "$uiCategory" (${products.length} products)...');
  print('----------------------------------------');

  int successCount = 0;
  int failureCount = 0;

  for (final prod in products) {
    final title = prod['title'] as String;
    final price = (prod['price'] as num).toDouble();
    final description = prod['description'] as String;
    final imageUrl = prod['imageUrl'] as String;
    final subcategory = prod['category'] as String;
    final sizes = List<String>.from(prod['sizes'] ?? ['One Size']);
    final inStock = prod['inStock'] as bool? ?? true;

    // Create a slug-like unique ID for the document to keep it clean and idempotent
    final docId = title.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');

    // Make oldPrice look premium by adding a discount markup
    final oldPrice = double.parse((price * 1.4).toStringAsFixed(2));
    
    // Give it a realistic luxury rating
    final rating = double.parse((4.5 + (title.hashCode % 5) * 0.1).toStringAsFixed(1));

    // Formulate the Firestore REST JSON object
    final Map<String, dynamic> firestoreDocument = {
      'fields': {
        'name': {'stringValue': title},
        'category': {'stringValue': uiCategory},
        'subcategory': {'stringValue': subcategory},
        'description': {'stringValue': description},
        'imageUrl': {'stringValue': imageUrl},
        'price': {'doubleValue': price},
        'oldPrice': {'doubleValue': oldPrice},
        'rating': {'doubleValue': rating},
        'sizes': {
          'arrayValue': {
            'values': sizes.map((s) => {'stringValue': s}).toList()
          }
        },
        'inStock': {'booleanValue': inStock}
      }
    };

    // Use PATCH to write/upsert the document idempotently
    final url = Uri.parse(
      'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/products/$docId'
    );

    try {
      final request = await client.patchUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(json.encode(firestoreDocument));

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        print('  [SUCCESS] "$title" uploaded to Firestore as ID: $docId');
        successCount++;
      } else {
        print('  [FAILED] "$title" failed with status ${response.statusCode}');
        print('  Response: $body');
        failureCount++;
      }
    } catch (e) {
      print('  [ERROR] Exception uploading "$title": $e');
      failureCount++;
    }
  }

  print('\nCategory "$uiCategory" Summary: $successCount Successes, $failureCount Failures');
}
