package com.sunway.logger.service;

import com.sunway.logger.restapi.Log;
import com.sunway.logger.restapi.SearchBean;

public interface LogService {

    public void put(Log log) throws Exception;

    public String search(SearchBean keyword) throws Exception;

}
