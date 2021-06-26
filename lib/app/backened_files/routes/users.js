const User = require("../models/user");
const router = require("express").Router();
const bcrypt = require("bcrypt");
const middleware = require("../middleware");

//update user
router.put("/:id", async (req, res) => {
    if (req.body.userId === req.params.id || req.body.isAdmin) {
      if (req.body.password) {
        try {
          const salt = await bcrypt.genSalt(10);
          req.body.password = await bcrypt.hash(req.body.password, salt);
        } catch (err) {
          return res.status(500).json(err);
        }
      }
      try {
        const user = await User.findByIdAndUpdate(req.params.id, {
          $set: req.body,
        });
        res.status(200).json("Account has been updated");
      } catch (err) {
          console.log("internal error");
        return res.status(500).json(err);
      }
    } else {
      return res.status(403).json("You can update only your account!");
    }
  });

  //add a user

  router.post("/add/profile",middleware.checkToken,async(req,res) => {
    await User.findOneAndUpdate(
      { username: req.decoded.username },
      {
        $set: {
          sem: req.body.sem,
          from: req.body.from,
          desc: req.body.desc
        },
      },
      { new: true },
      (err, profile) => {
        if (err) return res.status(500).send(err);
        const response = {
          message: "profile successfully stored",
          data: profile,
        };
        return res.status(200).send(response);
      }
    );
  })

  //delete user

router.delete("/:id",middleware.checkToken,async (req, res) => {
    if (req.body.userId === req.params.id || req.body.isAdmin) {
      try {
        await User.findByIdAndDelete(req.params.id);
        res.status(200).json("Account has been deleted");
      } catch (err) {
        return res.status(500).json(err);
      }
    } else {
      return res.status(403).json("You can delete only your account!");
    }
  });

  module.exports=router;