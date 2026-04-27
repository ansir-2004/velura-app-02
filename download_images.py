import urllib.request
import os

images = {
    'men': [
        ('m1.jpg', 'https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=400&h=500&fit=crop&auto=format'),
        ('m2.jpg', 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=400&h=500&fit=crop&auto=format'),
        ('m3.jpg', 'https://images.unsplash.com/photo-1552374196-1ab2a1c593e8?w=400&h=500&fit=crop&auto=format'),
        ('m4.jpg', 'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=400&h=500&fit=crop&auto=format'),
        ('m5.jpg', 'https://images.unsplash.com/photo-1617137984095-74e4e5e3613f?w=400&h=500&fit=crop&auto=format'),
    ],
    'women': [
        ('w1.jpg', 'https://images.unsplash.com/photo-1566174053879-31528523f8ae?w=400&h=500&fit=crop&auto=format'),
        ('w2.jpg', 'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=400&h=500&fit=crop&auto=format'),
        ('w3.jpg', 'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=400&h=500&fit=crop&auto=format'),
        ('w4.jpg', 'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=400&h=500&fit=crop&auto=format'),
        ('w5.jpg', 'https://images.unsplash.com/photo-1585487000160-6ebcfceb0d03?w=400&h=500&fit=crop&auto=format'),
    ],
    'kids': [
        ('k1.jpg', 'https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?w=400&h=500&fit=crop&auto=format'),
        ('k2.jpg', 'https://images.unsplash.com/photo-1518831959646-742c3a14ebf7?w=400&h=500&fit=crop&auto=format'),
        ('k3.jpg', 'https://images.unsplash.com/photo-1622290291468-a28f7a7dc6a8?w=400&h=500&fit=crop&auto=format'),
        ('k4.jpg', 'https://images.unsplash.com/photo-1471286174890-9c112ffca5b4?w=400&h=500&fit=crop&auto=format'),
    ],
    'accessories': [
        ('a1.jpg', 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=400&h=500&fit=crop&auto=format'),
        ('a2.jpg', 'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=400&h=500&fit=crop&auto=format'),
        ('a3.jpg', 'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=400&h=500&fit=crop&auto=format'),
    ],
    'shoes': [
        ('s1.jpg', 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=400&h=500&fit=crop&auto=format'),
        ('s2.jpg', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=500&fit=crop&auto=format'),
        ('s3.jpg', 'https://images.unsplash.com/photo-1515347619252-60a4bf4fff4f?w=400&h=500&fit=crop&auto=format'),
    ],
}

headers = {'User-Agent': 'Mozilla/5.0'}

for category, files in images.items():
    folder = f'assets/images/{category}'
    os.makedirs(folder, exist_ok=True)
    for filename, url in files:
        path = f'{folder}/{filename}'
        try:
            req = urllib.request.Request(url, headers=headers)
            with urllib.request.urlopen(req) as response:
                with open(path, 'wb') as f:
                    f.write(response.read())
            print(f'OK: {path}')
        except Exception as e:
            print(f'FAILED: {path} -> {e}')

print('All done!')
