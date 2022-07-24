//import from packages
const express = require("express");
const mongoose = require("mongoose");

//import from other files
const authRouter = require("./routes/auth");

//init
const app = express();
const PORT = 3000;

//databese url

//middleware
app.use(express.json());
app.use(authRouter);

//connections
mongoose
  .connect(DB_URL)
  .then(() => {
    console.log("connection succesfull");
  })
  .catch((e) => console.log(e));

app.listen(PORT, "0.0.0.0", () => {
  console.log("connected " + PORT);
});
