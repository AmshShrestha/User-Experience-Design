// CRUD Operations

const asyncHandler = require("../middleware/async");
const Details = require("../models/details");

// @desc    Create new details
// @route   POST /api/v1/details
// @access  Private

exports.createDetails = asyncHandler(async (req, res, next) => {
  console.log(req.user);
  // console.log(req.body);
  try {
    const details = {
      //Creating an object to save to database
      image: req.body.image, //left - object properties, right - object bata aako value
      title: req.body.title,
      url: req.body.url,
      date: req.body.date,
    };

    console.log(details);

    const newDetails = await Details.create(details);
    res.status(201).json({
      success: true,
      data: newDetails,
    });
  } catch (err) {
    console.log(err);
    res.status(400).json({ success: false });
  }
});

exports.getAllDetails = asyncHandler(async (req, res, next) => {
  const details = await Details.find();
  try {
    res.status(200).json({
      success: true,
      count: details.length,
      data: details,
      message: "Successfully fetched",
    });
  } catch (err) {
    res.status(400).json({ success: false });
  }
});

exports.uploadCoverPhoto = asyncHandler(async (req, res, next) => {
  if (!req.file) {
    return res.status(400).send({ message: "Please upload a file" });
  }
  res.status(200).json({
    success: true,
    data: req.file.filename,
  });
});

exports.updateDetails = asyncHandler(async (req, res, next) => {
  let details = await Details.findById(req.params.id);

  if (!details) {
    return res
      .status(404)
      .json({ message: "Details not found with id of ${req.params.id}" });
  }

  details = await Details.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
    runValidators: true,
  });

  res.status(200).json({
    success: true,
    data: details,
  });
});

exports.deleteDetails = asyncHandler(async (req, res, next) => {
  console.log(req.params.id);
  Details.findByIdAndDelete(req.params.id)
    .then((details) => {
      if (details != null) {
        var imagePath = path.join(
          __dirname,
          "..",
          "public",
          "uploads",
          details.image
        );

        fs.unlink(imagePath, (err) => {
          if (err) {
            console.log(err);
          }
          res.status(200).json({
            success: true,
            message: "Details deleted successfully",
          });
        });
      } else {
        res.status(400).json({
          success: false,
          message: "Details not found",
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
