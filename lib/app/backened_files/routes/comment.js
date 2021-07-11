const router = require("express").Router();
const Post = require("../models/post");
const User = require("../models/user");
const comment = require("../models/comment");
const multer = require("multer");
const middleware = require("../middleware");

//give comment
router.post("/:username",middleware.checkToken, async (req, res) => {
    const newComment = new comment({
        content: req.body.content,
        userName: req.params.username,
        postUserId: req.decoded.id
      });
      newComment
      .save()
      .then((result) => {
        res.json({ data: result });
      })
      .catch((err) => {
        console.log(err), res.json({ err: err });
      });
  });


module.exports = router;