import express from "express";
import { Database } from "bun:sqlite";

const app = express();
const port = 3000;

const db = new Database(":memory:");

// Initialize database with sample users
db.run(`
  CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT
  );
  INSERT INTO users (name) VALUES ("Alice");
  INSERT INTO users (name) VALUES ("Bob");
  INSERT INTO users (name) VALUES ("Charlie");
`);

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Get all users
app.get("/users", (req, res) => {
  const users = db.query("SELECT * FROM users").all();
  res.json(users);
});

// Get user by ID (Unsafe: Vulnerable to SQL Injection)
app.get('/user/:id', (req, res) => {
  const { id } = req.params;
  // Vulnerable SQL query using string concatenation
  const user = db.query("SELECT * FROM users WHERE id = " + id).get();

  if (user) {
    res.json(user);
  } else {
    res.status(404).send("User not found");
  }
});

// Add new user
app.post("/user", (req, res) => {
  const { name } = req.body;
  try {
    db.run("INSERT INTO users (name) VALUES (?)", [name]);
    res.status(201).send(`User ${name} added!`);
  } catch (error) {
    res.status(500).send("Error adding user");
  }
});

app.listen(port, () => {
  console.log(`Listening on port ${port}...`);
});


// how to prevent this

// import express from "express";
// import { Database } from "bun:sqlite";

// const app = express();
// const port = 3000;

// const db = new Database(":memory:");

// // Initialize database with sample users
// db.run(`
//   CREATE TABLE users (
//     id INTEGER PRIMARY KEY,
//     name TEXT
//   );
//   INSERT INTO users (name) VALUES ("Alice");
//   INSERT INTO users (name) VALUES ("Bob");
//   INSERT INTO users (name) VALUES ("Charlie");
// `);

// app.use(express.urlencoded({ extended: true }));
// app.use(express.json());

// // Get all users
// app.get("/users", (req, res) => {
//   const users = db.query("SELECT * FROM users").all();
//   res.json(users);
// });

// // Get user by ID (Safe: Using parameterized queries)
// app.get('/user/:id', (req, res) => {
//   const { id } = req.params;
//   // Safe SQL query using parameterized queries
//   const user = db.query("SELECT * FROM users WHERE id = ?").get(id);

//   if (user) {
//     res.json(user);
//   } else {
//     res.status(404).send("User not found");
//   }
// });

// // Add new user
// app.post("/user", (req, res) => {
//   const { name } = req.body;
//   try {
//     db.run("INSERT INTO users (name) VALUES (?)", [name]);
//     res.status(201).send(`User ${name} added!`);
//   } catch (error) {
//     res.status(500).send("Error adding user");
//   }
// });

// app.listen(port, () => {
//   console.log(`Listening on port ${port}...`);
// });
