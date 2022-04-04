package com.conference.entities;

public class Location {
    private boolean isOnline;
    private String address;
    private String shortName;

    public static Location ONLINE(String address){
        return new Location(true, address);
    }

    public static Location OFFLINE(String address){
        return new Location(false, address);
    }

    private Location(boolean isOnline, String address) {
        this.isOnline = isOnline;
        this.address = address;
        reg();
    }

    public boolean getFlag() {
        return isOnline;
    }

    public String getAddress() {
        return address;
    }

    public String getShortName() {
        return shortName;
    }

    private void reg(){
        if (isOnline){
            String[] arr = address.split("[^\\w]+");
            if (arr[1].equals("www")){
                shortName = arr[2] + "." + arr[3];
            }else{
                shortName = arr[1] + "." + arr[2];
            }
        }else{
            shortName = address;
        }
    }
}
