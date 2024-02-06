const asyncHandler = require("../middleware/async");
const User = require("../models/user");
const path = require("path");
const fs = require("fs");

exports.getUserProfile = asyncHandler(async (req, res, next) => {
  // Show current user
  const user = await User.findOne({ username: req.user.username });

  res.status(200).json({
    success: true,
    count: 1,
    data: [user],
  });
});

exports.register = asyncHandler(async (req, res, next) => {
  const existingUser = await User.findOne({ username: req.params.user });
  if (existingUser) {
    return res.status(400).send({ message: "User already exists" });
  }
  const newUser = {
    image: req.body.image,
    phone: req.body.phone,
    email: req.body.email,
    username: req.body.username,
    password: req.body.password,
  };
  const createUser = await User.create(newUser);

  res.status(200).json({
    success: true,
    data: createUser,
    message: "User created successfully",
  });
});

// @desc   Login student
exports.login = asyncHandler(async (req, res, next) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res
      .status(400)
      .send({ message: "Please provide an username and password" });
  }

  const user = await User.findOne({ username: username }).select("+password");

  if (!User) {
    return res.status(400).send({ message: "Invalid Credentials" });
    // return next(new ErrorResponse('Invalid credentials', 401));
  }

  //Check if password matches
  const isMatch = await user.matchPassword(password);

  if (!isMatch) {
    return res.status(400).send({ message: "Invalid Credentials" });
  }

  sendTokenResponse(user, 200, res);
});

// @desc    Update student
exports.updateUser = asyncHandler(async (req, res, next) => {
  const user = req.body;
  const user1 = await User.findByIdAndUpdate(req.params.id, user, {
    new: true,
    runValidators: true,
  });

  if (!user1) {
    return res.status(404).send({ message: "User not found" });
  }

  res.status(200).json({
    success: true,
    message: "User updated successfully",
    data: user1,
  });
});

// @desc    Delete student
exports.deleteUser = asyncHandler(async (req, res, next) => {
  console.log(req.params.id);
  User.findByIdAndDelete(req.params.id)
    .then((user) => {
      if (user != null) {
        var imagePath = path.join(
          __dirname,
          "..",
          "public",
          "uploads",
          user.image
        );

        fs.unlink(imagePath, (err) => {
          if (err) {
            console.log(err);
          }
          res.status(200).json({
            success: true,
            message: "User deleted successfully",
          });
        });
      } else {
        res.status(400).json({
          success: false,
          message: "User not found",
        });
      }
    })
    .catch((err) => {
      res.status(500).json({
        success: false,
        message: err.message,
      });
    });
});

// @desc Upload Single Image
exports.uploadImage = asyncHandler(async (req, res, next) => {
  // // check for the file size and send an error message
  // if (req.file.size > process.env.MAX_FILE_UPLOAD) {
  //   return res.status(400).send({
  //     message: `Please upload an image less than ${process.env.MAX_FILE_UPLOAD}`,
  //   });
  // }

  if (!req.file) {
    return res.status(400).send({ message: "Please upload a file" });
  }
  res.status(200).json({
    success: true,
    data: req.file.filename,
  });
  // .then(() => {
  //   const user = {'image': req.file.filename};
  //   Student.findByIdAndUpdate(req.params.id, user, {
  //     new: true,
  //     runValidators: true,
  //   });
  // }).catch();
});

// Get token from model , create cookie and send response
const sendTokenResponse = (Student, statusCode, res) => {
  const token = Student.getSignedJwtToken();

  const options = {
    //Cookie will expire in 30 days
    expires: new Date(
      Date.now() + process.env.JWT_COOKIE_EXPIRE * 24 * 60 * 60 * 1000
    ),
    httpOnly: true,
  };

  // Cookie security is false .if you want https then use this code. do not use in development time
  if (process.env.NODE_ENV === "proc") {
    options.secure = true;
  }
  //we have created a cookie with a token

  res
    .status(statusCode)
    .cookie("token", token, options) // key , value ,options
    .json({
      success: true,
      token,
    });
};
