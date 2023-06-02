const express = require('express');
const router = express.Router();
const auth = require('../middleware/utils_auth');
const {createTour, deleteTour, getTourList, getTour, updateTour} = require('../controller/tourController');

router.get('/id/:id', getTour);
router.get('/page/:page', getTourList);
router.use(auth);
router.post('/', createTour);
router.put('/:id', updateTour);
router.delete('/:id', deleteTour);

module.exports = router;