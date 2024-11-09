import express from "express";

const app = express();
const port = 3000;

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

let comments: any[] = [];

app.get("/", (req, res) => {
  const commentList = comments.map((comment) => `<p>${comment}</p>`).join("");
  res.send(`
    <h1>Comments</h1>
    ${commentList}
    <form action="/comment" method="POST">
      <input type="text" name="comment" placeholder="Enter a comment" required>
      <button type="submit">Submit</button>
    </form>
  `);
});

// Route to add a comment
app.post("/comment", (req, res) => {
  const comment = req.body.comment;
  comments.push(comment); // Store the comment directly without sanitization
  res.redirect("/");
});
app.listen(port, () => {
  console.log(`Listening on port ${port}...`);
});

