// ContentCalendarSchema.js

const mongoose = require('mongoose');

const contentCalendarSchema = new mongoose.Schema({
  companyOverview: {
    companyName: { type: String, required: true },
    logo: { type: String },
    brandingGuidelines: { type: String },
    missionStatement: { type: String },
    coreValues: { type: String },
    briefHistory: { type: String },
  },

  targetAudience: {
    demographics: { type: String },
    psychographics: { type: String },
    buyerPersonas: { type: String },
  },

  contentStrategy: {
    existingContentStrategy: { type: String },
    preferredContentTypes: { type: String },
    toneAndStyleGuidelines: { type: String },
  },

  keyMessages: {
    coreMessages: { type: String },
    uniqueSellingPoints: { type: String },
  },

  marketingCalendar: {
    upcomingLaunches: { type: String },
    seasonalTrends: { type: String },
  },

  competitorAnalysis: {
    contentStrategy: { type: String },
    contentGaps: { type: String },
  },

  resources: {
    teamMembers: { type: String },
    budgetAndTools: { type: String },
  },

  contentKPIsAndMetrics: {
    keyPerformanceIndicators: { type: String },
    benchmarkData: { type: String },
  },

  contentThemesAndTopics: {
    themesAndTopics: { type: String },
  },

  editorialCalendar: {
    tentativeDates: { type: String },
  },

  contentPromotionStrategy: {
    socialMediaStrategy: { type: String },
    emailNewsletterStrategy: { type: String },
    paidAdvertisingStrategy: { type: String },
  },

  seoStrategy: {
    keywords: { type: String },
    seoGuidelines: { type: String },
  },

  contentDistributionPlan: {
    distributionChannels: { type: String },
  },
});

const ContentCalendar = mongoose.model('ContentCalendar', contentCalendarSchema);

module.exports = ContentCalendar;
