package com.conference.bean;

import javax.xml.crypto.Data;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;

public class Event {
//    public static void main(String[] args) {
//        Date date = Date.valueOf();
//        LocalDate localDate = LocalDate.now();
//    }

    private int id;
    private String topic;
    private String description;
    private Time time;
    private Date date;
    private boolean isOnline;
    private Location location;
    private User speaker;


    public Event(int id, String topic, String description, Time time, Date date, boolean isOnline, String location, User speaker) {
        this.id = id;
        this.topic = topic;
        this.description = description;
        this.time = time;
        this.date = date;
        this.isOnline = isOnline;
        if (isOnline){
            this.location = Location.ONLINE(location);
        }else{
            this.location = Location.OFFLINE(location);
        }
        this.speaker = speaker;
    }

    public Event(String topic, String description, Time time, Date date, boolean isOnline, String location, User speaker) {
        this.topic = topic;
        this.description = description;
        this.time = time;
        this.date = date;
        this.isOnline = isOnline;
        if (isOnline){
            this.location = Location.ONLINE(location);
        }else{
            this.location = Location.OFFLINE(location);
        }
        this.speaker = speaker;
    }

    public boolean getCondition() {
        return isOnline;
    }

    public void setCondition(boolean isOnline) {
        this.isOnline = isOnline;
        if (isOnline){
            this.location = Location.ONLINE(location.getAddress());
        }else{
            this.location = Location.OFFLINE(location.getAddress());
        }
    }

    public Time getTime() {
        return time;
    }

    public int getId() {
        return id;
    }

    public String getTopic() {
        return topic;
    }

    public String getDescription() {
        return description;
    }

    public Date getDate() {
        return date;
    }

    public Location getLocation() {
        return location;
    }

    public User getSpeaker() {
        return speaker;
    }

    public void setTime(Time time) {
        this.time = time;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public void setSpeaker(User speaker) {
        this.speaker = speaker;
    }

    @Override
    public String toString() {
        return topic+" by "+speaker;
    }
}
