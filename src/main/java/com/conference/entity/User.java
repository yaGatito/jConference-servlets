package com.conference.entity;

public class User {
    private int id;
    /**
     * 1 - moder
     * 2 - speaker
     * 3 - listener
     */
    private int role;
    private String name;
    private String lastname;
    private String email;
    private String password;
    private boolean notifications = true;

    public User(int id, int role, String name, String lastname, String email, String password) {
        this.id = id;
        this.role = role;
        this.name = name;
        this.lastname = lastname;
        this.email = email;
        this.password = password;
    }

    public User(int role, String name, String lastname, String email, String password) {
        this.role = role;
        this.name = name;
        this.lastname = lastname;
        this.email = email;
        this.password = password;
    }

    public static String getNameRole(int i){
        switch (i){
            case 1:
                return "Moder";
            case 2:
                return "Speaker";
            case 3:
                return "Listener";
            default:
                throw new IllegalArgumentException();
        }
    }

    public boolean getNotify() {
        return notifications;
    }

    public void setNotify(boolean notifications) {
        this.notifications = notifications;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public int getRole() {
        return role;
    }
    public String getName() { return name; }

    public String getLastname() {
        return lastname;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof User)) return false;
        User user = (User) o;
        return this.id == user.id;
    }

    @Override
    public int hashCode() {
        return this.id;
    }

    @Override
    public String toString() {
        return name + " " +  lastname ;
    }
}
