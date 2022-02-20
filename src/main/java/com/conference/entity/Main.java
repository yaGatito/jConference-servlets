package com.conference.entity;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Main {

    public static final Logger logger = LoggerFactory.getLogger(Main.class);

    public static void asd(){
        logger.info("SUCCESSFUL INSERTING LECTURE - TOPIC:{}, SPEAKER:{}, EVENT:{}, SPEAKER:{}","topic","status","event","speaker");
    }

    public static void main(String[] args) {
        asd();
    }
}
