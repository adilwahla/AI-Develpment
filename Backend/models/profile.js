// profileModel.js

const mongoose = require('mongoose');

const profileSchema = new mongoose.Schema({
  firstName: {
    type: String,
    required: true,
  },
  lastName: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  wordLimit: {
    type: Number,
    default: 500, // Example default word limit
  },
  currentWordCount: {
    type: Number,
    default: 0,
  },
});

const Profile = mongoose.model('Profile', profileSchema);

module.exports = {
  Profile,
};
