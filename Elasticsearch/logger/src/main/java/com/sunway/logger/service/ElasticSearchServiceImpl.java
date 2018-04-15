package com.sunway.logger.service;

import java.io.IOException;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sunway.logger.RestEndpointConfig;
import com.sunway.logger.rest.HttpPostClient;
import com.sunway.logger.restapi.Log;
import com.sunway.logger.restapi.SearchBean;

@Service
public class ElasticSearchServiceImpl implements LogService {

    private final Logger LOG = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private HttpPostClient httpPostClient;

    @Autowired
    private RestEndpointConfig config;

    @Override
    public void put(Log log) throws Exception {
        String url = config.getContextPath() + "/" + log.getProjectName() + "/" + log.getLogLevel();
        String data = String.format("{\"content\": \"%s\"}", log.getContent());

        if (LOG.isDebugEnabled()) {
            LOG.debug(url);
            LOG.debug(data);
        }

        httpPostClient.execute(url, data, new ResponseHandler<String>() {

            @Override
            public String handleResponse(HttpResponse response) throws ClientProtocolException, IOException {
                String stringResp = EntityUtils.toString(response.getEntity());

                if (LOG.isDebugEnabled()) {
                    LOG.debug(stringResp);
                }

                return stringResp;
            }
        });

    }

    @Override
    public String search(SearchBean keyword) throws Exception {

        String url = config.getContextPath() + "/" + keyword.getProjectName() + "/" + keyword.getLogLevel()
                + "/_search";
        String data = String.format("{\"query\" : { \"match\" : { \"content\" : \"%s\" }}}", keyword.getKeyword());

        if (LOG.isDebugEnabled()) {
            LOG.debug(url);
            LOG.debug(data);
        }

        return httpPostClient.execute(url, data, new ResponseHandler<String>() {

            @Override
            public String handleResponse(HttpResponse response) throws ClientProtocolException, IOException {
                String stringResp = EntityUtils.toString(response.getEntity());

                if (LOG.isDebugEnabled()) {
                    LOG.debug(stringResp);
                }

                return stringResp;
            }
        });

    }

}
