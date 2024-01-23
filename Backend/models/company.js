
const mongoose = require('mongoose');
const companyDetailsSchema = new mongoose.Schema({
    companyName: { type: String, required: true },
    industry: { type: String, required: true },
    niche: { type: String, required: true },
    missionStatement: { type: String, required: true },
    values: { type: String, required: true },
    cultureAndTone: { type: String, required: true },
  
    productOrServiceInformation: {
      details: { type: String, required: true },
      uniqueSellingPoints: { type: String, required: true },
      competitiveAdvantages: { type: String, required: true },
      features: { type: String, required: true },
      specifications: { type: String, required: true },
      benefits: { type: String, required: true },
    },
  
    marketingAndBrandingMaterials: {
      brandGuidelines: { type: String, required: true },
    },
  
    timelinessAndFrequency: {
      emailFrequency: { type: String, required: true },
      timeSensitiveInformation: { type: String },
      promotions: { type: String },
    },
  
    keyMessagingPoints: {
      productServiceBenefits: { type: String, required: true },
      customerPainPointsSolutions: { type: String, required: true },
    },
  
    legalAndComplianceInformation: {
      legalRequirements: { type: String, required: true },
      disclaimersOrDisclosures: { type: String, required: true },
    },
  
    competitorInformation: {
      competitors: { type: String, required: true },
      marketingStrategies: { type: String, required: true },
    },
  

  });
  
  const CompanyDetails = mongoose.model('CompanyDetails', companyDetailsSchema);
  
  module.exports = CompanyDetails;