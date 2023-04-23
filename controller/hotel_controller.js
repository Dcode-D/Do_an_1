const fileUpload = require('express-fileupload');
const path = require('path');
const fs = require('fs');
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

const updateHotelImage = async (req,res)=>{
    try {
        if (req.params.id) {
            let hotel = await hotelModel.findOne({_id: req.params.id});
            if(!hotel||!hotel.owner.equals(req.user._id)){
                return res.status(403).json({status: "error", message: "Not permitted"});
            }
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

                hotel.images = [...hotel.images, ...imglist];
                return res.status(200).send('Hotel image uploaded');
            }
            else {
                return res.status(400).json({status: "error", message: "No image uploaded"});
            }
        } else {
            return res.status(400).json({status: "error", message: "No hotel id"});
        }
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const deleteHotelImage = async (req,res)=>{
    try {
        if (req.params.id) {
            let hotel = await hotelModel.findOne({_id: req.params.id});
            if(!hotel||!hotel.owner.equals(req.user._id)){
                return res.status(403).json({status: "error", message: "Not permitted"});
            }
            if (req.body.imageId) {
                const imageId = req.body.imageId;
                const index = hotel.images.indexOf(imageId);
                if (index > -1) {
                    hotel.images.splice(index, 1);
                    const filetoDelete = await FileModel.findById(imageId);
                    if(filetoDelete){
                        const uri = filetoDelete.path;
                        fs.unlinkSync(uri)
                        await filetoDelete.deleteOne();
                    }
                }
                await hotel.save();
                return res.status(200).send('Hotel image deleted');
            }
            else {
                return res.status(400).json({status: "error", message: "No image id"});
            }
        } else {
            return res.status(400).json({status: "error", message: "No hotel id"});
        }
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getHotel = async (req,res)=>{
    try {
        if(req.params.id) {
            const hotel = await hotelModel.find({_id: req.params.id});
            if(hotel.length!==0)
                return res.status(200).json({status: "success", data: hotel});
            else
                return res.status(404).json({status: "error", message: "Hotel not found"});
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


const updateHotelInfo = async (req, res) => {
    const hotel = await hotelModel.findById(req.params.id);
    if(!hotel||!hotel.owner.equals(req.user._id)){
        return res.status(403).json({status: "error", message: "Id not found/ not permitted"});
    }
    const { id } = req.params;
    const { name, address, description, province } = req.body;
    const updateHotel = {
    };
    if(name) updateHotel.name = name;
    if(address) updateHotel.address = address;
    if(description) updateHotel.description = description;
    if(province) updateHotel.province = province;

    try {
        const updated = await hotelModel.findByIdAndUpdate(id, updateHotel, { new: true });
        res.status(200).json(updated);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

const deleteHotel = async (req, res) => {
    try {
        const hotelcheck = await hotelModel.findById(req.params.id);
        if(!hotelcheck||!hotelcheck.owner.equals(req.user._id)){
            return res.status(403).json({status: "error", message: "Not permitted"});
        }
        const hotel = await hotelModel.findByIdAndDelete(req.params.id);
        await hotelRoomModel.deleteMany({hotel: req.params.id});
        await FileModel.deleteMany({attachedId: req.params.id});

        if (!hotel) {
            return res.status(404).send({ error: 'Hotel not found' });
        }

        return res.send({ message: 'Hotel deleted successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).send({ error: 'Server error' });
    }
}

module.exports = {fileUploadMiddleware, fileExtLimiterMiddleware, hotelController, getHotel,getHotelByQueries, updateHotelInfo, updateHotelImage, deleteHotel, deleteHotelImage};