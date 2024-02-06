const express = require("express");
const router = express.Router();
const { protect, verifyUser } = require("../middleware/auth");

const upload = require("../middleware/uploads");

const {
  getUserProfile,
  register,
  login,
  updateUser,
  deleteUser,
  uploadImage,
} = require("../controllers/user-controller");

router.post("/uploadImage", upload, uploadImage);
router.post("/register", register);
router.post("/login", login);
router.get("/", protect, getUserProfile);
router.put("/updateStudent/:id", protect, updateUser);
router.delete("/deleteUser/:id", protect, deleteUser);

module.exports = router;
