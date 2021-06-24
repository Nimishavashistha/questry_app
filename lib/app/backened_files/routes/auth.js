const router = require("express").Router();
const User = require("../models/user");
const bcrypt = require("bcrypt");
const config = require("../config");
const jwt = require("jsonwebtoken");
const middleware = require("../middleware");

//Register
router.post("/register", async (req, res) => {
  try {
    //generate new password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(req.body.password, salt);

    //create new user
    const newUser = new User({
      username: req.body.username,
      email: req.body.email,
      password: hashedPassword,
    });

    //save user and respond
    const user = await newUser.save();
    return res.status(200).json(user);
  } catch (err) {
    return res.status(500).json(err)
  }
});


//getting a single user
router.get("/:username",middleware.checkToken, async(req, res) => {
  User.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      username: req.params.username,
    });
  });
});

router.get("/checkusername/:username",async(req, res) => {
  User.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result !== null) {
      return res.json({
        Status: true,
      });
    } else
      return res.json({
        Status: false,
      });
  });
});


//LOGIN
router.post("/login",async (req, res) => {
  try {
    const user = await User.findOne({ email: req.body.email });
    !user && res.status(404).json("user not found");

    if (bcrypt.compare(req.body.password, user.password)){
        let token = jwt.sign({username: req.body.username},config.key,{
          expiresIn: "20h",
        });
        res.json({
          token: token,
          msg: "success",
        });
    }
    else{
      res.status(400).json("wrong password")
    }

    // return res.status(200).json(user)
  } catch (err) {
    return res.status(500).json(err)
  }
});


module.exports = router;