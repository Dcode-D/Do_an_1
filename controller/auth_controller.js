const userModel = require('../models/user_model')
const jwtModel = require('../models/jwt_model')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')

const auth_controller = async (req,res)=>{
    const {username,password,device} = req.body;
    if(username&&password&&device){
        try {
            const user = await userModel.findOne({'username': username});
            if(user){
                const result = await bcrypt.compare(password,user.password);
                if(result){
                    const accesstoken = jwt.sign({
                        "username":user.username,
                        "id":user._id,
                        "device":device
                    }, process.env.ACCESS_TOKEN_SECRET, {expiresIn: '1d'});
                    const jwtmodel = new jwtModel({
                        jwtdata:accesstoken,
                        revoked:false,
                        userid:user._id
                    });
                    try{
                        await jwtmodel.save();
                    }
                    catch (err){
                        return res.status(500).json({"message":"Internal server error"});
                    }
                    return res.status(200).json({"auth":accesstoken});
                }
                else {
                    return res.status(401).json({"message":"Invalid password"});
                }
            }
            else {
                return res.status(401).json({"message":"username not found"});
            }
        }catch (e){
            return res.status(503).json({"message":"bad request"});
        }
    }
    else {
            return res.status(503).json({"message":"bad request"});
    }
}

module.exports = auth_controller