package com.sunway.rest.common;

public class RestResponse<R> {

	private Header header = new Header();

	private R body;

	public RestResponse(R body) {
		this.body = body;
	}

	public Header getHeader() {
		return header;
	}

	public void setHeader(Header header) {
		this.header = header;
	}

	public R getBody() {
		return body;
	}

	public void setBody(R body) {
		this.body = body;
	}

}

