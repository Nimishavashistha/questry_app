const mongoose = require("mongoose")

const PostSchema = new mongoose.Schema(
  {
    userId: {
      type: String,
      required: true
    },
    desc: {
      type: String,
      max: 500,
    },
    // comments: [{
    //   content: {
    //     type: String,
    //     required: true
    //   },
    //   tag: Object,
    //   reply: mongoose.Types.ObjectId,
    //   likes: [{
    //     type: String,
    //   }],
    //   dislikes: [{
    //     type: String,
    //   }],
    //   userName: { type: String, required: true },
    //   postUserId: {
    //     type: String,
    //     required: true,
    //   },
    //   userpic:{
    //     type: String,
    //     default: "",
    //   }
    //   // timestamps: true
    // }],
    img: {
      default: "",
      type: String,
    },
    likes: {
      type: Array,
      default: [],
    },
    noOfanswers: [{
          type: String,
        }],
  },
  { timestamps: true }
);


module.exports = mongoose.model("Post", PostSchema);