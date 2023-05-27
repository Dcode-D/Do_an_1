const express = require('express');
const router = express.Router();
const {createCar, getCar, getCarById, updateCar, deleteCar, updateCarImage, deleteCarImage, carFilesExtOptions, uploadCarImage} = require('../controller/carController');
const utils_auth = require("../middleware/utils_auth");
const fileUploadMiddleware = require("../middleware/fileUpload");
const{confidentialFilesExtOptions, uploadConfidentialFiles, deleteConfidentialFiles, getConfidentialFilesById} = require('../controller/confidentialFileController');

// Get all cars queries maxPrice, minPrice, page
router.get('/', getCar);

// Get a specific car
router.get('/:id', getCarById);

router.use(utils_auth);
// Create a new car
router.post('/',[fileUploadMiddleware, carFilesExtOptions, createCar]);
// Update a specific car
router.put('/:id',updateCar);
//require imageId in body
router.put('/upload/:id',[fileUploadMiddleware, carFilesExtOptions ,updateCarImage]);

// Delete a specific car
router.delete('/:id', deleteCar);
router.post('/upload_img/:id',[fileUploadMiddleware, carFilesExtOptions ,uploadCarImage]);
router.delete('/delete_img/:id', deleteCarImage);


module.exports = router;