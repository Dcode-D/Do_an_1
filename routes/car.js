const express = require('express');
const router = express.Router();
const {createCar, getCar, getCarById, updateCar, deleteCar, updateCarImage, deleteCarImage, carFilesExtOptions} = require('../controller/carController');
const utils_auth = require("../middleware/utils_auth");
const fileUploadMiddleware = require("../middleware/fileUpload");

// Get all cars queries maxPrice, minPrice, page
router.get('/', getCar);

// Get a specific car
router.get('/:id', getCarById);

router.use(utils_auth);
router.use([fileUploadMiddleware, carFilesExtOptions]);
// Create a new car
router.post('/', createCar);
// Update a specific car
router.put('/:id', updateCar);

// Delete a specific car
router.delete('/:id', deleteCar);
router.put('/update_img/:id', updateCarImage);
router.delete('/delete_img/:id', deleteCarImage);

module.exports = router;