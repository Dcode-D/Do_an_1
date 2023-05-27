const express = require('express');
const router = express.Router();
const {fileUploadMiddleware, fileExtLimiterMiddleware, hotelController, getHotel, getHotelByQueries,updateHotelInfo,uploadHotelImage,deleteHotel,deleteHotelImage,updateHotelImage} = require('../controller/hotel_controller');
const {uploadHotelRoom,getHotelRoom,deleteHotelRoom,updateHotelRoom} = require('../controller/hotelRoomController');
const authen = require('../middleware/utils_auth');
const {
    confidentialFilesExtOptions,
    uploadConfidentialFiles,
    getConfidentialFilesById,
    deleteConfidentialFiles
} = require("../controller/confidentialFileController");

router.get('/id/:id', getHotel);
router.get('/page/:page',getHotelByQueries)
//pass in query: day -> get only available room for that day
router.get('/:hotel/room',getHotelRoom)
router.use(authen);
router.post('/', [fileUploadMiddleware, fileExtLimiterMiddleware, hotelController]);
router.post('/:hotel/room',uploadHotelRoom)
router.put('/:id', updateHotelInfo);
router.post('/upload_img/:id', [fileUploadMiddleware, fileExtLimiterMiddleware, uploadHotelImage]);
router.put('/:hotel/room/:id',updateHotelRoom)
router.delete('/:hotel/room/:id',deleteHotelRoom)
router.delete('/:id', deleteHotel);
router.delete('/delete_img/:id', deleteHotelImage);
//require imageId in body
router.put('/update_img/:id', [fileUploadMiddleware, fileExtLimiterMiddleware, updateHotelImage])

module.exports = router;