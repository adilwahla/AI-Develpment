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
const mongoose = require('mongoose');


const OpenAI = require("openai");

const openai = new OpenAI({apiKey:process.env.OPENAI_API_KEY});
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
// Route to update user profile
authRouter.put('/updateProfile', async (req, res) => {
  try {
    const { id, fullName, newEmail, companyName, tagLine } = req.body;
    const userId = new  mongoose.Types.ObjectId(id); // Replace with the actual ObjectId of the user


    // Ensure 'id' is provided
    if (!id) {
      return res.status(400).json({ error: 'User ID is required.' });
    }

    // Update user's email and name if provided
    if (newEmail || fullName) {
      const updateFields = {};
      console.log("New Email:", newEmail); // Debugging line
      if (newEmail) updateFields.email = newEmail;
      if (fullName) updateFields.name = fullName;
      await User.findByIdAndUpdate(id, updateFields);
    }

    // Find the profile by user ID
    let profile = await Profile.findOne({ user: id });

   // If profile doesn't exist, create a new one
   if (!profile) {
    profile = await Profile.createProfileForUser(userId); // Use the static method to create a profile
  }

    // Update the profile fields if provided
    if (companyName) {
      profile.companyName = companyName;
    }
    if (tagLine) {
      profile.tagLine = tagLine;
    }

    // Save the profile (either the existing one or the new one)
    await profile.save();

    // Send a success response
    res.status(200).json({ message: 'Profile updated successfully.' });

  } catch (error) {
    console.error('Error updating profile:', error);
    res.status(500).json({ error: 'Internal Server Error.' });
  }
});

////////////////
authRouter.post('/api/email', async (req, res) => {
  try {
    const emailData = req.body;
    console.log(req.body);
   
    
    console.log('Received email data:', JSON.stringify(emailData, null, 2));
    const generatedEmail = await generateEmailContentWithRetry(emailData);
    console.log('Generated email content:', generatedEmail);
    
    res.status(200).json({
      message: 'Email created successfully',
      generatedEmail: generatedEmail, 
    });

  } catch (error) {
    console.error('Error creating email:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

async function generateEmailContentWithRetry(emailData, retryCount = 3) {
  try {
    const generatedEmail = await generateEmailContent(emailData);
    return generatedEmail;
  } catch (error) {
    if (error.response && error.response.status === 429 && retryCount > 0) {
      const delay = Math.pow(2, 3 - retryCount) * 1000; // 2^maxRetries * 1000 milliseconds
      console.log(`Retrying after ${delay} milliseconds...`);
      await new Promise(resolve => setTimeout(resolve, delay));
      return generateEmailContentWithRetry(emailData, retryCount - 1);
    } else {
      throw error;
    }
  }
}

async function generateEmailContent(emailData) {
  const content = `Write an email with the following details:
    Object: ${emailData.object}
    Type of Email: ${emailData.typeOfEmail}
    Email To: ${emailData.emailTo}
    Email From: ${emailData.emailFrom}
    Length: ${emailData.length}
    Email Content: ${emailData.emailContent}`;
// const content='You are a helpful assistant';
  try {
    const completion = await openai.chat.completions.create({
      messages: [
        {"role": "user", "content": content},
      ],
      model: "gpt-3.5-turbo",
    });

    console.log(completion.choices[0].message.content);
    return completion.choices[0].message.content;
  } catch (error) {
    throw error;
  }
}

// API Endpoint to Translate Text
authRouter.post('/api/translate', async (req, res) => {
    try {
      console.log(req.body);
      const { documentText,inputText, targetLanguage } = req.body;
      const translatedText = await translateTextFromChatGPT(documentText,inputText, targetLanguage);
      res.status(200).json({
        message: 'Translated Text Generated',
        translatedText,
      });
    } catch (error) {
      console.error('Error translating text:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  async function translateTextFromChatGPT(documentText,inputText, targetLanguage) {
    const content = `Translate the following text:  :${documentText} ${inputText} to targetLanguage ${targetLanguage}` ;
    try {
      const completion = await openai.chat.completions.create({
        messages: [
          {"role": "user", "content": content},
        ],
        model: "gpt-3.5-turbo",
      });
  
      console.log(completion.choices[0].message.content);
      return completion.choices[0].message.content;
    } catch (error) {
      throw error;
    }
  }
// API Endpoint to Generate Report
authRouter.post('/api/report', async (req, res) => {
    try {
      const { inputText, length, language } = req.body;
      console.log(req.body);
      const reportResponse = await generateReportWithChatGPT(inputText, length, language);
      console.log("$reportResponse"+ reportResponse);
      res.status(200).json({  message: 'Translated Text Generated',
      reportResponse}
      );
    } catch (error) {
      console.error('Error generating report:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

  async function generateReportWithChatGPT(inputText, length, language) {
    let maxTokens;

    // Determine max tokens based on the selected length
    switch (length) {
        case '200 words':
            maxTokens = 200;
            break;
        case 'half page':
            maxTokens = 1000; // Approximate token count for half a page
            break;
        case 'one page':
            maxTokens = 1500; // Approximate token count for a full page
            break;
        case 'two pages':
            maxTokens = 2000; // Approximate token count for two pages
            break;
        default:
          throw new Error('Exceeded token Limit');
    }

    const maxChunkSize = 6096; // Max token limit for GPT-3.5

    // Step 1: Split the document into chunks
    const chunks = [];
    for (let i = 0; i < inputText.length; i += maxChunkSize) {
        chunks.push(inputText.substring(i, i + maxChunkSize));
    }

    // Step 2: Generate summaries for each chunk
    const summaries = [];
    for (let chunk of chunks) {
        const summary = await generateSummary(chunk, maxTokens, language);
        summaries.push(summary);
    }

    // Step 3: Combine the summaries to create a final summary
    const finalSummary = combineSummaries(summaries);

    return finalSummary;
}

async function generateSummary(text, maxTokens, language) {
   // const prompt = `Summarize: ${text} in ${language}`;
   const prompt = `Provide a summary of the main points in: ${text} in ${language}. Additionally, highlight or reference these main points with a corresponding table of contents.`;
    const completion = await openai.chat.completions.create({
      messages: [
        {"role": "user", "content": prompt}
    ],
      model: "gpt-3.5-turbo",
      max_tokens: maxTokens,
  
    });
    // console.log(completion.choices[0].message.content);
      return completion.choices[0].message.content;
}

function combineSummaries(summaries) {
    // Join the summaries to create a combined summary.
    return summaries.join('\n');
}

////////////////////////////////
authRouter.post('/api/socialMedia', async (req, res) => {
  const {
    selectedPlatform,
    contentIdeas,
    captionsText,
    responseGeneration,
    timeframe,
    frequency,
    type,  // Changed from 'types' to 'type' to match the prompt.
    themes
  } = req.body;
console.log(req.body);
  try {
    const prompt = `Create content (without emojis or special characters) for ${selectedPlatform} with ideas: ${contentIdeas}, captions: ${captionsText} and based on ${responseGeneration}, timeframe: ${timeframe}, frequency: ${frequency}, types: ${type}, themes: ${themes}.`;

    const completion = await openai.chat.completions.create({
      messages: [
        { "role": "user", "content": prompt }
      ],
      model: "gpt-3.5-turbo"
    });

    const result = completion.choices[0].message.content;
    console.log(result);
    res.status(200).json({
      message: 'Social Media text Generated',
      result: result
    });

  } catch (error) {
    console.error('Error generating Social Media text:', error);
    res.status(500).json({
      error: 'Internal server error'
    });
  }
});



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