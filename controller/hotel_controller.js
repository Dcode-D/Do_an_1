const fileUpload = require('express-fileupload');
const path = require('path');
const FileModel = require('../models/files_model');
const hotelModel = require('../models/hotel_model');
const hotelRoomModel = require('../models/hotel_room_model');
const fileExtLimiter = require('../middleware/file_ext_limiter');

const fileUploadMiddleware = fileUpload({
    limit: { fileSize: 50 * 1024 * 1024 },
    useTempFiles: true,
    tempFileDir: path.join(__dirname, '../temp'),
    createParentPath: true,
    abortOnLimit: true,
});

const fileExtLimiterMiddleware = fileExtLimiter(['.jpg', '.png', '.jpeg', '.gif']);


const hotelController = async (req,res)=>{
    try {
        var imglist = []
        if (req.files) {
            const files = req.files;
            for (const key in files) {
                const filename = Date.now().toString() + files[key].name;
                const filepath = path.join(__dirname, '../upload/images', filename)
                const fileModel = new FileModel({
                    "name": filename,
                    "path": filepath,
                    "description": req.body.description,
                    "attachedId": req.body.attachedId,
                    "publishBy": req.user._id,
                });
                await fileModel.save();
                await files[key].mv(filepath, (err) => {
                    if (err) return res.status(500).json({status: "error", message: err})
                })
                imglist.push(fileModel._id)
            }
        }
        const hotel = new hotelModel({
            "name": req.body.name,
            "description": req.body.description,
            "address": req.body.address,
            "images": imglist,
            "owner": req.user._id,
            "province": req.body.province,
        });
        await hotel.save();
        return res.status(200).send('Hotel information uploaded');
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getHotel = async (req,res)=>{
    try {
        if(req.params.id) {
            const hotel = await hotelModel.find({_id: req.params.id});
            return res.status(200).json({status: "success", data: hotel});
        }else {
            return res.status(400).json({status: "error", message: "No hotel id"});
        }
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getHotelByQueries = async (req,res)=>{
    const PAGE_SIZE = 10;
    const queries = req.query;
    const page = req.params.page;
    const province = queries.province;
    try{
        const query = hotelModel.find({})
        const intpage = parseInt(page);
        if(intpage < 1) {
            return res.status(400).json({status: "error", message: "Invalid page number"});
        }
        if(province) {
            query.where({province: province})
        }
        const hotels = await query.skip((intpage - 1) * PAGE_SIZE).limit(PAGE_SIZE).exec();
        return res.status(200).json({status: "success", data: hotels});

    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const uploadHotelRoom = async (req,res)=>{
    try{
        if(!req.params.hotel){
            console.log("no hotel id");
            return res.status(400).json({status: "error", message: "No hotel id"});
        }
        const hotel = await hotelModel.find({_id: req.params.hotel});
        if(!hotel||hotel.length===0||!hotel[0].owner.equals(req.user._id)){
            console.log("invalid hotel id");
            return res.status(400).json({status: "error", message: "Invalid hotel id"});
        }
        const hotelRoom = new hotelRoomModel({
            "number": req.body.number,
            "hotel": req.params.hotel,
            "adultCapacity": req.body.adultCapacity,
            "childrenCapacity": req.body.childrenCapacity,
            "price": req.body.price,
        });
        await hotelRoom.save();
        res.status(200).send('Hotel room information uploaded');
    }catch (e){
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getHotelRoom = async (req,res)=>{
    try{
        if(!req.params.hotel){
            return res.status(400).json({status: "error", message: "No hotel id"});
        }
        const hotelRoom = await hotelRoomModel.find({hotel: req.params.hotel});
        return res.status(200).json({status: "success", data: hotelRoom});
    }
    catch (e){
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

module.exports = {fileUploadMiddleware, fileExtLimiterMiddleware, hotelController, getHotel,getHotelByQueries,uploadHotelRoom,getHotelRoom};