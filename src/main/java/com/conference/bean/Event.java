package com.conference.bean;

public class Event {
    private int id;
    private String topic;
    private String description;
    private String time;
    private String date;
    private boolean isOnline;
    private Location location;
    private int speaker;

    public Event(int id, String topic, String description){
        this.id = id;
        this.topic = topic;
        this.description = description;
    }

    public Event( String topic, String description){
        this.topic = topic;
        this.description = description;
    }

    public Event(int id, String topic, String description, int speaker, String time, String date, boolean isOnline, String location) {
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

    public Event(String topic, String description, int speaker, String time, String date, boolean isOnline, String location) {
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

    public String getTime() {
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

    public String getDate() {
        return date;
    }

    public String getLocation() {
        return location.getAddress();
    }

    public int getSpeaker() {
        return speaker;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public void setSpeaker(int speaker) {
        this.speaker = speaker;
    }

    @Override
    public String toString() {
        return topic+" by "+speaker;
    }
}
