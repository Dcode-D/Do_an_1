const UserModel = require("../models/user_model");
const bcrypt = require("bcrypt");

const getUserInforById = async (req, res) => {
    const {id} = req.params;
    try {
        const user = await UserModel.findById(id);
        if(!user){
            return res.status(404).json({
                message: "User not found",
                status: "error"
            });
        }
        return res.status(200).json({data: user});
    } catch (err) {
        console.log(err.message);
        return res.status(503).json({"message": err.message});
    }
}

//require user auth
const getUserFullUserInfo= async (req, res) => {
    try {
        if(!req.user){
            return res.status(401).json({"message": "Unauthorized"});
        }
        const user = await  UserModel.findById(req.user._id);
        if(!user){
            return res.status(404).json({"message": "User not found"});
        }
        if(!req.user._id.equals(user._id)){
            return res.status(401).json({"message": "Unauthorized"});
        }
        return res.status(200).json({data: user});
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({"message": e.message});
    }
}

//update address, phone, email, firstname, lastname, phonenumber,password
const updateUser = async (req, res) => {
    try {
        const {address, phone, email, firstname, lastname, phonenumber, password} = req.body;
        if(!req.user){
            return res.status(401).json({"message": "Unauthorized"});
        }
        const user = await  UserModel.findById(req.user._id);
        if(!user){
            return res.status(404).json({"message": "User not found"});
        }
        if(!req.user._id.equals(user._id)){
            return res.status(401).json({"message": "Unauthorized"});
        }
        if(address){
            user.address = address;
        }
        if(phone){
            user.phone = phone;
        }
        if(email){
            user.email = email;
        }
        if(firstname){
            user.firstname = firstname;
        }
        if(lastname){
            user.lastname = lastname;
        }
        if(phonenumber){
            user.phonenumber = phonenumber;
        }
        if(password){
            if(password.length<8){
                return res.status(400).json({"message": "Password too short"});
            }
            const hashedpassword = await bcrypt.hash(password,10);
            user.password = hashedpassword;
        }
        await user.save();
        return res.status(200).json({data: user});
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({"message": e.message});
    }
}

module.exports = {getUserInforById, getUserFullUserInfo, updateUser};