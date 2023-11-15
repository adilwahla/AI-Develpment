const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const cors = require('cors');
require('dotenv').config();

const PORT = process.env.PORT || 3000;
const app = express();
// Enable CORS for all routes
app.use(cors());
const dbURI = process.env.MONGO_URI;
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
    next();
  });
  
app.use(express.json());
app.use(authRouter);

// const DB =
//   "mongodb+srv://AIGeneration:AIGeneration@cluster0.xi1yz2v.mongodb.net/AIDevelopment?retryWrites=true&w=majority";

mongoose
  .connect(dbURI)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});