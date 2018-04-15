package com.sunway.rest.common;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class Header {

	int errorCode;
	@JsonIgnore
	String templete;
	@JsonIgnore
	Object parms[];
	
	String message;

	public Header() {
		this.templete = "";
	}

	public int getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(int errorCode) {
		this.errorCode = errorCode;
	}

	public String getTemplete() {
		return templete;
	}

	public void setTemplete(String templete) {
		this.templete = templete;
	}

	public Object[] getParms() {
		return parms;
	}

	public void setParms(Object[] parms) {
		this.parms = parms;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getMessage() {
		return String.format(templete, parms);
	}

}