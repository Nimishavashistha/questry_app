const express = require("express"); //acquiring express
const app = express();
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const helmet = require("helmet");
const morgan = require("morgan"); // acquiring all the things...
const authRoute = require("./routes/auth");
const multer = require("multer");
const router = express.Router();
const path = require("path");


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


app.use("/api/auth", authRoute);



app.listen(8800, () => console.log("Backend Running!! "));