// reportModel.js

const mongoose = require('mongoose');

const reportSchema = new mongoose.Schema({
  inputText: {
    type: String,
    required: true,
  },
  length: {
    type: String,
    // enum: ['200 words', 'half page', 'one page', 'two pages'],
    required: true,
  },
  language: {
    type: String,
    required: true,
  },
  // summary: {
  //   type: String,
  //   required: true,
  // },
  // tableOfContents: {
  //   type: String,
  // },
  // createdAt: {
  //   type: Date,
  //   default: Date.now,
  // },
});

const Report = mongoose.model('Report', reportSchema);

// async function generateReport(inputText, length, language) {
//   try {
//     // Placeholder logic for generating summary and table of contents
//     const dummySummary = `This is a dummy summary for the provided input text with a length of ${length} in ${language}.`;
//     const dummyTableOfContents = '1. Introduction\n2. Main Points\n3. Conclusion';

//     const newReport = new Report({
//       inputText,
//       length,
//       language,
//       // summary: dummySummary,
//       // tableOfContents: dummyTableOfContents,
//     });

//     const savedReport = await newReport.save();
//     return {
//       message: 'Report Generated',
//       reportId: savedReport._id,
//     };
//   } catch (error) {
//     throw error;
//   }
// }

module.exports = {
  Report,
  // generateReport,
};
