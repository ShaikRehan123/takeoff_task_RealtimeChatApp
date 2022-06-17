const app = require("express")();
const cors = require("cors");
const bodyParser = require("body-parser");
const mysql = require("mysql");
const dayjs = require("dayjs");
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const socket = require("socket.io");

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "chatbot",
});

connection.connect((err) => {
  if (err) {
    console.log(err);
  } else {
    console.log("Connected to database" + connection.threadId);
  }
});

app.get("/", (req, res) => {
  res.send({
    status: 200,
    message: "Hello Bro",
  });
});

app.post("/signup", (req, res) => {
  const { name, email, phone, userType, address, description, password } =
    req.body;

  // make sure there is no user with the same email

  connection.query(
    "SELECT * FROM users WHERE email = ?",
    [email],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        if (result.length > 0) {
          res.send({
            status: 400,
            message: "User already exists",
          });
        } else {
          connection.query(
            "INSERT INTO users (`role_id`,`email`,`name`,`phone`,`password`,`address`, `type`,`des`) VALUES (?,?,?,?,?,?,?,?)",
            [
              userType,
              email,
              name,
              phone,
              password,
              address,
              userType,
              description,
            ],
            (err, result) => {
              console.log(result);
              if (err) {
                console.log(err);
                res.send({
                  status: 400,
                  message: "Error",
                });
              } else {
                // get the user data
                connection.query(
                  "SELECT * FROM users WHERE email = ?",
                  [email],
                  (err, result) => {
                    if (err) {
                      console.log(err);
                      res.send({
                        status: 400,
                        message: "Error",
                      });
                    } else {
                      res.send({
                        status: 200,
                        message: "Success",
                        data: result[0],
                      });
                    }
                  }
                );
              }
            }
          );
        }
      }
    }
  );

  console.table(req.body);
  // res.send(req.body);
});

app.post("/login", (req, res) => {
  const { email, password } = req.body;
  connection.query(
    "SELECT * FROM users WHERE email = ? AND password = ?",
    [email, password],
    (err, result) => {
      if (err) {
        console.log(err);
        res.send({
          status: 400,
          message: "Error",
        });
      } else {
        if (result.length > 0) {
          res.send({
            status: 200,
            message: "Success",
            data: result[0],
          });
        } else {
          res.send({
            status: 400,
            message: "Invalid email or password",
          });
        }
      }
    }
  );
});

app.get("/get_all_questions", (req, res) => {
  connection.query(
    "SELECT questions.question, questions.q_date, questions.answer, questions.a_date , questions.id as questionID, users.name as userName FROM questions INNER JOIN users ON users.id = questions.user_id",
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        console.log(result);
        let formatted = result.map((item) => {
          return {
            questionId: item.questionID,
            userName: item.userName,
            question: item.question,
            questionDate: item.q_date,
            answer: item.answer,
            answerDate: item.a_date,
          };
        });
        res.send({
          status: 200,
          message: "Success",
          data: formatted,
        });
      }
    }
  );
});

const server = app.listen(8080, (err) => {
  if (err) {
    console.log(err);
  }
  console.log("server is running on port 8080");
});

const io = socket(server, {
  cors: {
    origin: "http://localhost:3000",
    credentials: true,
  },
});

global.onlineUsers = new Map();

io.on("connection", (socket) => {
  /* socket object may be used to send specific messages to the new connected client */

  socket.broadcast.emit("new_user", "New user connected");
  console.log("new client connected");
  socket.emit("connection", null);

  socket.on("message", (data) => {
    console.log(data);
    connection.query(
      "INSERT INTO questions (`user_id`,`question`,`q_date`) VALUES (?,?,?)",
      [data.user_id, data.question, dayjs().format("YYYY-MM-DD HH:mm:ss")],
      (err, result) => {
        if (err) {
          console.log(err);
        } else {
          console.log(result);
        }
      }
    );
    connection.query(
      "SELECT questions.question, questions.q_date, questions.answer, questions.a_date , questions.id as questionID, users.name as userName FROM questions INNER JOIN users ON users.id = questions.user_id",
      (err, result) => {
        if (err) {
          console.log(err);
        } else {
          console.log(result);
          let formatted = result.map((item) => {
            return {
              questionId: item.questionID,
              userName: item.userName,
              question: item.question,
              questionDate: item.q_date,
              answer: item.answer,
              answerDate: item.a_date,
            };
          });
          io.emit("recieve_message", formatted);
        }
      }
    );
  });

  socket.on("send_answer", (data) => {
    const { question_id, answer } = data;
    connection.query(
      "UPDATE questions SET answer = ?, a_date = ? WHERE id = ?",
      [answer, dayjs().format("YYYY-MM-DD HH:mm:ss"), question_id],
      (err, result) => {
        if (err) {
          console.log(err);
        } else {
          console.log(result);
        }
      }
    );
    connection.query(
      "SELECT questions.question, questions.q_date, questions.answer, questions.a_date , questions.id as questionID, users.name as userName FROM questions INNER JOIN users ON users.id = questions.user_id",
      (err, result) => {
        if (err) {
          console.log(err);
        } else {
          console.log(result);
          let formatted = result.map((item) => {
            return {
              questionId: item.questionID,
              userName: item.userName,
              question: item.question,
              questionDate: item.q_date,
              answer: item.answer,
              answerDate: item.a_date,
            };
          });
          io.emit("recieve_message", formatted);
        }
      }
    );
  });

  socket.on("disconnect", () => {
    console.log("client disconnected");
  });
});
