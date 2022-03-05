package com.conference.entity;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Event implements Comparable<Event> {
    private static final Map<String,Comparator<Event>> comparators;
    static {
        comparators = new HashMap<>();
        comparators.put("date",Event.comparatorByDate());
        comparators.put("lectures",Event.comparatorByLectures());
        comparators.put("listeners",Event.comparatorByListeners());
        comparators.put("default",Event.comparatorByDefault());
    }

    private int id;
    private String topic;
    private List<Tag> tags;
    private String fromtime;
    private String totime;
    private String date;
    private boolean isOnline;
    private Location location;
    private List<Lecture> lectures;
    private int listeners;
    /**
     * 0 - past event
     * 1 - future event
     */
    private int status;


    public Event(int id, String topic, List<Tag> tags, String fromtime, String totime, String date, String location, int status) {
        this.id = id;
        this.topic = topic;
        this.tags = tags;
        this.fromtime = fromtime;
        this.totime = totime;
        this.date = date;
        setLocation(location);
        this.status = status;
    }

    public Event(String topic, List<Tag> tags, String fromtime, String totime, String date, String location, int status) {
        this.topic = topic;
        this.tags = tags;
        this.fromtime = fromtime;
        this.totime = totime;
        this.date = date;
        setLocation(location);
        this.status = status;
    }

    public static Map<String, Comparator<Event>> getComparators() {
        return comparators;
    }

    public int getListeners() {
        return listeners;
    }

    public void setListeners(int listeners) {
        this.listeners = listeners;
    }

    public List<Lecture> getLectures() {
        if (lectures==null){
            lectures = new ArrayList<>();
        }
        return lectures;
    }

    public List<Tag> getTags() {
        return tags;
    }

    public void setTags(List<Tag> tags) {
        this.tags = tags;
    }

    public void setLectures(List<Lecture> lectures) {
        this.lectures = lectures;
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

    public static Comparator<Event> comparatorByDate(){
        return new Comparator<Event>() {
            @Override
            public int compare(Event o1, Event o2) {
                return o1.date.concat(o1.fromtime).compareTo(o2.date.concat(o2.fromtime));
            }
        };
    }

    public static Comparator<Event> comparatorByListeners(){
        return new Comparator<Event>() {
            @Override
            public int compare(Event o1, Event o2) {
                return Integer.compare(o1.listeners, o2.listeners);
            }
        };
    }

    public static Comparator<Event> comparatorByLectures(){
        return new Comparator<Event>() {
            @Override
            public int compare(Event o1, Event o2) {
                return Integer.compare(o1.lectures.size(),o2.lectures.size());
            }
        };
    }

    public static Comparator<Event> comparatorByDefault(){
        return new Comparator<Event>() {
            @Override
            public int compare(Event o1, Event o2) {
                return o1.compareTo(o2);
            }
        };
    }

    @Override
    public int compareTo(Event o) {
        return Integer.compare(this.id,o.id);
    }


    /**
     * Returns an array. First element of which contains only past events.
     * Second element of which contains today and future events.
     * @param events list which will be filtered to past and future
     * @return array
     */
    public static List<Event>[] filter(List<Event> events){
        List<Event> past = new ArrayList<>();
        List<Event> future = new ArrayList<>();
        LocalDate today = LocalDate.now();
        LocalTime timeNow = LocalTime.of(LocalTime.now().getHour(), LocalTime.now().getMinute());
        for (Event event : events) {
            String[] strings = event.getDate().split("-");
            LocalDate eventDate = LocalDate.of(Integer.parseInt(strings[0]),Integer.parseInt(strings[1]),Integer.parseInt(strings[2]));
            strings = event.getFromtime().split(":");
            LocalTime timeEvent = LocalTime.of(Integer.parseInt(strings[0]),Integer.parseInt(strings[1]));
            if (eventDate.compareTo(today)>0 || (eventDate.compareTo(today)==0 && timeEvent.compareTo(timeNow)>=0)){
                future.add(event);
            } else{
                past.add(event);
            }
        }
        return new List[]{past,future};
    }
}
