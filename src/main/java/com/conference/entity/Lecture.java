package com.conference.entity;

public class Lecture {
    private int id;
    private String topic;
    /**
     * -1 - rejected
     * 0 - free to choose;
     * 1 - request
     * 2 - offered
     * 3 - secured;
     */
    private int status;
    private int event;
    private int speaker;

    public Lecture(String topic, int status, int event, int speaker) {
        this.topic = topic;
        this.status = status;
        this.event = event;
        this.speaker = speaker;
    }

    public Lecture(int id, String topic, int status, int event, int speaker) {
        this.id = id;
        this.topic = topic;
        this.status = status;
        this.event = event;
        this.speaker = speaker;
    }

    public int getId() { return id; }

    public String getTopic() { return topic; }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getEvent() {
        return event;
    }

    public void setEvent(int event) {
        this.event = event;
    }

    public int getSpeaker() {
        return speaker;
    }

    public void setSpeaker(int speaker) {
        this.speaker = speaker;
    }

    @Override
    public String toString() {
        return "["+id+"] " + topic;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Lecture)) return false;
        Lecture lecture = (Lecture) o;
        return getId() == lecture.getId();
    }

    @Override
    public int hashCode() {
        return this.id;
    }
}
