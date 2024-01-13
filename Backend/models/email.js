const mongoose = require('mongoose');

// Define Mongoose schema
const emailSchema = new mongoose.Schema({
  object: {
    type: String,
    required: true,
  },
  typeOfEmail: {
    type: String,
    // enum: ['Inside Email', 'Close Partner Email', 'Normal Partner Email', 'Unknown Partner Email'],
    required: true,
  },
  emailTo: {
    type: String,
    required: true,
  },
  emailFrom: {
    type: String,
    required: true,
  },
  length: {
    type: String,
    // enum: ['Short', 'Medium', 'Long'],
    required: true,
  },
  emailContent: {
    type: String,
    required: true,
  },
 emailsGeneratedCount: {
      type: Number,
      default: 0,  // Default value is set to 0
    },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

// Create Mongoose model
const Email = mongoose.model('Email', emailSchema);

// Function to create a new email
// async function createEmail(emailData) {
//   try {
//     const newEmail = new Email(emailData);
//     const savedEmail = await newEmail.save();
//     return savedEmail;
//   } catch (error) {
//     throw error;
//   }
// }

module.exports = {
  Email,
  // createEmail,
};
