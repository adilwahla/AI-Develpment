// socialMediaModel.js

const mongoose = require('mongoose');

const socialMediaSchema = new mongoose.Schema({
  platform: {
    type: String,
    enum: ['facebook', 'twitter', 'insta', 'linkedin'],
    required: true,
  },
  contentInput: {
    contentIdeas: {
      type: String,
      required: true,
      default: "New blog post about AI technology"
    },
    captionsText: {
      type: String,
      default: "Exploring the latest advancements in AI"
    },
    responseGeneration: {
      type: String,
      default: "User's comment on AI post"
    },
  },
  contentCalendar: {
    timeframe: {
      type: String,
      required: true,
      default: "2023-01-01 to 2023-01-31"
    },
    frequency: {
      type: Number,
      required: true,
      default: 3
    },
    contentTypes: {
      type: [String],
      enum: ['blog articles', 'videos', 'infographics'],
      required: true,
      default: ["blog articles", "videos"]
    },
    goals: {
      type: [String],
      enum: ['brand awareness', 'lead generation', 'sales'],
      required: true,
      default: ["brand awareness", "lead generation"]
    },
  },
  generatedContent: {
    type: String,
    default: "Generated content for social media"
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const SocialMedia = mongoose.model('SocialMedia', socialMediaSchema);

module.exports = {
  SocialMedia,
};
