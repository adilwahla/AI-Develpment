const User = require("../models/userModel");
const bcrypt = require("bcryptjs");
const { default: mongoose } = require("mongoose");

const signupUser = async (req, res) => {
    try {
      const { name, email, username, password } = req.body;
      console.log(name, email, username, password);
      const user = await User.findOne({ $or: [{ email }, { username }] });
      if (user) {
        return res.status(400).json({ message: "user already exists" });
      }
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(password, salt);
      const newUser = new User({
        name,
        email,
        username,
        password: hashedPassword,
      });
      await newUser.save();

    } catch (error) {
      res.status(500).json({ error: error.message });
      console.log("Error in signupUser:", error.message);
    }
  };



  module.exports = {
    signupUser,
    // loginUser,
    // logoutUser,
    // followUnFollowUser,
    // updateUser,
    // getUserProfile,
  };