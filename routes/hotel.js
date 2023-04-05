const express = require('express');
const router = express.Router();
const {fileUploadMiddleware, fileExtLimiterMiddleware, hotelController, getHotel, getHotelByQueries,uploadHotelRoom,getHotelRoom} = require('../controller/hotel_controller');
const authen = require('../middleware/utils_auth');

router.get('/:id', getHotel);
router.get('/',getHotelByQueries)
router.get('/:hotel/room',getHotelRoom)
router.use(authen);
router.post('/', [fileUploadMiddleware, fileExtLimiterMiddleware, hotelController]);
router.post('/:hotel/room',uploadHotelRoom)

module.exports = router;