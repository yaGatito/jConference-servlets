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
    /**
     * 0 - past event
     * 1 - future event
     */
    private int status;

    public Event(int id, String topic, String description, String fromtime, String totime, String date, String location, int status) {
        this.id = id;
        this.topic = topic;
        this.description = description;
        this.fromtime = fromtime;
        this.totime = totime;
        this.date = date;
        setLocation(location);
        this.status = status;
    }

    public Event(String topic, String description, String fromtime, String totime, String date, String location, int status) {
        this.topic = topic;
        this.description = description;
        this.fromtime = fromtime;
        this.totime = totime;
        this.date = date;
        setLocation(location);
        this.status = status;
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

    @Override
    public String toString() {
        return topic;
    }

    private String checkString(String s){
        if (s == null){
            s = "n/a";
        }
        return s;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Event)) return false;
        Event event = (Event) o;
        return this.id == event.id;
    }

    @Override
    public int hashCode() {
        return this.id;
    }
}
