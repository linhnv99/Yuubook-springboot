package com.devpro.yuubook.models.dto;

import java.io.Serializable;

public class AjaxResponse implements Serializable {
	private static final long serialVersionUID = 4257760806710212969L;

	private Object obj;
	private int statusCode;

	public AjaxResponse() {
		super();
	}

	public AjaxResponse(Object obj, int statusCode) {
		super();
		this.obj = obj;
		this.statusCode = statusCode;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

	public int getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}
}
