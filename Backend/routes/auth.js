const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const {auth ,generateTokenAndSetCookie,TranslateWordCount,ReportsCount} = require("../middleware/auth");

const { translateText } = require('../models/translate'); // Adjust the path as needed
const { generateReport } = require('../models/report'); // Adjust the path as needed
const CompanyDetails = require('../models/company');
const ContentCalendar =require('../models/contentCalender');
const mongoose = require('mongoose');
require('dotenv').config();
const apiKey = process.env.OPENAI_API;
const OpenAI = require("openai");

const openai = new OpenAI({apiKey});

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
      console.log("user  ",user);
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
  authRouter.get("/api/user", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
  });
// Route to update user profile
authRouter.put('/api/updateProfile', auth, async (req, res) => {
  try {
    const { fullName, newEmail, companyName, tagLine, profilePicture } = req.body;
    const userId = req.user; // Assuming req.user contains the ObjectId of the user

    // Prepare the update object based on the provided fields
    const updateFields = {};
    if (fullName) updateFields.name = fullName;
    if (newEmail) updateFields.email = newEmail;
    if (companyName) updateFields.company = companyName;
    if (tagLine) updateFields.bio = tagLine;
    if (profilePicture) updateFields.profilePicture = profilePicture;

    // Find the user by userId and update the fields
    const updatedUser = await User.findByIdAndUpdate(
      userId,
      { $set: updateFields }, // Use $set to update the specific fields
      { new: true } // Return the updated document
    );

    if (!updatedUser) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.status(200).json({ message: 'Profile updated successfully', user: updatedUser });
  } catch (error) {
    console.error('Error updating profile:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

///////
authRouter.put('/api/updatePassword', auth, async (req, res) => {
  try {
    const {  newPassword } = req.body;
    const userId = req.user; // Assuming req.user contains the ObjectId of the user

    // Check if the current password matches the stored hashed password (you need to have the hashed password in your user document)
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

 
    // Hash the new password before updating
    const hashedPassword = await bcryptjs.hash(newPassword, 8);

    // Update the user's password
    user.password = hashedPassword;
    await user.save();

    res.status(200).json({ message: 'Password updated successfully' });
  } catch (error) {
    console.error('Error updating password:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});
//////


const auth1 = async (req, res, next) => {
  console.log("before 1 ");
  try {
    console.log("before ");
    const token = req.header("x-auth-token");
    console.log("After ",JSON.stringify(req.header) );
    console.log("After ",req.headers );

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
////////////////
// Initialize a counter to keep track of the total words generated by the GPT API


// Function to increment the counter by the number of words generated
// Modified incrementWordCount function
async function incrementWordCount(userId, content) {
  let totalWordsGenerated = 0;
  const words = content.split(/\s+/).filter(word => word !== '');
  totalWordsGenerated += words.length;

  
    try {
      // Find user by ID and update countEmail field
      const updatedUser = await User.findByIdAndUpdate(
        userId, // User ID
        { $inc: { countEmail: totalWordsGenerated } }, // Increment countEmail by 1
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
  
async function incrementHoursCount(userId){
  try{
 
      // Find the user by ID to get the current values of countEmail, countReport, and countTranslate
      const user = await User.findById(userId);
  
      if (!user) {
        console.log("User not found");
        return;
      }
  
      // Get the current values
      const { countEmail, countReport, countTranslate } = user;
  
      // Update the user with the new countHours value
      const updatedUser = await User.findByIdAndUpdate(
        userId,
        {
          $set: {
            countHours: calculateTotalHours(countEmail, countReport, countTranslate),
          },
        },
        { new: true }
      );
  
      console.log("Updated user:", updatedUser);
  }catch(e){
    console.log("error in hours increment function",e.message);
  }

  function calculateTotalHours(countEmail, countReport, countTranslate) {
    // Adjust the formula based on your requirements
    const e = 1.5; // Average time for an email in seconds/word
    const r = 3;   // Average time for a report/summary in seconds/word
    const t = 12;  // Average time for translation in seconds/word
  
    const totalSecondsSaved  =
      (countEmail * e - countEmail * 0.08) +
      (countReport * r - countReport * 0.08) +
      (countTranslate * t - countTranslate * 0.08);
  
      const totalHoursSaved = Math.round(totalSecondsSaved / 3600);// Convert to hours
     console.log("totalHoursSaved",totalHoursSaved)
      return totalHoursSaved;
    }
}

// Helper function to calculate total hours based on your formula

authRouter.post('/api/email' ,auth1, async (req, res) => {
  let generatedEmail="";
  try {
   //TODO: get current user id here without getting it from user req.body 
    const emailData = req.body;
    console.log(req.body);
    console.log('this is req.user',req.user);
    let companyDetails =await  checkCompanyExists(req.user);
    // Use the companyDetails variable for further actions if needed
if (companyDetails) {
  // Perform actions using companyDetails
  // console.log('Do something with companyDetails:', companyDetails);
  generatedEmail = await generateEmailContent(emailData ,companyDetails);
} else {
  // Perform actions if the company does not exist or if there's an error
  console.log('Company not found or an error occurred.');
  generatedEmail = await generateEmailContent(emailData ,companyDetails = null);
}
    
    // console.log('Received email data:', JSON.stringify(emailData, null, 2));
   
    console.log('Generated email content:', generatedEmail);
    await incrementWordCount(req.user, generatedEmail); 
    incrementHoursCount(req.user);

    res.status(200).json({
      message: 'Email created successfully',
      generatedEmail: generatedEmail, 

    });

  } catch (error) {
    console.error('Error creating email:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});
///////////////
async function checkCompanyExists(userId) {
  try {
    // Find the user by ID
    const user = await User.findById(userId);

    // Check if the user exists and has the 'company' field
    if (user && user.company) {
      const companyName = user.company;

      // Check if the company exists in the CompanyDetails collection
      let companyDetails = await CompanyDetails.findOne({ companyName });

      if (companyDetails) {
        console.log(`Company with name '${companyName}' exists. Details:`, companyDetails);
        return companyDetails;
      } else {
        console.log(`Company with name '${companyName}' does not exist.`);
        return null;
      }
    } else {
      console.log('User or company information not available.');
      return null;
    }
  } catch (error) {
    console.error('Error:', error.message);
    return null;
  }
}

///////////////
// async function generateEmailContentWithRetry(emailData, retryCount = 3) {
//   try {
//     const generatedEmail = await generateEmailContent(emailData);
//     return generatedEmail;
//   } catch (error) {
//     if (error.response && error.response.status === 429 && retryCount > 0) {
//       const delay = Math.pow(2, 3 - retryCount) * 1000; // 2^maxRetries * 1000 milliseconds
//       console.log(`Retrying after ${delay} milliseconds...`);
//       await new Promise(resolve => setTimeout(resolve, delay));
//       return generateEmailContentWithRetry(emailData, retryCount - 1);
//     } else {
//       throw error;
//     }
//   }
// }

async function generateEmailContent(emailData ,companyDetails) {
  let content = `Write an email with the following details:
    Object: ${emailData.object}
    Type of Email: ${emailData.typeOfEmail}
    Email To: ${emailData.emailTo}
    Email From: ${emailData.emailFrom}
    Length: ${emailData.length}
    Email Content: ${emailData.emailContent}
    Company Details: ${companyDetails ? JSON.stringify(companyDetails) : 'N/A'}`;
   
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
authRouter.post('/api/translate',auth1, async (req, res) => {
    try {
      console.log(req.body);
       console.log('this is req.user',req.user);
      const { documentText,inputText, targetLanguage } = req.body;
      const translatedText = await translateTextFromChatGPT(documentText,inputText, targetLanguage);
      console.log('this is translated text',typeof  translatedText);
      await TranslateWordCount(req.user, translatedText);
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
authRouter.post('/api/report',auth1, async (req, res) => {
    try {
      const { inputText, length, language } = req.body;
      console.log(req.body);
      const reportResponse = await generateReportWithChatGPT1(inputText, length, language);
      console.log("$reportResponse"+ reportResponse);
     await ReportsCount(req.user);
      res.status(200).json({  message: 'Translated Text Generated',
      reportResponse}
      );
    } catch (error) {
      console.error('Error generating report:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
async function generateReportWithChatGPT1(inputText, length, language){
   // const prompt = `Summarize: ${text} in ${language}`;
   const prompt = `Provide a Report/summary of the main points in: ${inputText} with length of ${length} in ${language}. Additionally, highlight or reference these main points with a corresponding table of contents.`;
    const completion = await openai.chat.completions.create({
      messages: [
        {"role": "user", "content": prompt}
    ],
      model: "gpt-3.5-turbo",
     
  
    });
    // console.log(completion.choices[0].message.content);
      return completion.choices[0].message.content;
}
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
authRouter.post('/api/socialMedia',auth1, async (req, res) => {
  let prompt='';
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
 /////===========>
let CompanyCalenderdata= await checkCompanyCalenderExists(req.user);
// console.log(foundData);

try {
  if(checkCompanyCalenderExists){
    prompt = `Create Social media content calender  for ${selectedPlatform} with ideas: ${contentIdeas}, captions: ${captionsText} and based on ${responseGeneration}, timeframe: ${timeframe}, frequency: ${frequency}, types: ${type}, themes: ${themes} , Companydata:${CompanyCalenderdata}`;
  }else{
    prompt = `Create Social media content calender  for ${selectedPlatform} with ideas: ${contentIdeas}, captions: ${captionsText} and based on ${responseGeneration}, timeframe: ${timeframe}, frequency: ${frequency}, types: ${type}, themes: ${themes} `; 
  }


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

/////////////// This is API to store data in DB to generate Email
authRouter.post('/api/emailData', async (req, res) => {
  try {
    const companyData = req.body;

    const newCompanyData = new CompanyDetails(companyData);

    const savedCompanyData = await newCompanyData.save();
    res.status(201).json({ message: 'Successfully saved data', savedData: savedCompanyData });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

///////// API END POINT FOR CONTENT CALENDER 
// API endpoint to store content calendar data
authRouter.post('/api/contentCalendar', async (req, res) => {
  try {
    const contentCalendarData = req.body;

    const newContentCalendar = new ContentCalendar(contentCalendarData);

    const savedContentCalendar = await newContentCalendar.save();
    res.status(201).json({ message: 'Successfully saved content calendar data', savedData: savedContentCalendar });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//////////////

async function checkCompanyCalenderExists(userId) {
  try {
    // Find the user by ID
    const user = await User.findById(userId);

    // Check if the user exists and has the 'company' field
    if (user && user.company) {
      const companyName = user.company;

      // Check if the company exists in the CompanyDetails collection
      let contentCalendarData = await ContentCalendar.findOne({ 'companyOverview.companyName': companyName });

      if (contentCalendarData) {
        console.log(`Company with name '${companyName}' exists. Details:`, contentCalendarData);
        return contentCalendarData;
      } else {
        console.log(`Company with name '${companyName}' does not exist.`);
        return null;
      }
    } else {
      console.log('User or company information not available.');
      return null;
    }
  } catch (error) {
    console.error('Error:', error.message);
    return null;
  }
}

// API Endpoint to Create Social Media Content Idea
// API Endpoint to Create Social Media Content
// authRouter.post('/api/social-media/content/:platform', async (req, res) => {
//     try {
//       const { platform } = req.params;
//       const { contentIdeas, captionsText, responseGeneration } = req.body;
//       const socialMedia = new SocialMedia({ platform, contentInput: { contentIdeas, captionsText, responseGeneration } });
//       await socialMedia.save();
//       res.status(201).json({
//         message: 'Social Media Content created successfully',
//         socialMediaId: socialMedia._id,
//       });
//     } catch (error) {
//       console.error('Error creating social media content:', error);
//       res.status(500).json({ error: 'Internal server error' });
//     }
//   });
  
//   // API Endpoint to Create Content Calendar
//   authRouter.post('/api/social-media/content-calendar/:platform', async (req, res) => {
//     try {
//       const { platform } = req.params;
//       const { timeframe, frequency, contentTypes, goals } = req.body;
//       const socialMedia = new SocialMedia({ platform, contentCalendar: { timeframe, frequency, contentTypes, goals } });
//       await socialMedia.save();
//       res.status(201).json({
//         message: 'Content Calendar created successfully',
//         socialMediaId: socialMedia._id,
//       });
//       }  catch (error) {
//       console.error('Error creating content calendar:', error);
//       res.status(500).json({ error: 'Internal server error' });
//     }
//   });
  
  // API Endpoint to Generate Content
  // authRouter.post('/api/social-media/generate-content/:id', async (req, res) => {
  //   try {
  //     const { id } = req.params;
  //     const socialMedia = await SocialMedia.findById(id);
  //     if (!socialMedia) {
  //       return res.status(404).json({ error: 'Social Media Content not found' });
  //     }
  
  //     // Placeholder logic for generating content based on the provided inputs
  //     const generatedContent = `Generated content for ${socialMedia.platform}:\n\nContent Ideas: ${socialMedia.contentInput.contentIdeas}\nCaptions & Text: ${socialMedia.contentInput.captionsText}\nResponse Generation: ${socialMedia.contentInput.responseGeneration}`;
  
  //     socialMedia.generatedContent = generatedContent;
  //     await socialMedia.save();
  
  //     res.status(200).json({
  //       message: 'Content generated successfully',
  //       generatedContent: socialMedia.generatedContent,
  //     });
  //   } catch (error) {
  //     console.error('Error generating content:', error);
  //     res.status(500).json({ error: 'Internal server error' });
  //   }
  // });
  
///////////////////////////////////////


module.exports = authRouter;