const mongoose = require("mongoose");
const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true
      },
    username:{
        type: String,
        required: true,
        unique: true
    },
    email:{
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        minLenght: 6,
        required: true,
    },
    profilePic:{
        type: String,
        default: "",
    }
},{
    timestamps:true,
});

// model
const User=mongoose.model('User',userSchema);
module.exports = User;