package com.conference.bean;

public class Event {
    private int id;
    private String topic;
    private String description;
    private String fromtime;
    private String totime;
    private String date;
    private boolean isOnline;
    private Location location;
    private int speaker;
    private int status;

    public Event(int id, String topic, String description, int speaker, String fromtime, String totime, String date, String location) {
        this.id = id;
        setTopic(topic);
        setDescription(description);
        setTotime(totime);
        setFromtime(fromtime);
        setDate(date);
        setLocation(location);
        setSpeaker(speaker);
        checkStatus();
    }

    public Event(String topic, String description, int speaker, String fromtime, String totime, String date, String location) {
        setTopic(topic);
        setDescription(description);
        setTotime(totime);
        setFromtime(fromtime);
        setDate(date);
        setLocation(location);
        setSpeaker(speaker);
        checkStatus();
    }

    private void checkStatus(){
        if (!this.date.equals("n/a") && !this.location.getAddress().equals("n/a")){
            this.status = 3;
        }else if(this.speaker != -99 && this.speaker != 0){
            this.status = 2;
        }else{
            this.status = 1;
        }
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public boolean getCondition() {
        return isOnline;
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

    public Location getLocation() {
        return location;
    }

    public int getSpeaker() {
        return speaker;
    }

    public String getFromtime() {
        return fromtime;
    }

    public String getTotime() {
        return totime;
    }

    public void setFromtime(String fromtime) {
        fromtime = checkString(fromtime);
        this.fromtime = fromtime;
    }

    public void setTotime(String totime) {
        totime = checkString(totime);
        this.totime = totime;
    }

    public void setTopic(String topic) {
        topic = checkString(topic);
        this.topic = topic;
    }

    public void setDescription(String description) {
        description = checkString(description);
        this.description = description;
    }

    public void setDate(String date) {
        date = checkString(date);
        this.date = date;
    }

    public void setLocation(String location) {
        location = checkString(location);
        this.isOnline = location.contains("http") || location.contains("www");
        if (isOnline){
            this.location = Location.ONLINE(location);
        }else{
            this.location = Location.OFFLINE(location);
        }
    }

    public void setSpeaker(int speaker) {
        this.speaker = speaker;
    }

    @Override
    public String toString() {
        return topic+" by "+speaker;
    }

    private String checkString(String s){
        if (s == null){
            s = "n/a";
        }
        return s;
    }
}
