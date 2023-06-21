const fileUpload = require('express-fileupload');
const path = require('path');
const fs = require('fs');
const FileModel = require('../models/files_model');
const hotelModel = require('../models/hotel_model');
const hotelRoomModel = require('../models/hotel_room_model');
const facilityModel = require('../models/facility_model');
const DateBookingModel = require('../models/dateBookingModel');
const fileExtLimiter = require('../middleware/file_ext_limiter');

const fileUploadMiddleware = fileUpload({
    limit: { fileSize: 50 * 1024 * 1024 },
    useTempFiles: true,
    tempFileDir: path.join(__dirname, '../temp'),
    createParentPath: true,
    abortOnLimit: true,
});

const fileExtLimiterMiddleware = fileExtLimiter(['.jpg', '.png', '.jpeg', '.gif']);

//facilities names can also be provided here as facilitiesNames
const getMaxPage = async (req,res)=>{
    try {
        const {maxPrice,minPrice, facilities} = req.query;
        let maxprice, minprice;
        let minlist = [], maxlist =[], facilist = [];
        if (maxPrice) {
            maxprice = parseInt(maxPrice);
            delete req.query.maxPrice;
        }
        if(minPrice){
            minprice = parseInt(minPrice);
            delete req.query.minPrice;
        }

        const query = hotelModel.countDocuments(req.query);
        if(minprice) {
            minlist = await hotelRoomModel.find({price: {$gte: minprice}}).select('hotel');
        }
        if(maxprice) {
            maxlist = await hotelRoomModel.find({price: {$lte: maxprice}}).select('hotel');
        }
        const selectlist = [...minlist, ...maxlist];
        if(minprice||maxprice){
            const hotelList = selectlist.map(hotel=>hotel.hotel);
            query.where('_id').in(hotelList);
        }
        if(facilities){
            query.where('facilities').in(facilities);
        }
        const maxPage = await query.exec();
        res.status(200).json({data:Math.ceil(maxPage/10)});
    } catch (error) {
        console.error(error);
        res.status(500).json({status: "error", message: error});
    }
}

//add facilities to hotel
const hotelController = async (req,res)=>{
    try {
        let imglist = []
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
            "city": req.body.city,
            "facilities": req.body.facilities,
        });
        await hotel.save();
        return res.status(200).send('Hotel information uploaded');
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const uploadHotelImage = async (req,res)=>{
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
                await  hotel.save();
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

//imageId required in body
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
            const hotel = await hotelModel.findById(req.params.id);
            const maxprice = await hotelRoomModel.find({hotel: req.params.id}).sort({price: -1}).limit(1);
            const minprice = await hotelRoomModel.find({hotel: req.params.id}).sort({price: 1}).limit(1);
            let maxPrice, minPrice;
            if(maxprice.length >0 && minprice.length >0){
                maxPrice= maxprice[0].price;
                minPrice = minprice[0].price;
            }
            if(hotel.length!==0)
                return res.status(200).json({status: "success", data: {_id: hotel._id, name: hotel.name, description: hotel.description, address: hotel.address, images: hotel.images, owner: hotel.owner, province: hotel.province, city: hotel.city, maxPrice: maxPrice, minPrice: minPrice, facilities: hotel.facilities, rooms: hotel.rooms}});
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

//provide the required facilities name to filter the hotel
const getHotelByQueries = async (req,res)=>{
    const PAGE_SIZE = 10;
    const queries = req.query;
    const page = req.params.page;
    const province = queries.province;
    const city = queries.city;
    const name = queries.name;
    const owner = queries.owner;
    const address = queries.address;
    const maxprice = queries.maxPrice;
    const minprice = queries.minPrice;
    const facilities = queries.facilities;
    try{
        let minlist = [];
        let maxlist = [];
        const query = hotelModel.find({})
        const intpage = parseInt(page);
        if(intpage < 1) {
            return res.status(400).json({status: "error", message: "Invalid page number"});
        }
        if(province) {
            query.where('province', new RegExp(province, 'i'))
        }
        if(city) {
            query.where('city', new RegExp(city, 'i'))
        }
        if(name) {
            query.where('name', new RegExp(name, 'i'))
        }
        if(owner) {
            query.where({owner: owner})
        }
        if(address) {
            query.where('address', new RegExp(address, 'i'))
        }
        if(minprice) {
           const tmp = await hotelRoomModel.find({price: {$gte: minprice}}).select('hotel');
           minlist = tmp.map((item)=>item.hotel);
        }
        if(maxprice) {
            maxlist = (await hotelRoomModel.find({price: {$lte: maxprice}}).select('hotel')).map((item)=>item.hotel);
        }
        if(facilities) {
            query.where("facilities").in(facilities);
        }

        const selectlist = [...minlist, ...maxlist];
        if(minprice||maxprice) {
            query.where({_id: {$in: selectlist}});
        }
        const hotels = await query.skip((intpage - 1) * PAGE_SIZE).limit(PAGE_SIZE).exec();
        const returnlist = [];
        for(const hotel of hotels){
            const maxprice = await hotelRoomModel.find({hotel: hotel._id}).sort({price: -1}).limit(1);
            const minprice = await hotelRoomModel.find({hotel: hotel._id}).sort({price: 1}).limit(1);
            if(maxprice.length >0 && minprice.length >0)
                returnlist.push({_id: hotel._id, name: hotel.name, description: hotel.description, address: hotel.address, images: hotel.images, owner: hotel.owner, province: hotel.province, city: hotel.city, facilities: hotel.facilities, maxPrice: maxprice[0].price, minPrice: minprice[0].price});
            else
                returnlist.push({_id: hotel._id, name: hotel.name, description: hotel.description, address: hotel.address, images: hotel.images, owner: hotel.owner, province: hotel.province, city: hotel.city, facilities: hotel.facilities});
        }
        return res.status(200).json({status: "success", data: returnlist});

    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

//include facilities objects in the request body to update the facilities, already existed facilities will be updated, new facilities will be created
const updateHotelInfo = async (req, res) => {
    try {
        const hotel = await hotelModel.findById(req.params.id);
        if(!hotel||!hotel.owner.equals(req.user._id)){
            return res.status(403).json({status: "error", message: "Id not found/ not permitted"});
        }
        const { id } = req.params;
        const { name, address, description, province, facilities } = req.body;
        const updateHotel = {
        };
        if(name) updateHotel.name = name;
        if(address) updateHotel.address = address;
        if(description) updateHotel.description = description;
        if(province) updateHotel.province = province;
        if(facilities){
            updateHotel.facilities = facilities;
        }
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
        const rooms = await hotelRoomModel.find({hotel: req.params.id});
        const checkBooking = await DateBookingModel.find({attachedServices: {$in: rooms.map(item=>item._id)}, startDate: {$gte: new Date()}, suspended: false});
        if(checkBooking.length > 0){
            return res.status(403).json({status: "error", message: "Hotel has future booking"});
        }
        const hotel = await hotelModel.findByIdAndDelete(req.params.id);
        if (!hotel) {
            return res.status(404).send({ error: 'Hotel not found' });
        }
        await hotelRoomModel.deleteMany({hotel: req.params.id});
        const filesUri = await FileModel.find({attachedId: req.params.id});
        filesUri.forEach((file)=>{
            fs.unlinkSync(file.path);
        })
        await FileModel.deleteMany({attachedId: req.params.id});
        await hotel.deleteOne();


        return res.send({ message: 'Hotel deleted successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).send({ error: 'Server error' });
    }
}

//imageId required in the body
const updateHotelImage = async (req, res) => {
    try{
        const id = req.params.id;
        const imageId = req.body.imageId;
        if(!id){
            return res.status(400).json({status: "error", message: "No hotel id"});
        }
        const hotel = await hotelModel.findById(id);
        if(!hotel||!hotel.owner.equals(req.user._id)){
            return res.status(403).json({status: "error", message: "Not permitted"});
        }
        const files = Object.values(req.files)[0];
        if(!files){
            return res.status(400).json({status: "error", message: "No image file"});
        }
        const file = files;
        if(!hotel.images.includes(imageId)){
            return res.status(400).json({status: "error", message: "No image id"});
        }
        const filemodel = FileModel.findById(imageId);
        if(!filemodel){
            return res.status(404).json({status: "error", message: "Not found"});
        }
        const newfilename = Date.now() + file.name;
        const newfilepath = path.join(__dirname, '../public/images/', newfilename);
        await file.mv(newfilepath, (err)=>{
            if(err){
                console.log(err);
                return res.status(503).json({status: "error", message: err.message});
            }
        });
        filemodel.path = newfilepath;
        await filemodel.save();
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

//provide hotel id and facility id in the params
// const deleteFacilities = async (req, res) => {
//     const { id,hotel } = req.params;
//     try {
//         const hotelcheck = await hotelModel.findById(hotel);
//         if(!hotelcheck||!hotelcheck.owner.equals(req.user._id)){
//             return res.status(403).json({status: "error", message: "Not permitted"});
//         }
//         await facilityModel.deleteOne({_id: id, service: hotel});
//         res.status(200).json({status: "success", message: "Deleted"});
//     }catch (e){
//         console.log(e.message);
//         return res.status(503).json({status: "error", message: e.message});
//     }
// }

module.exports = {fileUploadMiddleware, fileExtLimiterMiddleware, hotelController, getHotel,getHotelByQueries, updateHotelInfo, uploadHotelImage, deleteHotel, deleteHotelImage, updateHotelImage, getMaxPage};