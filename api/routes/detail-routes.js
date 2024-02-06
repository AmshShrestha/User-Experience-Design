const express = require("express");
const router = express.Router();
const { protect } = require("../middleware/auth");

const {
  createDetails,
  getAllDetails,
  updateDetails,
  uploadCoverPhoto,
  deleteDetails,
} = require("../controllers/detail-controller");

router.post("/createDetails", protect, createDetails);
router.post("/uploadCoverPhoto", protect, uploadCoverPhoto);
router.get("/", protect, getAllDetails);
router.put("/updateDetails/:id", updateDetails);
router.delete("/deleteDetails/:id", deleteDetails);

module.exports = router;
