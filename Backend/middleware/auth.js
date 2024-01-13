const jwt = require("jsonwebtoken");
const User = require("../models/user");


const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({ msg: "No auth token, access denied" });

    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorization denied." });

    req.user = verified.id;
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};






const generateTokenAndSetCookie =(userId, res)=>{
  const token =jwt.sign({ userId}, process.env.JWT_SECRET,{
      expiresIn: '15d',
  })
   res.cookie("jwt", token, {
      httpOnly: true, // more secure
      maxAge: 15 * 24 * 60*60 * 1000, //15 days
      sameSite: "strict", // CSRF
   })
   return token;
  }
  


   const TranslateWordCount = async (userId, translatedText)=>{
    const words = translatedText.split(/\s+/).filter(word => word !== '');
    const wordCount = words.length;
  
    try {
      // Find user by ID and update countTranslate field
      const updatedUser = await User.findByIdAndUpdate(
        userId,
        { $inc: { countTranslate: wordCount } }, // Increment countTranslate by the wordCount
        { new: true } // Return the updated user document
      );
  
      if (!updatedUser) {
        console.log("User not found");
        return;
      }
  
      console.log("Updated user:", updatedUser);
    } catch (error) {
      console.error("Error updating user:", error);
    }
  }
  
  const ReportsCount = async (userId)=>{
  
  
    try {
      // Find user by ID and update countTranslate field
      const updatedUser = await User.findByIdAndUpdate(
        userId,
        { $inc: { countReport: 1 } }, // Increment 1 by the wordCount
        { new: true } // Return the updated user document
      );
  
      if (!updatedUser) {
        console.log("User not found");
        return;
      }
  
      console.log("Updated user:", updatedUser);
    } catch (error) {
      console.error("Error updating user:", error);
    }
  }
  
  module.exports = {
    auth,
    generateTokenAndSetCookie,
    TranslateWordCount,
    ReportsCount
  };