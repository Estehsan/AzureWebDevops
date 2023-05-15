const express = require("express");
const app = express();

app.get("/", (req, res) => {
  const userAgent = req.headers["user-agent"];
  res.send(`Welcome to 2022! Your user agent is: ${userAgent}`);
});

app.listen(3000, () => {
  console.log("Server is listening on port 3000");
});
