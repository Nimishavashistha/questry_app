const express = require("express"); //acquiring express
const app = express();
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const helmet = require("helmet");
const morgan = require("morgan"); // acquiring all the things...
const authRoute = require("./routes/auth");
const userRoute = require("./routes/users");
const multer = require("multer");
const router = express.Router();
const path = require("path");
const User = require("./models/user")
const middleware = require("./middleware");

dotenv.config(); // configuring the env

mongoose
  .connect(process.env.MONGO_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
  })
  .then(() => console.log("Database connected!"))
  .catch((err) => console.log(err));

// It's Stuff time...
app.use(express.json());
app.use(helmet());
app.use(morgan("common"));
app.use("/images", express.static(path.join(__dirname, "public/images")));

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "public/images");
  },
  filename: (req, file, cb) => {
    cb(null, req.decoded.username + ".jpg");
  },
});


const upload = multer({ storage: storage });

app.patch("/api/upload", middleware.checkToken, upload.single("file"), async(req, res) => {
  console.log("iside add image func");
  await User.findOneAndUpdate(
    { username: req.decoded.username },
    {
      $set: {
        profilePicture: req.file.path,
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
  // console.log(req.decoded.id);
});



app.use("/api/users", userRoute);
app.use("/api/auth", authRoute);



app.listen(8800, () => console.log("Backend Running!! "));