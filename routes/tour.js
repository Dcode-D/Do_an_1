const express = require('express');
const router = express.Router();
const auth = require('../middleware/utils_auth');
const {createTour, deleteTour, getTourList, getTour, updateTour} = require('../controller/tourController');

router.get('/id/:id', getTour);
router.get('/page/:page', getTourList);