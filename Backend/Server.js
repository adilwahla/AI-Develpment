const express = require('express');
const app = express();
const connectDB = require("./db/connectdb");
const dotenv = require("dotenv");
const userRoutes=require("./routes/userRoutes");


dotenv.config();
connectDB();
app.get('/api/data', (req, res) => {
    res.json({ message: 'Hello from Node.js Express!' });
});

app.use("/api/users" , userRoutes);
const port = process.env.PORT || 3000;

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
