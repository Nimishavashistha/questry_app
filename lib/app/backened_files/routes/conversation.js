const router = require("express").Router();
const middleware = require("../middleware");
const Conversation = require("../models/conversation");


//new conv

router.post("/",middleware.checkToken, async (req,res) => {
    const newConversation = new Conversation({
        members: [req.body.senderId, req.body.receiverId],
    });

    try{
      const savedConversation = await newConversation.save();
      res.status(200).json(savedConversation);
    }catch(err)
    {
      res.status(500).json(err);
    }
});

//get conv of a user
router.get("/:userId",middleware.checkToken,async(req,res) => {
    try{
        const conversations = await Conversation.find({
            members: { $in: [req.params.userId]},
        });
        res.status(500).json(conversations);

    }catch(err)
    {
      res.status(500).json(err);
    }
});

module.exports = router;
