const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  name: {
    // required: true,
    type: String,
    trim: true,
  },
  email: {
    // required: true,
    type: String,
    trim: true,
  },
  password: {
    // required: true,
    type: String,
  },
  countEmail:{
    type: Number,
    default: 0, 
  },
  countReport:{
    type: Number,
    default: 0, 
  },
  countTranslate:{
    type: Number,
    default: 0, 
  },
  countHours:{
    type: Number,
    default: 0, 
  },
  company:{
    type: String,
    default:'Company'
  },
  bio:{
    type: String,
    default:'Your bio'
  },
  profilePicture:{
    type: String,
    default:'',
  }
});

const User = mongoose.model("User", userSchema);
module.exports = User;