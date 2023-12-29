// profileModel.js
const {User} = require("../models/user");
const mongoose = require('mongoose');

const profileSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User', // This should match the name of the User model
    required: true
  },
  companyName:{
    type: String,
    default: "Google ",
  },
  tagLine:{
    type: String,
    default:"Add Bio here",
  },
  wordLimit: {
    type: Number,
    default: 6000, // Example default word limit
  },
  currentWordCount: {
    type: Number,
    default: 1500,
  },
});

// Static method to create a profile for a user
profileSchema.statics.createProfileForUser = async function(userId, companyName, tagLine, wordLimit, currentWordCount) {
  try {
    const newProfile = new this({
      user: userId,
      companyName: companyName || "Google",
      tagLine: tagLine || "Add Bio here",
      wordLimit: wordLimit || 6000,
      currentWordCount: currentWordCount || 1500,
    });
    
    const savedProfile = await newProfile.save();
    return savedProfile;
  } catch (error) {
    throw new Error(`Error creating profile: ${error.message}`);
  }
};

const Profile = mongoose.model('Profile', profileSchema);

module.exports = {
  Profile,
};
