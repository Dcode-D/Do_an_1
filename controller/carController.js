const Car = require("../models/carServiceModel");
const path = require("path");
const FileModel = require("../models/files_model");
const fs = require("fs");
const fileExtLimiter = require("../middleware/file_ext_limiter");


const carFilesExtOptions = fileExtLimiter(['.jpg', '.png', '.jpeg', '.gif']);
//require login
const createCar = async (req, res) => {
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
        req.body.images = imglist;
        const car = await Car.create({...req.body, images: imglist, owner: req.user._id });
        res.status(201).json({ car });
    } catch(error) {
        console.error(error);
        res.status(500).json({ error: 'Server Error' });
    }
}
//apply params are page, maxPrice, minPrice,
const getCar = async (req, res) => {
    try {
        const {page, maxPrice, minPrice,} = req.query;
        const carQuery = Car.find({})
        if(maxPrice) {
            carQuery.where('pricePerDay').lte(maxPrice)
        }
        if(minPrice) {
            carQuery.where('pricePerDay').gte(minPrice)
        }
        if(page){
            carQuery.skip((page-1)*10).limit(10)
        }
        const cars = await carQuery.exec();
        res.status(200).json({ cars });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Server Error' });
    }
}

const getCarById = async (req, res) => {
    try {
        const car = await Car.findById(req.params.id);
        res.status(200).json({ car });
    } catch(error) {
        console.error(error);
        res.status(500).json({ error: 'Server Error' });
    }
}
//require login
const updateCar = async (req, res) => {
    try {
        const carcheck = await Car.findById(req.params.id);
        if (carcheck.owner.equals(req.user._id)) {
            const car = await Car.findByIdAndUpdate(req.params.id, { $set: req.body }, { new: true });
            res.status(200).json({ car });
        } else {
            res.status(401).json({ error: 'Unauthorized access' });
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Server Error' });
    }
}
//require login
const deleteCar = async (req, res) => {
    try {
        const carcheck = await Car.findById(req.params.id);
        if (carcheck.owner.equals(req.user._id)) {
            const deletedcar = await Car.findByIdAndDelete(req.params.id);
            if(deletedcar.images){
                deletedcar.images.forEach(async (image)=>{
                    const filetodelete = await FileModel.findByIdAndDelete(image);
                    fs.unlinkSync(filetodelete.path);
                })
            }
            res.json({ message: 'Car deleted successfully' });
        }
        else {
            res.status(401).json({ error: 'Unauthorized access' });
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Server Error' });
    }
}

const updateCarImage = async (req,res)=>{
    try {
        if (req.params.id) {
            let car = await Car.findOne({_id: req.params.id});
            if(!car||!car.owner.equals(req.user._id)){
                return res.status(403).json({status: "error", message: "Not permitted"});
            }
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

                car.images = [...car.images, ...imglist];
                return res.status(200).send('Hotel image uploaded');
            }
            else {
                return res.status(400).json({status: "error", message: "No image uploaded"});
            }
        } else {
            return res.status(400).json({status: "error", message: "No car id"});
        }
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const deleteCarImage = async (req,res)=>{
    try {
        if (req.params.id) {
            let car = await Car.findOne({_id: req.params.id});
            if(!car||!car.owner.equals(req.user._id)){
                return res.status(403).json({status: "error", message: "Not permitted"});
            }
            if (req.body.imageId) {
                const imageId = req.body.imageId;
                const index = car.images.indexOf(imageId);
                if (index > -1) {
                    car.images.splice(index, 1);
                    const filetoDelete = await FileModel.findById(imageId);
                    if(filetoDelete){
                        const uri = filetoDelete.path;
                        fs.unlinkSync(uri)
                        await filetoDelete.deleteOne();
                    }
                }
                await car.save();
                return res.status(200).send('Car image deleted');
            }
            else {
                return res.status(400).json({status: "error", message: "No image id"});
            }
        } else {
            return res.status(400).json({status: "error", message: "No car id"});
        }
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}


module.exports = {createCar, getCar, getCarById, updateCar, deleteCar, updateCarImage, deleteCarImage, carFilesExtOptions};