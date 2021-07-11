const mongoose = require('mongoose')

const commentSchema = new mongoose.Schema({
    content: {
        type: String,
        required: true
    },
    tag: Object,
    reply: mongoose.Types.ObjectId,
    likes: {
        type: Number,
        default: 0,
    },
    userName: {type: String,required: true},
    postUserId: {
        type: String,
        required: true,
    }
}, {
    timestamps: true
})

module.exports = mongoose.model('comment', commentSchema)
