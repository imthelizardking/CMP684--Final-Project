# CMP684--Final-Project

# ROADMAP

Phase-0:
- Create DcMotorBasic
- Create PI_CurrentBasic
- Train NN_CurrentBasic with DcMotorBasic+PI_CurrentBasic
- Clone PI_CurrentBasic to PI_Velo_Basic 
- Train NN_CurrentBasic clone NN_CurrentVelo with DcMotorBasic+NN_CurrentBasic+PI_Velo_Basic
- Clone PI_CurrentBasic to PI_Pos_Basic
- Train NN_CurrentBasic clone NN_CurrentPos with DcMotorBasic+NN_CurrentBasic+NN_CurrentVelo+PI_Pos_Basic
- Evaluate Cascaded Control Performance

Phase-1:
- Create feedforward control structure
- Train with this structure
- Evaluate Cascaded Feedforward Control Performance

Phase-2:
- Extend plant model to gun-turret by adding reducer+gun-turret
- Train with this structure
- Evaluate

Phase-3:
- Change DcMotorBasic to DcMotorBrushless (start over if necessary)
- Train with this structure
- Evaluate

Phase-4:
- Copy structure from Phase-3 to other axis with modifications
- Train
- Evaluate

Extras:
- Try combined and distinct Neurocontrollers for PI and feedforward path
- Try adding disturbances
- Try adding uncertanities
- Try adding noise
- Try combining position, velocity and current controllers
