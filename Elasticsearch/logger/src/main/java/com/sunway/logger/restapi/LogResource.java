package com.sunway.logger.restapi;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.sunway.logger.service.LogService;

@RestController
@RequestMapping("/logger/v1/log")
public class LogResource {

    @Autowired
    private LogService logService;

    @RequestMapping(method = POST)
    public @ResponseBody boolean put(@RequestBody Log log) throws Exception {
        logService.put(log);
        return true;
    }

    @RequestMapping(value="/search", method = POST)
    public @ResponseBody String search(@RequestBody SearchBean criteria) throws Exception {
        return logService.search(criteria);
    }

}
