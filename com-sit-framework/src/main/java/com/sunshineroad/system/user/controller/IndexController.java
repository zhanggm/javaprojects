package com.sunshineroad.system.user.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * @author users
 * @version 1.0
 */
@Controller("indexController")
public class IndexController {
    
    @RequestMapping(value = "/index1")
    public String index(HttpServletRequest request){
        return "index";
    }

}
