from flask import Flask, jsonify, request
from pymongo import MongoClient
from bson.objectid import ObjectId

app = Flask(__name__)

# MongoDB configuration
MONGO_URI = "mongodb+srv://ayush91003:Aryan123@crud1.s45kjss.mongodb.net/?retryWrites=true&w=majority"
client = MongoClient(MONGO_URI)
db = client['Diet']  # Replace with your actual database name

# Define your UserPreferences model (example)
class UserPreferences:
    def __init__(self, protein, veg, calories, carbohydrates, goal, allergies):
        self.protein = protein
        self.veg = veg
        self.calories = calories
        self.carbohydrates = carbohydrates
        self.goal = goal
        self.allergies = allergies

    def to_dict(self):
        return {
            'protein': self.protein,
            'veg': self.veg,
            'calories': self.calories,
            'carbohydrates': self.carbohydrates,
            'goal': self.goal,
            'allergies': self.allergies
        }

# Example route for creating user preferences

# Create a new user preferences detail
@app.route('/api/user-preferences', methods=['POST'])
def add_user_preferences():
    data = request.json
    protein = data.get('protein')
    veg = data.get('veg')
    calories = data.get('calories')
    carbohydrates = data.get('carbohydrates')
    goal = data.get('goal')
    allergies = data.get('allergies')

    if protein is not None and veg is not None and calories is not None and carbohydrates is not None and goal and allergies:
        new_preferences = UserPreferences(protein=protein, veg=veg, calories=calories, carbohydrates=carbohydrates, goal=goal, allergies=allergies)
        db.user_preferences.insert_one(new_preferences.to_dict())
        return jsonify(message='User preferences added successfully'), 201
    else:
        return jsonify(message='Missing required fields'), 400

# Get all user preferences
@app.route('/api/user-preferences', methods=['GET'])
def get_all_user_preferences():
    preferences = list(db.user_preferences.find({}))
    for preference in preferences:
        preference['_id'] = str(preference['_id'])
    return jsonify(preferences), 200

# Get a single user preference by ID
@app.route('/api/user-preferences/<string:preference_id>', methods=['GET'])
def get_user_preference(preference_id):
    try:
        preference = db.user_preferences.find_one({'_id': ObjectId(preference_id)})
        if preference:
            preference['_id'] = str(preference['_id'])
            return jsonify(preference), 200
        else:
            return jsonify(message='User preference not found'), 404
    except Exception as e:
        return jsonify(message=f'An error occurred: {str(e)}'), 500

# Update a user preference by ID
@app.route('/api/user-preferences/<string:preference_id>', methods=['PUT'])
def update_user_preference(preference_id):
    data = request.json
    protein = data.get('protein')
    veg = data.get('veg')
    calories = data.get('calories')
    carbohydrates = data.get('carbohydrates')
    goal = data.get('goal')
    allergies = data.get('allergies')

    updated_data = {}
    if protein is not None:
        updated_data['protein'] = protein
    if veg is not None:
        updated_data['veg'] = veg
    if calories is not None:
        updated_data['calories'] = calories
    if carbohydrates is not None:
        updated_data['carbohydrates'] = carbohydrates
    if goal:
        updated_data['goal'] = goal
    if allergies:
        updated_data['allergies'] = allergies

    result = db.user_preferences.update_one({'_id': ObjectId(preference_id)}, {'$set': updated_data})

    if result.modified_count > 0:
        return jsonify(message='User preference updated successfully'), 200
    else:
        return jsonify(message='User preference not found'), 404

# Delete a user preference by ID
@app.route('/api/user-preferences/<string:preference_id>', methods=['DELETE'])
def delete_user_preference(preference_id):
    result = db.user_preferences.delete_one({'_id': ObjectId(preference_id)})

    if result.deleted_count > 0:
        return jsonify(message='User preference deleted successfully'), 200
    else:
        return jsonify(message='User preference not found'), 404

if __name__ == '__main__':
    app.run(debug=True,port=5002)
