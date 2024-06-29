from flask import Flask, jsonify
from pymongo import MongoClient

app = Flask(__name__)

# MongoDB URI
MONGO_URI = "mongodb+srv://ayush91003:Aryan123@crud1.s45kjss.mongodb.net/?retryWrites=true&w=majority&appName=crud1"

# Initialize MongoDB connection
client = MongoClient(MONGO_URI)
db = client['Diet']  # Connect to 'diet_items_db' database
foods_collection = db['foods']  # Create or access 'foods' collection

# Sample food items
food_items = [
    {
        'name': 'Apple',
        'calories': 52,
        'fats': 0.2,
        'proteins': 0.3,
        'iron': 0.1,
        'carbohydrates': 14,
        'sodium': 1,
        'calcium': 6,
        'fiber': 2.4,
        'vitamin_d': 0
    },
    {
        'name': 'Banana',
        'calories': 89,
        'fats': 0.3,
        'proteins': 1.1,
        'iron': 0.3,
        'carbohydrates': 23,
        'sodium': 1,
        'calcium': 5,
        'fiber': 2.6,
        'vitamin_d': 0
    },
    # Add more food items as needed
]

# Insert food items into the collection if the collection is empty
if foods_collection.count_documents({}) == 0:
    result = foods_collection.insert_many(food_items)
    print(f"Inserted food items with IDs: {result.inserted_ids}")

@app.route('/')
def index():
    return jsonify(message="Hello, World!")

@app.route('/test_db_connection')
def test_db_connection():
    try:
        db.command('ping')
        return jsonify(message="Connected to MongoDB"), 200
    except Exception as e:
        return jsonify(error=str(e)), 500

if __name__ == '__main__':
    app.run(debug=True)

