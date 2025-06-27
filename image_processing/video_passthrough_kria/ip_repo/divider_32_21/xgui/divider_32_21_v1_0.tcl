# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DIVIDEND_W" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DIVISOR_W" -parent ${Page_0}
  ipgui::add_param $IPINST -name "LATENCY" -parent ${Page_0}
  ipgui::add_param $IPINST -name "QUOTIENT_W" -parent ${Page_0}


}

proc update_PARAM_VALUE.DIVIDEND_W { PARAM_VALUE.DIVIDEND_W } {
	# Procedure called to update DIVIDEND_W when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DIVIDEND_W { PARAM_VALUE.DIVIDEND_W } {
	# Procedure called to validate DIVIDEND_W
	return true
}

proc update_PARAM_VALUE.DIVISOR_W { PARAM_VALUE.DIVISOR_W } {
	# Procedure called to update DIVISOR_W when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DIVISOR_W { PARAM_VALUE.DIVISOR_W } {
	# Procedure called to validate DIVISOR_W
	return true
}

proc update_PARAM_VALUE.LATENCY { PARAM_VALUE.LATENCY } {
	# Procedure called to update LATENCY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LATENCY { PARAM_VALUE.LATENCY } {
	# Procedure called to validate LATENCY
	return true
}

proc update_PARAM_VALUE.QUOTIENT_W { PARAM_VALUE.QUOTIENT_W } {
	# Procedure called to update QUOTIENT_W when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.QUOTIENT_W { PARAM_VALUE.QUOTIENT_W } {
	# Procedure called to validate QUOTIENT_W
	return true
}


proc update_MODELPARAM_VALUE.LATENCY { MODELPARAM_VALUE.LATENCY PARAM_VALUE.LATENCY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LATENCY}] ${MODELPARAM_VALUE.LATENCY}
}

proc update_MODELPARAM_VALUE.DIVIDEND_W { MODELPARAM_VALUE.DIVIDEND_W PARAM_VALUE.DIVIDEND_W } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DIVIDEND_W}] ${MODELPARAM_VALUE.DIVIDEND_W}
}

proc update_MODELPARAM_VALUE.DIVISOR_W { MODELPARAM_VALUE.DIVISOR_W PARAM_VALUE.DIVISOR_W } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DIVISOR_W}] ${MODELPARAM_VALUE.DIVISOR_W}
}

proc update_MODELPARAM_VALUE.QUOTIENT_W { MODELPARAM_VALUE.QUOTIENT_W PARAM_VALUE.QUOTIENT_W } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.QUOTIENT_W}] ${MODELPARAM_VALUE.QUOTIENT_W}
}

