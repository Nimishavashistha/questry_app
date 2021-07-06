const router = require("express").Router();
const Post = require("../models/post");
const User = require("../models/user");
const multer = require("multer");
const middleware = require("../middleware");

console.log("inside posts page");
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
      cb(null, "public/images");
    },
    filename: (req, file, cb) => {
      cb(null, req.params.id + ".jpg");
    },
  });
  
  
  const upload = multer({ storage: storage });
  
  router.patch("/add/img/:id", middleware.checkToken, upload.single("file"), async(req, res) => {
    console.log("iside add image func");
    await Post.findOneAndUpdate(
      { _id: req.params.id },
      {
        $set: {
          img: req.file.path,
        },
      },
      { new: true },
      (err, profile) => {
        if (err) return res.status(500).send(err);
        const response = {
          message: "image added successfully updated",
          data: profile,
        };
        return res.status(200).send(response);
      } 
    );
    // console.log(req.decoded);
    console.log(req.decoded.id);
  });

//get own post




//create a post
router.post("/",middleware.checkToken, async (req, res) => {
  const newPost = new Post({
      userId: req.decoded.id,
      desc: req.body.desc,
      img: req.body.img,
      likes: req.body.likes
    });
    newPost
    .save()
    .then((result) => {
      res.json({ data: result["_id"] });
    })
    .catch((err) => {
      console.log(err), res.json({ err: err });
    });
});

module.exports = router;