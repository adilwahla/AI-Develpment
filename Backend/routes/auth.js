const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");
const { Email, createEmail } = require('../models/email'); // Adjust the path as needed
const { translateText } = require('../models/translate'); // Adjust the path as needed
const { generateReport } = require('../models/report'); // Adjust the path as needed
const { SocialMedia }=require('../models/socialMedia');
const { Profile }=require('../models/profile');
// Sign Up
authRouter.post("/api/signup", async (req, res) => {

  try {
    console.log(req.body);
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }
        
    

   const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password : hashedPassword,
      name,
    });
    user = await user.save();
    // res.json(user);
    // return res
    //     .status(200)
    //     .json({ msg: "created" });
     // Send a response with the user data
     res.status(200).json({
        message: 'User created successfully',
        user});
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Sign In
authRouter.post("/api/signin", async (req, res) => {
    try {
      const { email, password } = req.body;
  
      const user = await User.findOne({ email });
      if (!user) {
        return res
          .status(400)
          .json({ msg: "User with this email does not exist!" });
      }
  
      const isMatch = await bcryptjs.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ msg: "Incorrect password." });
      }
  
      const token = jwt.sign({ id: user._id }, "passwordKey");
      res.json({ token, ...user._doc });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });



  authRouter.post("/tokenIsValid", async (req, res) => {
    try {
      const token = req.header("x-auth-token");
      if (!token) return res.json(false);
      const verified = jwt.verify(token, "passwordKey");
      if (!verified) return res.json(false);
  
      const user = await User.findById(verified.id);
      if (!user) return res.json(false);
      res.json(true);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  
  // get user data
  authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
  });


// API Endpoint to Create Email
authRouter.post('/api/email', async (req, res) => {
    try {
      const emailData = req.body;
      const savedEmail = await createEmail(emailData);
      res.status(201).json({
        message: 'Email created successfully',
        emailId: savedEmail._id,
        createdAt: savedEmail.createdAt,
      });
    } catch (error) {
      console.error('Error creating email:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

// API Endpoint to Translate Text
authRouter.post('/api/translate', async (req, res) => {
    try {
      const { inputText, targetLanguage } = req.body;
      const translatedText = await translateText(inputText, targetLanguage);
      res.status(200).json({
        message: 'Translated Text Generated',
        translatedText,
      });
    } catch (error) {
      console.error('Error translating text:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

// API Endpoint to Generate Report
authRouter.post('/api/report', async (req, res) => {
    try {
      const { inputText, length, language } = req.body;
      const reportResponse = await generateReport(inputText, length, language);
      res.status(200).json(reportResponse);
    } catch (error) {
      console.error('Error generating report:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });



////////////////////////////////

// API Endpoint to Create Social Media Content Idea
// API Endpoint to Create Social Media Content
authRouter.post('/api/social-media/content/:platform', async (req, res) => {
    try {
      const { platform } = req.params;
      const { contentIdeas, captionsText, responseGeneration } = req.body;
      const socialMedia = new SocialMedia({ platform, contentInput: { contentIdeas, captionsText, responseGeneration } });
      await socialMedia.save();
      res.status(201).json({
        message: 'Social Media Content created successfully',
        socialMediaId: socialMedia._id,
      });
    } catch (error) {
      console.error('Error creating social media content:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  
  // API Endpoint to Create Content Calendar
  authRouter.post('/api/social-media/content-calendar/:platform', async (req, res) => {
    try {
      const { platform } = req.params;
      const { timeframe, frequency, contentTypes, goals } = req.body;
      const socialMedia = new SocialMedia({ platform, contentCalendar: { timeframe, frequency, contentTypes, goals } });
      await socialMedia.save();
      res.status(201).json({
        message: 'Content Calendar created successfully',
        socialMediaId: socialMedia._id,
      });
      }  catch (error) {
      console.error('Error creating content calendar:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  
  // API Endpoint to Generate Content
  authRouter.post('/api/social-media/generate-content/:id', async (req, res) => {
    try {
      const { id } = req.params;
      const socialMedia = await SocialMedia.findById(id);
      if (!socialMedia) {
        return res.status(404).json({ error: 'Social Media Content not found' });
      }
  
      // Placeholder logic for generating content based on the provided inputs
      const generatedContent = `Generated content for ${socialMedia.platform}:\n\nContent Ideas: ${socialMedia.contentInput.contentIdeas}\nCaptions & Text: ${socialMedia.contentInput.captionsText}\nResponse Generation: ${socialMedia.contentInput.responseGeneration}`;
  
      socialMedia.generatedContent = generatedContent;
      await socialMedia.save();
  
      res.status(200).json({
        message: 'Content generated successfully',
        generatedContent: socialMedia.generatedContent,
      });
    } catch (error) {
      console.error('Error generating content:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  
///////////////////////////////////////

// API Endpoint to Get User Profile
authRouter.get('/api/profile/:userId', async (req, res) => {
    try {
      const { userId } = req.params;
      const userProfile = await Profile.findById(userId);
      if (!userProfile) {
        return res.status(404).json({ error: 'User profile not found' });
      }
      res.status(200).json(userProfile);
    } catch (error) {
      console.error('Error fetching user profile:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  
  // API Endpoint to Update User Profile
  authRouter.put('/api/profile/:userId', async (req, res) => {
    try {
      const { userId } = req.params;
      const { password, wordLimit } = req.body;
  
      // Simulate password hashing (replace this with proper password hashing in production)
      const hashedPassword = password; // In a real application, use bcrypt or similar
  
      const updatedProfile = await Profile.findByIdAndUpdate(
        userId,
        { password: hashedPassword, wordLimit },
        { new: true }
      );
  
      if (!updatedProfile) {
        return res.status(404).json({ error: 'User profile not found' });
      }
  
      res.status(200).json({
        message: 'User profile updated successfully',
        updatedProfile,
      });
    } catch (error) {
      console.error('Error updating user profile:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

module.exports = authRouter;