//Define database schema

const mongoose = require("mongoose");
const detailSchema = new mongoose.Schema({
  image: {
    type: String,
    default: null,
  },

  title: {
    type: String,
    required: true,
    trim: true,
  },

  url: {
    type: String,
    required: true,
    trim: true,
  },
  date: {
    type: String,
    required: true,
    trim: true,
  },
});

module.exports = mongoose.model("Details", detailSchema);
