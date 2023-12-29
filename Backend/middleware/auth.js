const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
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

module.exports = auth;




const generateTokenAndSetCookie =(userId, res)=>{
  const token =jwt.sign({ userId}, process.env.JWT_SECRET,{
      expiresIn: '15d',
  })
   res.cookie("jwt", token, {
      httpOnly: true, // more secure
      maxAge: 15 * 24 * 60*60 * 1000, //15 days
      sameSite: "strict", // CSRF
   })
   return token;
  }
  
  module.exports= generateTokenAndSetCookie;