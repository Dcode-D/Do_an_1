const UserModel = require("../models/user_model");

const getUserInforById = async (req, res) => {
    const {id} = req.params;
    try {
        const user = await UserModel.findById(id);
        if(!user){
            return res.status(404).json({
                username: user.username,
                email: user.email,
                firstname: user.firstname,
                lastname: user.lastname,
                gender: user.gender,
            });
        }
        return res.status(200).json(user);
    } catch (err) {
        console.log(err.message);
        return res.status(503).json({"message": err.message});
    }
}

//require user auth
const getUserFullUserInfoById = async (req, res) => {
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

module.exports = {getUserInforById, getUserFullUserInfoById}